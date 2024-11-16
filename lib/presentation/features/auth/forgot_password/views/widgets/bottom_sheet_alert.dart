import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../../core/all.dart';
import '../../../../../common_widgets/all.dart';
import '../../../../../resource/resource.dart';
import '../../../../../routing/routing.dart';

class BottomSheetAlert extends StatelessWidget {
  const BottomSheetAlert({super.key});

  @override
  Widget build(BuildContext context) {
    Widget buildInfomation() => Row(
          children: [
            SizedBox(
              height: 48.h,
              width: 48.w,
              child: ClipOval(
                child: Image.network(
                  'https://lh3.googleusercontent.com/ZvbTH3mz6XJAaUIKbQ2BnEz66R0NoWogcictifHmWr43rf6Sz9xDYdQazcnb7JuyVddbT3Fv_bvO31mtSMD1U-uLl95v2M6RBEoypOJ9_CqdT6kN=w960-rj-nu-e365',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            AppSpacing.gapW12,
            const Text(
              'tracisilva@gmail.com',
              style: AppTextStyles.s16Base,
            ),
          ],
        );

    Widget buildContainerAlert() => Container(
          padding: AppSpacing.edgeInsetsAll12,
          margin: AppSpacing.edgeInsetsV20,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            color: Colors.white.withOpacity(0.04),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppIcon(
                icon: AppIcons.alertIcon,
                size: 48,
                color: AppColors.alertIcon,
              ),
              AppSpacing.gapH12,
              Text(
                Get.context!.l10n.alert_title,
                style: AppTextStyles.s18Base,
              ),
              Text(
                Get.context!.l10n.alert_description,
                style: AppTextStyles.s16Base.copyWith(color: AppColors.border2),
              ),
            ],
          ),
        );

    Widget buildTextLoginAnother() => RichText(
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                text: Get.context!.l10n.text_not,
                style: AppTextStyles.s18w400.copyWith(color: AppColors.border2),
              ),
              TextSpan(
                text: 'tracisilva@gmail.com? ',
                style: AppTextStyles.s18w400.copyWith(color: AppColors.border2),
              ),
              TextSpan(
                text: Get.context!.l10n.text_login_another,
                recognizer: TapGestureRecognizer()..onTap = () {},
                style: AppTextStyles.s18w400.copyWith(color: AppColors.button5),
              ),
            ],
          ),
        );

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xff252531), Color(0xff11101C)],
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              context.l10n.alert,
              style: AppTextStyles.s20Base,
            ),
          ),
          AppSpacing.gapH20,
          Text(
            context.l10n.login_as,
            style: AppTextStyles.s20Base,
          ),
          AppSpacing.gapH12,
          buildInfomation(),
          buildContainerAlert(),
          AppButton.secondary(
            color: AppColors.button5,
            label: context.l10n.button__continue,
            width: double.infinity,
            onPressed: () async {
              await Get.offNamed(Routes.resetPassword, arguments: {
                'email': 'email',
                'otp': 'otpController.text',
                'flowFrom': 'forgot',
              });
            },
          ),
          AppSpacing.gapH12,
          buildTextLoginAnother(),
          AppSpacing.gapH12,
        ],
      ),
    );
  }
}
