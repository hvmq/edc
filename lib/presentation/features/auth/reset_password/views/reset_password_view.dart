import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../../core/all.dart';
import '../../../../base/all.dart';
import '../../../../common_widgets/all.dart';
import '../../../../resource/resource.dart';
import '../../register/views/widgets/create_account_success.dart';
import '../controllers/reset_password_controller.dart';

class ResetPasswordView extends BaseView<ResetPasswordController> {
  const ResetPasswordView({Key? key}) : super(key: key);

  @override
  bool get allowLoadingIndicator => false;

  Widget _buildTextFieldPasswordOld() => Padding(
        padding: EdgeInsets.only(bottom: 28.h),
        child: AppTextField(
          autofocus: true,
          controller: controller.passwordOldController,
          fillColor: Colors.transparent,
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.border2, width: 0.5),
            borderRadius: BorderRadius.all(Radius.circular(100)),
          ),
          label: l10n.old_pass_title,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.text,
          // validator: controller.validatePassword,
          obscureText: controller.isShowOldPassword.value,
          onChanged: (value) {
            // controller.setDisableSubmitBtn =
            //     !controller.formKey.currentState!.validate();
            controller.validatePassword(value);
            if (controller.formKey.currentState!.validate() &&
                controller.is8Lenght.value &&
                controller.isValidator.value) {
              controller.setDisableSubmitBtn = false;
            } else {
              controller.setDisableSubmitBtn = true;
            }
          },
          hintText: Get.context!.l10n.hint_old_pass,
          hintStyle: AppTextStyles.s16w400.copyWith(color: AppColors.border2),
          prefixIcon: AppIcon(
            icon: AppIcons.lock,
          ),
          suffixIcon: AppIcon(
            icon: controller.isShowOldPassword.value
                ? AppIcons.eyeOff
                : AppIcons.eyeOn,
          ),
          onSuffixIconPressed: () {
            controller.isShowOldPassword.toggle();
          },
        ),
      );

  Widget _buildTextFieldPassword() {
    return Padding(
      padding: EdgeInsets.only(bottom: 28.h),
      child: AppTextField(
        autofocus: true,
        controller: controller.passwordController,
        fillColor: Colors.transparent,
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.border2, width: 0.5),
          borderRadius: BorderRadius.all(Radius.circular(100)),
        ),
        label: l10n.field_password__label,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.text,
        // validator: controller.validatePassword,
        obscureText: controller.isShowPassword.value,
        onChanged: (value) {
          // controller.setDisableSubmitBtn =
          //     !controller.formKey.currentState!.validate();
          controller.validatePassword(value);
          if (controller.formKey.currentState!.validate() &&
              controller.is8Lenght.value &&
              controller.isValidator.value) {
            controller.setDisableSubmitBtn = false;
          } else {
            controller.setDisableSubmitBtn = true;
          }
        },
        hintText: Get.context!.l10n.hint_new_pass,
        hintStyle: AppTextStyles.s16w400.copyWith(color: AppColors.border2),
        prefixIcon: AppIcon(
          icon: AppIcons.lock,
        ),
        suffixIcon: AppIcon(
          icon: controller.isShowPassword.value
              ? AppIcons.eyeOff
              : AppIcons.eyeOn,
        ),
        onSuffixIconPressed: () {
          controller.isShowPassword.toggle();
        },
      ),
    );
  }

  Widget _buildTextFieldConfirmPassword() {
    return Padding(
      padding: EdgeInsets.only(bottom: 40.h),
      child: AppTextField(
        autofocus: true,
        controller: controller.confirmPasswordController,
        fillColor: Colors.transparent,
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.border2, width: 0.5),
          borderRadius: BorderRadius.all(Radius.circular(100)),
        ),
        label: l10n.hint_confirm_pass,
        contentPadding: EdgeInsets.all(17.w),
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.done,
        validator: controller.validateConfirmPassword,
        obscureText: controller.isShowConfirmPassword.value,
        onChanged: (value) {
          if (controller.formKey.currentState!.validate() &&
              controller.is8Lenght.value &&
              controller.isValidator.value) {
            controller.setDisableSubmitBtn = false;
          } else {
            controller.setDisableSubmitBtn = true;
          }
        },
        hintText: Get.context!.l10n.hint_confirm_pass,
        hintStyle: AppTextStyles.s16w400.copyWith(color: AppColors.border2),
        prefixIcon: AppIcon(
          icon: AppIcons.lock,
        ),
        suffixIcon: AppIcon(
          icon: controller.isShowConfirmPassword.value
              ? AppIcons.eyeOff
              : AppIcons.eyeOn,
        ),
        onSuffixIconPressed: () {
          controller.isShowConfirmPassword.toggle();
        },
      ),
    );
  }

  Widget _buildSubmitBtn(BuildContext context) {
    return AppButton.secondary(
      color: AppColors.button5,
      label: context.l10n.button__continue,
      width: double.infinity,
      onPressed: () {
        Get.to(() => const CreateAccountSuccess());
      },
      isLoading: controller.isLoading,
    );
  }

  Widget _buildValidator() => Column(
        children: [
          ListTile(
            leading: AppIcon(
              icon: AppIcons.checkBroken,
              color: controller.isValidator.value
                  ? AppColors.done
                  : AppColors.border2,
            ),
            title: Text(
              Get.context!.l10n.validate_text,
              style: AppTextStyles.s16Base.copyWith(
                color: controller.isValidator.value
                    ? AppColors.done
                    : AppColors.border2,
              ),
            ),
          ),
          ListTile(
            leading: AppIcon(
              icon: AppIcons.checkBroken,
              color: controller.is8Lenght.value
                  ? AppColors.done
                  : AppColors.border2,
            ),
            title: Text(
              Get.context!.l10n.validate_lenght,
              style: AppTextStyles.s16Base.copyWith(
                color: controller.is8Lenght.value
                    ? AppColors.done
                    : AppColors.border2,
              ),
            ),
          ),
        ],
      );

  Widget _buildTextFieldPhone() => AppTextField(
        enabled: false,
        initialValue: controller.phone,
        fillColor: Colors.transparent,
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.border2, width: 0.5),
          borderRadius: BorderRadius.all(Radius.circular(100)),
        ),
        contentPadding: EdgeInsets.all(17.w),
        prefixIcon: AppIcon(
          icon: AppIcons.call,
        ),
        suffixIcon: AppIcon(
          icon: AppIcons.checkBroken,
          color: AppColors.done,
        ),
      );
  // Widget _buildTextFieldPhone() => InternationalPhoneNumberInput(
  //       isEnabled: false,
  //       initialValue: PhoneNumber(isoCode: 'VN', phoneNumber: '8886186299'),
  //       // keyboardAction: TextInputAction.done,
  //       // formatInput: false,
  //       // textAlignVertical: TextAlignVertical.top,
  //       // spaceBetweenSelectorAndTextField: 0,
  //       // textFieldController: controller.phoneController,
  //       // focusNode: controller.phoneFocus,
  //       selectorConfig: const SelectorConfig(
  //         selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
  //         leadingPadding: Sizes.s12,
  //         useBottomSheetSafeArea: true,
  //         setSelectorButtonAsPrefixIcon: true,
  //         trailingSpace: false,
  //       ),
  //       selectorTextStyle: AppTextStyles.s16w400.text1Color,
  //       textStyle: AppTextStyles.s16w400.text1Color,
  //       onInputChanged: (value) {
  //         // controller.setDisableOtpReceiveBtn = !value.parseNumber().isNotEmpty;

  //         // controller.phoneRegister.value = value.phoneNumber ?? '';

  //         // if (controller.initIsoCode.value != value.isoCode) {
  //         //   controller.initIsoCode.value = value.isoCode ?? 'VN';
  //         //   controller.phoneController.clear();
  //         // }
  //       },
  //       // validator: (value) {
  //       // if (value != null && value.isEmpty) {
  //       //   return l10n.field_phone__error_invalid;
  //       // }
  //       // },
  //       errorMessage: l10n.field_phone__error_invalid,
  //       autoValidateMode: AutovalidateMode.onUserInteraction,
  //       inputDecoration: InputDecoration(
  //         fillColor: Colors.transparent,
  //         filled: true,
  //         hintText: l10n.field_phone__hint,
  //         contentPadding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
  //         hintStyle: AppTextStyles.s16w400.copyWith(color: AppColors.border2),
  //         errorStyle: AppTextStyles.s14Base.negativeColor,
  //         errorMaxLines: 2,
  //         border: const OutlineInputBorder(
  //           borderSide: BorderSide(color: AppColors.border2, width: 0.5),
  //           borderRadius: BorderRadius.all(Radius.circular(100)),
  //         ),
  //         enabledBorder: const OutlineInputBorder(
  //           borderSide: BorderSide(color: AppColors.border2, width: 0.5),
  //           borderRadius: BorderRadius.all(Radius.circular(100)),
  //         ),
  //         disabledBorder: const OutlineInputBorder(
  //           borderSide: BorderSide(color: AppColors.border2, width: 0.5),
  //           borderRadius: BorderRadius.all(Radius.circular(100)),
  //         ),
  //         focusedBorder: const OutlineInputBorder(
  //           borderSide: BorderSide(color: AppColors.border2, width: 0.5),
  //           borderRadius: BorderRadius.all(Radius.circular(100)),
  //         ),
  //         errorBorder: const OutlineInputBorder(
  //           borderSide: BorderSide(color: AppColors.border2, width: 0.5),
  //           borderRadius: BorderRadius.all(Radius.circular(100)),
  //         ),
  //       ),
  //     );

  Widget _buildTextDescription() => Padding(
        padding: AppSpacing.edgeInsetsV12,
        child: Text(
          Get.context!.l10n.text_description_reset_pass,
          style: AppTextStyles.s16Base.copyWith(
            color: AppColors.border2,
          ),
        ),
      );
  @override
  Widget buildPage(BuildContext context) {
    return CommonScaffold(
      appBar: CommonAppBar(
        titleType: AppBarTitle.text,
        text: controller.flowFrom == 'change'
            ? l10n.change_pass
            : context.l10n.create_pass,
        titleTextStyle: AppTextStyles.s20w600.text5Color,
        leadingIconColor: AppColors.button5,
        onLeadingPressed: () async {
          try {
            if (controller.flowFrom == 'forgot') {
              final GoogleSignIn googleSignIn = (Platform.isAndroid)
                  ? GoogleSignIn(scopes: ['email'])
                  : GoogleSignIn();
              await googleSignIn.disconnect();
            }
          } catch (e) {
            log(e.toString());
          } finally {
            Get.back();
          }
        },
      ),
      body: Obx(
        () => SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: controller.formKey,
              child: Column(
                children: [
                  controller.flowFrom == 'change'
                      ? _buildTextFieldPasswordOld()
                      : const SizedBox.shrink(),
                  // _buildTextDescription(),
                  _buildTextFieldPassword(),
                  _buildValidator(),
                  _buildTextFieldConfirmPassword(),
                  _buildSubmitBtn(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
