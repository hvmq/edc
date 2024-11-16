import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:styled_text/styled_text.dart';

import '../../../../../core/all.dart';
import '../../../../base/all.dart';
import '../../../../common_widgets/all.dart';
import '../../../../resource/resource.dart';
import '../../../../routing/routing.dart';
import '../../../all.dart';

class RegisterView extends BaseView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);

  // Widget _buildEmailOrPhoneInput() {
  //   return Padding(
  //     padding: EdgeInsets.only(bottom: 30.h),
  //     child: SwitchButton(
  //       values: const ['Email', 'Phone'],
  //       buttonPadding: EdgeInsets.symmetric(
  //         horizontal: 28.w,
  //         vertical: 10.h,
  //       ),
  //       onChange: (value) {
  //         ViewUtil.hideKeyboard(Get.context!);
  //         if (value == 'Email') {
  //           controller.setRegisterKind = RegisterKind.email;
  //           controller.emailFocus.requestFocus();
  //         } else {
  //           controller.setRegisterKind = RegisterKind.phone;
  //           controller.phoneFocus.requestFocus();
  //         }
  //       },
  //       currentValue: controller.registerKind.value == RegisterKind.email
  //           ? 'Email'
  //           : 'Phone',
  //     ),
  //   );
  // }

  Widget _buildRegisterBtn(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 30.h),
      child: AppButton.secondary(
        color: AppColors.button5,
        label: context.l10n.button__continue,
        width: double.infinity,
        onPressed: () async {
          // showBottomSheetChooseNumber(context);
          showBottomSheetLoginVia(
            context,
            'number',
          );

          // controller.showLoading();
          // await Get.offNamed(Routes.resetPassword, arguments: {
          //   'phone': controller.phoneController.value.text,
          //   'flowFrom': 'register',
          // });
        },
        isLoading: controller.isLoading,
        isDisabled: controller.isDisableReceiveBtn.value,
      ),
    );
  }

  // Widget _buildTextFieldPhone() {
  //   return Padding(
  //     padding: EdgeInsets.only(bottom: 28.h),
  //     child: AppTextField(
  //       focusNode: controller.phoneFocus,
  //       autofocus: true,
  //       textInputAction: TextInputAction.done,
  //       controller: controller.phoneController,
  //       hintText: l10n.field_phone__hint,
  //       hintStyle: AppTextStyles.s16w400.copyWith(
  //         color: AppColors.subText2,
  //         fontStyle: FontStyle.italic,
  //       ),
  //       label: l10n.field_phone__label,
  //       contentPadding: EdgeInsets.all(17.w),
  //       keyboardType: TextInputType.phone,
  //       validator: controller.validatePhone,
  //       onChanged: (value) {
  //         controller.setDisableOtpReceiveBtn =
  //             !controller.formKey.currentState!.validate();
  //       },
  //       autovalidateMode: AutovalidateMode.onUserInteraction,
  //     ),
  //   );
  // }

  // Widget _buildTextFieldEmail() {
  //   return Padding(
  //     padding: EdgeInsets.only(bottom: 28.h),
  //     child: Column(
  //       children: [
  //         AppTextField(
  //           focusNode: controller.emailFocus,
  //           inputFormatters: [LowerCaseTextFormatter()],
  //           autofocus: true,
  //           controller: controller.emailController,
  //           hintText: l10n.field_email__hint,
  //           hintStyle: AppTextStyles.s16w400.copyWith(
  //             color: AppColors.subText2,
  //             fontStyle: FontStyle.italic,
  //           ),
  //           label: l10n.field_email__label,
  //           textInputAction: TextInputAction.done,
  //           contentPadding: EdgeInsets.all(17.w),
  //           keyboardType: TextInputType.emailAddress,
  //           validator: controller.validateEmail,
  //           onChanged: (value) {
  //             controller.setDisableOtpReceiveBtn =
  //                 !controller.formKey.currentState!.validate();
  //           },
  //           autovalidateMode: AutovalidateMode.onUserInteraction,
  //         ),
  //         AppSpacing.gapH16,
  //         AppTextField(
  //           inputFormatters: [LowerCaseTextFormatter()],
  //           controller: controller.referralIdController,
  //           label: l10n.field__referralId,
  //           textInputAction: TextInputAction.done,
  //           contentPadding: EdgeInsets.all(17.w),
  //           keyboardType: TextInputType.text,
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildTextWelcome() => Padding(
        padding: AppSpacing.edgeInsetsV20,
        child: Center(
          child: Text(
            Get.context!.l10n.text_welcome_register,
            style: AppTextStyles.s16w600,
          ),
        ),
      );

  Widget _buildLoginWithGG(BuildContext context) => Padding(
        padding: EdgeInsets.symmetric(vertical: 30.h),
        child: AppButton.secondary(
          boderColor: AppColors.border3,
          label: Get.context!.l10n.button_continue_gg,
          textStyleLabel:
              AppTextStyles.s16Base.copyWith(fontWeight: FontWeight.w600),
          icon: Assets.icons.ggLogo.image(),
          width: double.infinity,
          onPressed: () async {
            final GoogleSignIn googleSignIn = (Platform.isAndroid)
                ? GoogleSignIn(scopes: ['email'])
                : GoogleSignIn();
            await googleSignIn.signOut();
            final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
            final authentication = await googleUser!.authentication;
            final accessToken = authentication.accessToken!;
            await controller.loginBy3rd(
              accessToken,
              'email',
              context,
              controller,
              null,
            );
          },
        ),
      );

  Widget _buildLoginWithApple(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 30.0),
        child: AppButton.secondary(
          boderColor: AppColors.border3,
          label: Get.context!.l10n.button_continue_apple,
          textStyleLabel:
              AppTextStyles.s16Base.copyWith(fontWeight: FontWeight.w600),
          icon: Assets.images.appleLogo.image(),
          width: double.infinity,
          onPressed: () {
            controller.signInWithApple(
              context,
              controller,
            );
          },
        ),
      );

  Widget _buildDivide() => Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 30.h),
        child: Row(
          children: [
            const Expanded(
              child: Divider(
                color: AppColors.border2,
              ),
            ),
            AppSpacing.gapW12,
            Text(
              Get.context!.l10n.or,
              style: AppTextStyles.s16Base.copyWith(
                color: AppColors.border2,
              ),
            ),
            AppSpacing.gapW12,
            const Expanded(
              child: Divider(
                color: AppColors.border2,
              ),
            ),
          ],
        ),
      );

  Widget _buildTextLogin() {
    return Padding(
      padding: EdgeInsets.only(top: 0.05.sh),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            Get.context!.l10n.text_have_account,
            style: AppTextStyles.s18w600.copyWith(color: AppColors.border2),
          ),
          AppSpacing.gapW4,
          GestureDetector(
            onTap: () {
              Get.offNamed(Routes.login);
            },
            child: Text(
              Get.context!.l10n.button__sign_in,
              style: AppTextStyles.s18w600.text5Color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextFieldPhone(BuildContext context) => AppTextField(
        enabled: false,
        controller: controller.phoneController.value,
        hintText: l10n.field_phone__hint,
        label: l10n.field_phone__label,
        hintStyle: AppTextStyles.s16w400.text6Color,
        fillColor: AppColors.backgroundTextField,
        border: const OutlineInputBorder(
          borderSide:
              BorderSide(color: AppColors.backgroundTextField, width: 0.5),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        prefixIcon: AppIcon(
          icon: AppIcons.call,
        ),
        contentPadding: EdgeInsets.all(17.w),
      ).paddingOnly(bottom: Sizes.s16).clickable(() {
        showBottomSheetChooseNumber(context);
      });

  Widget _buildTermsAndConditionsCheckbox() {
    return Padding(
      padding: AppSpacing.edgeInsetsOnlyBottom16,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(
            () => Checkbox(
              value: controller.isAgree.value,
              onChanged: (_) => controller.isAgree.toggle(),
              activeColor: AppColors.primary,
              checkColor: AppColors.white,
            ),
          ),
          Expanded(
            child: StyledText(
              text: l10n.register__terms_and_conditions,
              style: AppTextStyles.s14w400.text1Color,
              tags: {
                'terms': StyledTextActionTag(
                  (_, __) {},
                  style: AppTextStyles.s14w400.toColor(AppColors.button5),
                ),
                'conditions': StyledTextActionTag(
                  (_, __) {},
                  style: AppTextStyles.s14w400.toColor(AppColors.button5),
                ),
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget buildPage(BuildContext context) {
    return CommonScaffold(
      hideKeyboardWhenTouchOutside: true,
      backgroundLayer: true,
      appBar: CommonAppBar(
        titleType: AppBarTitle.text,
        text: context.l10n.button__sign_up,
        titleTextStyle: AppTextStyles.s20w600.text5Color,
        leadingIconColor: AppColors.button5,
      ),
      body: Obx(
        () => SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.w),
            child: Form(
              key: controller.formKey,
              child: Column(
                children: [
                  // _buildEmailOrPhoneInput(),
                  // controller.registerKind.value == RegisterKind.email
                  //     ?
                  // _buildTextFieldEmail(),
                  // : _buildTextFieldPhone(),
                  SizedBox(
                    height: 0.05.sh,
                  ),
                  _buildTextFieldPhone(context),
                  _buildRegisterBtn(context),
                  _buildDivide(),
                  _buildTextWelcome(),
                  _buildLoginWithGG(context),
                  if (Platform.isIOS && controller.isAppleSignInAvailable.value)
                    _buildLoginWithApple(context),

                  // _buildTermsAndConditionsCheckbox(),

                  _buildTextLogin(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showBottomSheetChooseNumber(BuildContext context) =>
      showCupertinoModalBottomSheet(
        expand: true,
        context: context,
        topRadius: const Radius.circular(20),
        builder: (context) => BottomSheetChooseNumber(
          controller: controller,
          type: 'number',
          currentId: controller.currentId,
          email: controller.email,
        ),
      ).then((value) {
        if (value != null) {
          controller.setTextFieldPhone(value);
          controller.setDisableOtpReceiveBtn(false);
        }
      });

  void showBottomSheetLoginVia(
    BuildContext context,
    String type,
  ) =>
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return BottomSheetLoginVia(type: type);
        },
      );
}
