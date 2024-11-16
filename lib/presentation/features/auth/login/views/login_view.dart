import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../core/all.dart';
import '../../../../../models/all.dart';
import '../../../../base/all.dart';
import '../../../../common_widgets/all.dart';
import '../../../../resource/resource.dart';
import '../../../../routing/routers/app_pages.dart';
import '../../../all.dart';

class LoginView extends BaseView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  // Widget _buildTextFieldEmail() {
  //   return Padding(
  //     padding: EdgeInsets.only(bottom: 16.h),
  //     child: AppTextField(
  //       autofocus: true,
  //       inputFormatters: [LowerCaseTextFormatter()],
  //       focusNode: controller.emailFocus,
  //       controller: controller.emailController,
  //       label: l10n.field__email_label,
  //       hintText: l10n.field_email__hint,
  //       hintStyle: AppTextStyles.s16w400.copyWith(
  //         color: AppColors.subText2,
  //         fontStyle: FontStyle.italic,
  //       ),
  //       textInputAction: TextInputAction.next,
  //       validator: (value) {
  //         if (controller.validateEmail(value!).isNotEmpty) {
  //           return controller.validateEmail(value);
  //         }

  //         return null;
  //       },
  //       autovalidateMode: AutovalidateMode.onUserInteraction,
  //       onChanged: (value) {
  //         if (controller
  //                 .validatePassword(controller.passwordController.text)
  //                 .isEmpty &&
  //             controller.validateEmail(value).isEmpty) {
  //           controller.setDisableLoginBtn = false;
  //         }
  //       },
  //     ),
  //   );
  // }

  Widget _buildTextFieldPassword() {
    return Padding(
      padding: EdgeInsets.only(bottom: 15.h),
      child: AppTextField(
        controller: controller.passwordController,
        fillColor: AppColors.backgroundTextField,
        border: const OutlineInputBorder(
          borderSide:
              BorderSide(color: AppColors.backgroundTextField, width: 0.5),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        label: l10n.field__password_label,
        hintText: l10n.field__password_hint,
        hintStyle: AppTextStyles.s16w400.text6Color,
        prefixIcon: AppIcon(
          icon: AppIcons.lock,
        ),
        textInputAction: TextInputAction.done,
        obscureText: controller.isHidePassword.value,
        suffixIcon: AppIcon(
          icon: controller.isHidePassword.value
              ? AppIcons.eyeOff
              : AppIcons.eyeOn,
        ),
        onSuffixIconPressed: () {
          controller.isHidePassword.toggle();
        },
        validator: (value) {
          if (controller.validatePassword(value!).isNotEmpty) {
            return controller.validatePassword(value);
          }

          return null;
        },
        onChanged: (value) {
          if (controller.appController.lastLoggedUser != null &&
              controller.validatePassword(value).isEmpty) {
            controller.setDisableLoginBtn = false;
          } else if (controller.validatePassword(value).isEmpty &&
              (controller
                      .validateEmail(controller.emailController.text)
                      .isEmpty ||
                  controller.phoneController.text.isNotEmpty)) {
            controller.setDisableLoginBtn = false;
          }
        },
        autovalidateMode: AutovalidateMode.onUserInteraction,
      ),
    );
  }

  Widget _buildLoginBtn(User? user) {
    return AppButton.secondary(
      color: AppColors.button5,
      label: l10n.button__sign_in,
      width: double.infinity,
      onPressed: () {
        Get.toNamed(Routes.home);
      },
      // isLoading: controller.isLoading,
      // isDisabled: controller.isDisableLoginBtn.value,
    );
  }

  Widget _buildForgotPassword(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 48.h),
      child: GestureDetector(
        onTap: () {
          Get.toNamed(Routes.resetPassword);
        },
        child: Text(l10n.button__forgot_password,
            style: AppTextStyles.s14w600.text5Color),
      ),
    );
  }

  Widget _buildCreateNew() {
    return Padding(
      padding: EdgeInsets.only(top: 0.05.sh),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            l10n.new_here,
            style: AppTextStyles.s18w600.copyWith(color: AppColors.border2),
          ),
          AppSpacing.gapW4,
          GestureDetector(
            onTap: () {
              Get.toNamed(Routes.register);
            },
            child: Text(
              l10n.button__sign_up,
              style: AppTextStyles.s18w600.text5Color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextWelcome() => Padding(
        padding: AppSpacing.edgeInsetsV20,
        child: Center(
          child: Text(
            l10n.text_welcome_login,
            style: AppTextStyles.s18Base.copyWith(color: AppColors.border2),
          ),
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
              l10n.text_or,
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

  Widget _buildLoginWithGG(BuildContext context) => GetBuilder(
        init: RegisterController(),
        builder: (controllerRegister) => AppButton.secondary(
          boderColor: AppColors.border3,
          label: l10n.button_continue_gg,
          textStyleLabel:
              AppTextStyles.s16Base.copyWith(fontWeight: FontWeight.w600),
          icon: Assets.icons.ggLogo.image(),
          width: double.infinity,
          onPressed: () async {},
        ),
      );

  Widget _buildLoginWithApple(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 30.0, top: 16),
        child: GetBuilder(
          init: RegisterController(),
          builder: (controllerRegister) {
            return AppButton.secondary(
              label: Get.context!.l10n.button_continue_apple,
              boderColor: AppColors.border3,
              textStyleLabel:
                  AppTextStyles.s16Base.copyWith(fontWeight: FontWeight.w600),
              icon: Assets.images.appleLogo.image(),
              width: double.infinity,
              onPressed: () {
                controller.signInWithApple(context, controllerRegister);
              },
            );
          },
        ),
      );

  @override
  Widget buildPage(BuildContext context) {
    return CommonScaffold(
      hideKeyboardWhenTouchOutside: true,
      backgroundLayer: true,
      appBar: CommonAppBar(
        titleType: AppBarTitle.text,
        text: l10n.button__sign_in,
        titleTextStyle: AppTextStyles.s20w600.text5Color,
        leadingIconColor: AppColors.button5,
        onLeadingPressed: () {
          final canPop = Navigator.of(context).canPop();
          if (canPop) {
            Get.back();
          } else {
            Get.offAllNamed(Routes.authOption);
          }
        },
      ),
      body: Obx(
        () => SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // _buildTextWelcome(),
                SizedBox(
                  height: 0.05.sh,
                ),
                _buildLoginNotUser(),
                _buildForgotPassword(context),
                _buildLoginBtn(null),
                _buildDivide(),
                _buildLoginWithGG(context),
                if (Platform.isIOS && controller.isAppleSignInAvailable.value)
                  _buildLoginWithApple(context),
                _buildCreateNew(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginNotUser() {
    return Column(
      children: [
        _buildTextFieldPhone(),
        Form(key: controller.formKey, child: _buildTextFieldPassword()),
      ],
    );
  }

  // Widget _buildLoginAsUser(User user) {
  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: [
  //       SizedBox(height: 120.h),
  //       AppCircleAvatar(
  //         size: 84.w,
  //         url: user.avatarPath ?? '',
  //       ),
  //       Text(
  //         l10n.global__hello,
  //         style: AppTextStyles.s14w400.copyWith(color: AppColors.subText2),
  //       ).paddingOnly(top: Sizes.s12, bottom: Sizes.s12),
  //       Text(
  //         user.nickname ?? user.fullName,
  //         style: AppTextStyles.s24w600,
  //       ).paddingOnly(bottom: Sizes.s12),
  //       _buildTextFieldPassword(),
  //       _buildBtnChangeAccount(),
  //       _buildLoginBtn(user),
  //     ],
  //   );
  // }

  // Padding _buildBtnChangeAccount() {
  //   return Padding(
  //     padding: const EdgeInsets.only(bottom: Sizes.s20),
  //     child: GestureDetector(
  //       onTap: () {
  //         controller.appController.setLoggedUser(null);
  //       },
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           Container(
  //             margin: const EdgeInsets.only(right: Sizes.s12),
  //             padding: const EdgeInsets.all(Sizes.s8),
  //             decoration: const BoxDecoration(
  //               gradient: LinearGradient(
  //                 colors: AppColors.button2,
  //                 begin: Alignment.topCenter,
  //                 end: Alignment.bottomCenter,
  //               ),
  //               shape: BoxShape.circle,
  //             ),
  //             child: AppIcon(
  //               icon: AppIcons.changeAccount,
  //             ),
  //           ),
  //           Text(
  //             l10n.login__change_account,
  //             style: AppTextStyles.s16w500,
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

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
  //         controller.setDisableLoginBtn = true;
  //         controller.passwordController.clear();
  //         controller.emailController.clear();
  //         controller.phoneController.clear();

  //         ViewUtil.hideKeyboard(Get.context!);
  //         if (value == 'Email') {
  //           controller.setLoginKind = LoginKind.email;
  //           controller.emailFocus.requestFocus();
  //         } else {
  //           controller.setLoginKind = LoginKind.phone;
  //           controller.phoneFocus.requestFocus();
  //         }
  //       },
  //       currentValue:
  //           controller.loginKind.value == LoginKind.email ? 'Email' : 'Phone',
  //     ),
  //   );
  // }

  Widget _buildTextFieldPhone() => AppTextField(
        controller: controller.phoneController,
        hintText: l10n.field_phone__hint,
        label: l10n.field_phone__label,
        keyboardType: TextInputType.phone,
        hintStyle: AppTextStyles.s16w400.text6Color,
        fillColor: AppColors.backgroundTextField,
        border: const OutlineInputBorder(
          borderSide:
              BorderSide(color: AppColors.backgroundTextField, width: 0.5),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        onChanged: (value) {
          controller.phoneLogin.value = value;
        },
        prefixIcon: AppIcon(
          icon: AppIcons.call,
        ),
        contentPadding: EdgeInsets.all(17.w),
      ).paddingOnly(bottom: Sizes.s16);

  // Widget _buildTextFieldPhone() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Padding(
  //         padding: const EdgeInsets.only(left: Sizes.s4),
  //         child: SizedBox(
  //           height: 24.h,
  //           child: Text(
  //             l10n.field_phone__label,
  //             style: AppTextStyles.s16w400.text1Color,
  //           ),
  //         ),
  //       ),
  //       AppSpacing.gapH8,
  //       InternationalPhoneNumberInput(
  //         initialValue: PhoneNumber(isoCode: controller.initIsoCode.value),
  //         keyboardAction: TextInputAction.done,
  //         formatInput: false,
  //         textAlignVertical: TextAlignVertical.top,
  //         spaceBetweenSelectorAndTextField: 0,
  //         textFieldController: controller.phoneController,
  //         focusNode: controller.phoneFocus,
  //         selectorConfig: const SelectorConfig(
  //           selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
  //           leadingPadding: Sizes.s12,
  //           useBottomSheetSafeArea: true,
  //           setSelectorButtonAsPrefixIcon: true,
  //           trailingSpace: false,
  //         ),
  //         selectorTextStyle: AppTextStyles.s16w400.text1Color,
  //         textStyle: AppTextStyles.s16w400.text1Color,
  //         onInputChanged: (value) {
  //           controller.setDisableLoginBtn = !value.parseNumber().isNotEmpty;

  //           controller.phoneLogin.value = value.phoneNumber ?? '';

  //           if (controller.initIsoCode.value != value.isoCode) {
  //             controller.initIsoCode.value = value.isoCode ?? 'VN';
  //             controller.phoneController.clear();
  //           }
  //         },
  //         // validator: (value) {
  //         //   if (value != null && value.isEmpty) {
  //         //     return l10n.field_phone__error_invalid;
  //         //   }
  //         //   return null;
  //         // },
  //         // errorMessage: l10n.field_phone__error_invalid,
  //         // autoValidateMode: AutovalidateMode.onUserInteraction,
  //         inputDecoration: InputDecoration(
  //           fillColor: Colors.transparent,
  //           filled: true,
  //           hintText: l10n.field_phone__hint,
  //           contentPadding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
  //           hintStyle: AppTextStyles.s16w400.copyWith(color: AppColors.border2),
  //           errorStyle: AppTextStyles.s14Base.negativeColor,
  //           errorMaxLines: 2,
  //           border: const OutlineInputBorder(
  //             borderSide: BorderSide(color: AppColors.border2, width: 0.5),
  //             borderRadius: BorderRadius.all(Radius.circular(100)),
  //           ),
  //           enabledBorder: const OutlineInputBorder(
  //             borderSide: BorderSide(color: AppColors.border2, width: 0.5),
  //             borderRadius: BorderRadius.all(Radius.circular(100)),
  //           ),
  //           disabledBorder: const OutlineInputBorder(
  //             borderSide: BorderSide(color: AppColors.border2, width: 0.5),
  //             borderRadius: BorderRadius.all(Radius.circular(100)),
  //           ),
  //           focusedBorder: const OutlineInputBorder(
  //             borderSide: BorderSide(color: AppColors.border2, width: 0.5),
  //             borderRadius: BorderRadius.all(Radius.circular(100)),
  //           ),
  //           errorBorder: const OutlineInputBorder(
  //             borderSide: BorderSide(color: AppColors.border2, width: 0.5),
  //             borderRadius: BorderRadius.all(Radius.circular(100)),
  //           ),
  //         ),
  //       ),
  //     ],
  //   ).paddingOnly(bottom: Sizes.s16);
  // }
}
