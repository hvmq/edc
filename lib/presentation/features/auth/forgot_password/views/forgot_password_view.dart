import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../core/all.dart';
import '../../../../base/all.dart';
import '../../../../common_widgets/all.dart';
import '../../../../resource/styles/styles.dart';
import '../../../all.dart';

class ForgotPasswordView extends BaseView<ForgotPasswordController> {
  const ForgotPasswordView({Key? key}) : super(key: key);

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
  //           controller.setForgotSendKind = ForgotSendKind.email;
  //           controller.emailFocus.requestFocus();
  //         } else {
  //           controller.setForgotSendKind = ForgotSendKind.phone;
  //           controller.phoneFocus.requestFocus();
  //         }
  //       },
  //       currentValue: controller.selectKind.value == ForgotSendKind.email
  //           ? 'Email'
  //           : 'Phone',
  //     ),
  //   );
  // }

  Widget _buildSubmitBtn(BuildContext context) {
    return AppButton.secondary(
      color: AppColors.button5,
      label: l10n.button__continue,
      width: double.infinity,
      // onPressed: controller.resetPassword,
      onPressed: () {
        showBottomSheetLoginVia(context, 'forgot');
      },
      // isLoading: controller.isLoading,
      // isDisabled: controller.isDisableReceiveBtn.value,
    );
  }

  // Widget _buildTextFieldPhone() {
  //   return Padding(
  //     padding: EdgeInsets.only(bottom: 28.h),
  //     child: AppTextField(
  //       autofocus: true,
  //       controller: controller.phoneController,
  //       hintText: l10n.field_phone__hint,
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

  Widget _buildTextFieldPhone() => AppTextField(
        controller: controller.phoneController,
        hintText: l10n.field_phone__hint,
        label: l10n.field_phone__label,
        keyboardType: TextInputType.phone,
        hintStyle: AppTextStyles.s16w400.copyWith(color: AppColors.border2),
        fillColor: Colors.transparent,
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.border2, width: 0.5),
          borderRadius: BorderRadius.all(Radius.circular(100)),
        ),
        onChanged: (value) {
          controller.phoneForgot.value = value;
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
  //         padding: const EdgeInsets.only(left: Sizes.s8),
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
  //         textAlignVertical: TextAlignVertical.top,
  //         spaceBetweenSelectorAndTextField: 0,
  //         textFieldController: controller.phoneController,
  //         focusNode: controller.phoneFocus,
  //         formatInput: false,
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
  //           controller.setDisableOtpReceiveBtn =
  //               !value.parseNumber().isNotEmpty;

  //           controller.phoneForgot.value = value.phoneNumber ?? '';

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
  //         errorMessage: l10n.field_phone__error_invalid,
  //         autoValidateMode: AutovalidateMode.onUserInteraction,
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

  // Widget _buildTextFieldEmail() {
  //   return Padding(
  //     padding: EdgeInsets.only(bottom: 28.h),
  //     child: AppTextField(
  //       autofocus: true,
  //       inputFormatters: [LowerCaseTextFormatter()],
  //       controller: controller.emailController,
  //       hintText: l10n.field_email__hint,
  //       label: l10n.field_email__label,
  //       textInputAction: TextInputAction.done,
  //       contentPadding: EdgeInsets.all(17.w),
  //       keyboardType: TextInputType.emailAddress,
  //       validator: controller.validateEmail,
  //       onChanged: (value) {
  //         controller.setDisableOtpReceiveBtn =
  //             !controller.formKey.currentState!.validate();
  //       },
  //       autovalidateMode: AutovalidateMode.onUserInteraction,
  //     ),
  //   );
  // }

  @override
  Widget buildPage(BuildContext context) {
    return CommonScaffold(
      hideKeyboardWhenTouchOutside: true,
      appBar: CommonAppBar(
        leadingIconColor: Colors.white,
        titleType: AppBarTitle.text,
        text: context.l10n.forgot_password__title,
        titleTextStyle: AppTextStyles.s20w600.text1Color,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                AppSpacing.gapH20,
                Text(
                  l10n.text_description_reset_pass,
                  style:
                      AppTextStyles.s16Base.copyWith(color: AppColors.border2),
                ),
                AppSpacing.gapH20,
                _buildTextFieldPhone(),
                SizedBox(
                  height: 0.1.sh,
                ),
                _buildSubmitBtn(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showBottomSheetAlert(BuildContext context) => showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => const BottomSheetAlert(),
      );

  void showBottomSheetLoginVia(BuildContext context, String type) =>
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return BottomSheetLoginVia(
            type: type,
            forgotPasswordController: controller,
          );
        },
      );
}
