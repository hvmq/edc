import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/all.dart';
import '../../../../../models/enums/subscription_type_enum.dart';
import '../../../../../models/subscription.dart';
import '../../../../common_widgets/all.dart';
import '../../../../resource/resource.dart';
import '../../all.dart';

class ChooseTypePremium extends StatefulWidget {
  final Subscription subscription;
  final PackageStatusEnum packageStatus;
  const ChooseTypePremium({
    required this.subscription,
    required this.packageStatus,
    super.key,
  });

  @override
  State<ChooseTypePremium> createState() => _ChooseTypePremiumState();
}

class _ChooseTypePremiumState extends State<ChooseTypePremium> {
  int index = 0;
  bool isPro = false;
  final eDCPremiumController = Get.find<EDCPremiumController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      isPro = widget.subscription.name.toString() == 'PRO';

      try {
        if (eDCPremiumController.currentSubscription.value != null) {
          if (eDCPremiumController.currentSubscription.value!.cycle <= 32) {
            index = 0;
          } else {
            index = 1;
          }
        }
      } catch (e) {
        LogUtil.e(e);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      appBar: CommonAppBar(
        centerTitle: false,
        titleType: AppBarTitle.none,
        titleWidget: Text(
          'Back',
          style: AppTextStyles.s16w500,
        ).clickable(() {
          Get.back();
        }),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Container(
                height: 100,
                width: 100,
                padding: AppSpacing.edgeInsetsAll8,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomLeft: Radius.circular(12)),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: isPro
                        ? [const Color(0xff0DF9F0), const Color(0xff7A06EF)]
                        : [const Color(0xff93D58B), const Color(0xff1553D6)],
                  ),
                ),
                child: Assets.images.monthly.image(),
              ),
              Expanded(
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(12),
                        bottomRight: Radius.circular(12)),
                    gradient: LinearGradient(
                      begin: Alignment.centerRight,
                      end: Alignment.centerLeft,
                      colors: isPro
                          ? [const Color(0xff0DF9F0), const Color(0xff7A06EF)]
                          : [const Color(0xff1553D6), const Color(0xff93D58B)],
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppSpacing.gapW12,
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'MONTHLY PAYMENT',
                            style: AppTextStyles.s14w700.text2Color,
                          ),
                          Text(
                            '${widget.subscription.priceMonthly}VND / month',
                            style: AppTextStyles.s14w500.text2Color
                                .copyWith(fontSize: 13),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: index == 0
                                  ? AppColors.blue3
                                  : Colors.white.withOpacity(0.5),
                            ),
                            color: index == 0
                                ? AppColors.blue3
                                : const Color(0xff567596),
                            shape: BoxShape.circle),
                        child: AppIcon(
                          icon: Icons.check,
                          color: index == 0 ? Colors.white : Colors.transparent,
                          size: 12,
                        ),
                      ),
                      AppSpacing.gapW12,
                    ],
                  ),
                ),
              ),
            ],
          ).clickable(() {
            if (widget.packageStatus == PackageStatusEnum.paymentRequired) {
              return;
            }
            setState(() {
              index = 0;
            });
          }),
          AppSpacing.gapH20,
          Row(
            children: [
              Container(
                height: 100,
                width: 100,
                padding: AppSpacing.edgeInsetsAll8,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomLeft: Radius.circular(12)),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: isPro
                        ? [const Color(0xff0DF9F0), const Color(0xff7A06EF)]
                        : [const Color(0xff93D58B), const Color(0xff1553D6)],
                  ),
                ),
                child: Assets.images.annual.image(),
              ),
              Expanded(
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(12),
                        bottomRight: Radius.circular(12)),
                    gradient: LinearGradient(
                      begin: Alignment.centerRight,
                      end: Alignment.centerLeft,
                      colors: isPro
                          ? [const Color(0xff0DF9F0), const Color(0xff7A06EF)]
                          : [const Color(0xff1553D6), const Color(0xff93D58B)],
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppSpacing.gapW12,
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'ANNUAL PAYMENT',
                            style: AppTextStyles.s14w700.text2Color,
                          ),
                          Text(
                            '${widget.subscription.priceYearly}VND / year',
                            style: AppTextStyles.s14w500.text2Color
                                .copyWith(fontSize: 13),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: index == 1
                                  ? AppColors.blue3
                                  : Colors.white.withOpacity(0.5),
                            ),
                            color: index == 1
                                ? AppColors.blue3
                                : const Color(0xff567596),
                            shape: BoxShape.circle),
                        child: AppIcon(
                          icon: Icons.check,
                          color: index == 1 ? Colors.white : Colors.transparent,
                          size: 12,
                        ),
                      ),
                      AppSpacing.gapW12,
                    ],
                  ),
                ),
              ),
            ],
          ).clickable(() {
            if (widget.packageStatus == PackageStatusEnum.paymentRequired) {
              return;
            }
            setState(() {
              index = 1;
            });
          }),
          const Spacer(),
          if (widget.packageStatus == PackageStatusEnum.expired ||
              widget.packageStatus == PackageStatusEnum.view) ...[
            AppSpacing.gapH20,
            _buildButton(
              isDisable: false,
              text: 'Buy',
              onTap: () {
                eDCPremiumController.purchaseSubscription(
                  widget.subscription.code,
                  index == 0
                      ? SubscriptionTypePeriodEnum.monthly
                      : SubscriptionTypePeriodEnum.yearly,
                );
              },
            ),
          ],
          if (widget.packageStatus == PackageStatusEnum.paymentRequired) ...[
            AppSpacing.gapH20,
            _buildButton(
              isDisable: false,
              text: 'Get Paidment QR',
              onTap: () {
                eDCPremiumController.getPayment();
              },
            ),
          ],
          if (widget.packageStatus == PackageStatusEnum.valid) ...[
            AppSpacing.gapH20,
            _buildButton(
              isDisable: false,
              text: 'Upgrade now',
              onTap: () {
                eDCPremiumController.upgradeSubscription(
                  widget.subscription.code,
                  index == 0
                      ? SubscriptionTypePeriodEnum.monthly
                      : SubscriptionTypePeriodEnum.yearly,
                );
              },
            ),
            AppSpacing.gapH20,
            _buildButton(
              isDisable: false,
              text: 'Cancel',
              onTap: () {
                eDCPremiumController.cancelSubscription();
              },
            ),
          ],
          AppSpacing.gapH20,
        ],
      ).paddingSymmetric(horizontal: 20),
    );
  }

  Widget _buildButton({
    required bool isDisable,
    required String text,
    required Function() onTap,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 0.5),
          borderRadius: BorderRadius.circular(100),
          color: isDisable ? AppColors.disable : AppColors.button5),
      child: Center(
        child: Text(text, style: AppTextStyles.s16w500.text2Color),
      ),
    ).clickable(
      () {
        if (isDisable) return;
        onTap();
      },
    );
  }
}
