import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../../core/all.dart';
import '../../../../../common_widgets/all.dart';
import '../../../../../resource/resource.dart';
import '../../../../../routing/routers/app_pages.dart';
import '../../../../all.dart';

class BottomSheetLoginVia extends StatelessWidget {
  final String type;
  final LoginController? loginController;
  final ForgotPasswordController? forgotPasswordController;
  const BottomSheetLoginVia({
    required this.type,
    super.key,
    this.loginController,
    this.forgotPasswordController,
  });

  Widget _buildLoginWithGG(BuildContext context) =>
      GetBuilder<RegisterController>(
        init: RegisterController(),
        builder: (controller) => Padding(
          padding: EdgeInsets.symmetric(vertical: 30.h),
          child: AppButton.secondary(
            boderColor: AppColors.border3,
            label: context.l10n.button_continue_gg,
            textStyleLabel: AppTextStyles.s16Base,
            icon: Assets.icons.ggLogo.image(),
            width: double.infinity,
            onPressed: () async {
              Get.toNamed(Routes.resetPassword);
            },
          ),
        ),
      );

  Widget _buildLoginWithApple(BuildContext context) => GetBuilder(
        init: RegisterController(),
        builder: (controller) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 30.0),
            child: AppButton.secondary(
              label: Get.context!.l10n.button_continue_apple,
              textStyleLabel: AppTextStyles.s16Base,
              icon: Assets.images.appleLogo.image(),
              width: double.infinity,
              boderColor: AppColors.border3,
              onPressed: () {
                Get.back();
                controller.signInWithApple(
                  context,
                  controller,
                  isRegisterPhone: true,
                );
              },
            ),
          );
        },
      );

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(Sizes.s20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Sizes.s20),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: AppColors.background10,
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppIcon(
                  icon: AppIcons.arrowLeft,
                  color: AppColors.button5,
                ).clickable(() {
                  Get.back();
                }),
                Text(
                  type == 'forgot'
                      ? context.l10n.auth__forgot_password
                      : context.l10n.button__continue,
                  style: AppTextStyles.s20w500.text5Color,
                ),
                AppSpacing.gapW24
              ],
            ),
            // const AppDivider(),
            AppSpacing.gapH20,
            Text(
              type == 'forgot'
                  ? context.l10n.auth__remind_change_your_password
                  : context.l10n.text_login_gg,
              style: AppTextStyles.s16Base.copyWith(color: AppColors.border2),
            ),
            _buildLoginWithGG(context),
            if (Platform.isIOS) _buildLoginWithApple(context),
          ],
        ),
      ),
    );
  }
}
