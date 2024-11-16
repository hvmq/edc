import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/all.dart';
import '../../../../models/enums/subscription_type_enum.dart';
import '../../../../models/subscription.dart';
import '../../../base/all.dart';
import '../../../common_widgets/all.dart';
import '../../../resource/resource.dart';
import '../all.dart';
import 'widgets/choose_type_premium.dart';

class EDCPremiumView extends BaseView<EDCPremiumController> {
  const EDCPremiumView({Key? key}) : super(key: key);

  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                controller.onRefresh();
              },
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    _buildPersonalGroup().paddingSymmetric(vertical: 20),
                    _buildBusinesGroup().paddingOnly(bottom: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 110,
      width: 1.sw,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/background-appbar-premium.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppSpacing.gapW24,
          Text('EDC Premium', style: AppTextStyles.s18w700.text2Color),
          AppIcon(
            icon: AppIcons.close,
            color: Colors.white,
            onTap: () {
              Get.back();
            },
          ),
        ],
      ).paddingOnly(left: 20, right: 20, top: 20),
    );
  }

  Widget _buildPackageSection(String title, Object icon) {
    return Row(
      children: [
        Container(
          width: 3,
          height: 24,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: const Color(0xff369C09),
          ),
        ),
        AppSpacing.gapW8,
        AppIcon(icon: icon),
        AppSpacing.gapW8,
        Text(title, style: AppTextStyles.s18w700.text1Color),
      ],
    ).paddingOnly(left: 20, right: 20);
  }

  Widget _buildLogicPackageCard({
    required Subscription package,
  }) {
    final featureText = getPackageFeatureText(package);
    final bool isFree = package.priceMonthly + package.priceYearly == 0;

    PackageStatusEnum packageStatus;
    if (controller.currentSubscription.value == null) {
      if (isFree) {
        packageStatus = PackageStatusEnum.valid;
      } else {
        packageStatus = PackageStatusEnum.view;
      }
    } else {
      if (package.id == controller.currentSubscription.value!.subscriptionId) {
        packageStatus = controller.currentSubscriptionStatus.value!;
      } else {
        packageStatus = PackageStatusEnum.view;
      }
    }

    if (isFree) {
      packageStatus = PackageStatusEnum.valid;
    }

    var buttonText = '';
    var buttonEvent = () {
      Get.to(
        () => ChooseTypePremium(
          subscription: package,
          packageStatus: packageStatus,
        ),
        transition: Transition.cupertino,
      );
    };
    if (isFree) {
      buttonEvent = () {};
    }

    switch (packageStatus) {
      case PackageStatusEnum.valid:
        buttonText = 'Owned';

        break;
      case PackageStatusEnum.view:
        buttonText = 'Details';

        break;
      case PackageStatusEnum.expired:
        buttonText = 'Details';

        break;
      case PackageStatusEnum.paymentRequired:
        buttonText = 'Go to payment';

        break;
      case PackageStatusEnum.cancel:
        buttonText = 'Details';
        break;
    }

    if (package.type == SubscriptionTypeEnum.personal.toShortString()) {
      if (isFree) {
        return _buildPackageCard(
          title: package.name,
          subtitle: 'FREE',
          onTap: buttonEvent,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          gradientColors: const [Color(0xff48A4BE), Color(0xff05447C)],
          features: featureText,
          buttonText: buttonText,
        );
      }
      return _buildPackageCard(
        title: package.name,
        subtitle: '2 price options',
        onTap: buttonEvent,
        begin: Alignment.centerRight,
        end: Alignment.centerLeft,
        gradientColors: const [Color(0xff0DF9F0), Color(0xff7A06EF)],
        features: featureText,
        buttonText: buttonText,
        backgroundImage: Assets.images.backgroundPro,
      );
    }
    return _buildPackageCard(
      title: package.name,
      subtitle: '2 price options',
      onTap: buttonEvent,
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      gradientColors: const [Color(0xff60B984), Color(0xff032469)],
      features: featureText,
      buttonText: buttonText,
      buttonGradientColors: const [Color(0xff6abe71), Color(0xff3b9d51)],
      backgroundGradientColors: [
        const Color(0xff1553D6),
        const Color(0xff93D58B),
      ],
    );
  }

  Widget _buildPackageCard({
    required String title,
    required String subtitle,
    required List<Color> gradientColors,
    required List<String> features,
    required String buttonText,
    required AlignmentGeometry begin,
    required AlignmentGeometry end,
    required Function onTap,
    AssetGenImage? backgroundImage,
    List<Color>? buttonGradientColors,
    List<Color>? backgroundGradientColors,
  }) {
    return Container(
      margin: AppSpacing.edgeInsetsH20,
      child: Column(
        children: [
          Container(
            padding: AppSpacing.edgeInsetsAll12,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              gradient: LinearGradient(colors: gradientColors),
            ),
            child: Row(
              children: [
                Text(title, style: AppTextStyles.s14w700.text2Color),
                AppSpacing.gapW8,
                Text('•', style: AppTextStyles.s14w700.text2Color),
                AppSpacing.gapW8,
                Text(subtitle, style: AppTextStyles.s14w700.text2Color),
              ],
            ),
          ),
          const Divider(height: 1, color: Colors.white),
          Container(
            decoration: BoxDecoration(
              image: backgroundImage != null
                  ? const DecorationImage(
                      image: AssetImage('assets/images/background-pro.png'),
                    )
                  : null,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
              gradient: LinearGradient(
                begin: begin,
                end: end,
                colors: backgroundGradientColors ?? gradientColors,
              ),
            ),
            child: Stack(
              children: [
                // const Positioned(bottom: -100, child: MovingContainer()),
                // if (backgroundImage != null)
                //   Transform.translate(
                //       offset: Offset(0.25.sw, 0),
                //       child: backgroundImage.image()),
                Padding(
                  padding: AppSpacing.edgeInsetsAll12,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...features.map((feature) => _buildFeatureRow(feature)),
                      _buildButton(buttonText,
                              buttonGradientColors ?? gradientColors)
                          .clickable(() {
                        onTap();
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureRow(String feature) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppIcon(icon: Icons.check, color: Colors.white),
          AppSpacing.gapW8,
          Expanded(
            child: Text(feature, style: AppTextStyles.s16w500.text2Color),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String text, List<Color> gradientColors) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 0.5),
        borderRadius: BorderRadius.circular(100),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: gradientColors,
        ),
      ),
      child: Center(
        child: Text(text, style: AppTextStyles.s16w500.text2Color),
      ),
    );
  }

  Widget _buildPersonalGroup() {
    return Column(children: [
      _buildPackageSection('Personal Package', Assets.images.basicFree),
      Obx(
        () => ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.subscriptionsPersonal.value.length,
            itemBuilder: (BuildContext context, int index) {
              final Subscription package =
                  controller.subscriptionsPersonal.value[index];
              return _buildLogicPackageCard(package: package)
                  .marginOnly(bottom: 20);
            }),
      ),
    ]);
  }

  Widget _buildBusinesGroup() {
    return Column(children: [
      _buildPackageSection('Business Package', Assets.images.bussiness),
      Obx(
        () => ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.subscriptionsBusiness.value.length,
            itemBuilder: (BuildContext context, int index) {
              final Subscription package =
                  controller.subscriptionsBusiness.value[index];
              return _buildLogicPackageCard(package: package)
                  .marginOnly(bottom: 20);
            }),
      ),
    ]);
  }

  List<String> getPackageFeatureText(Subscription subscription) {
    String value = subscription.description;
    switch (subscription.description) {
      case 'premium__description__personal_basic':
        value = l10n.premium__description__personal_basic;
        break;
      case 'premium__description_business':
        value = l10n.premium__description_business;
        break;
      case 'premium__description_personal_pro':
        value = l10n.premium__description_personal_pro;
        break;
      default:
        value = subscription.description;
    }
    return value.split('\n');
  }
}
