import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/all.dart';
import '../../../../base/all.dart';
import '../../../../common_controller.dart/all.dart';

class ResetPasswordController extends BaseController {
  // final email = Get.arguments['email'] as String?;
  String phone = Get.arguments['phone'] as String;
  final flowFrom = Get.arguments['flowFrom'] as String;

  final appController = Get.find<AppController>();

  final formKey = GlobalKey<FormState>();
  final TextEditingController passwordOldController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  RxBool isLoadingUpdateInfo = false.obs;

  var isDisableSubmitBtn = true.obs;
  var isShowOldPassword = true.obs;
  var isShowPassword = true.obs;
  var isShowConfirmPassword = true.obs;
  var isValidator = false.obs;
  var is8Lenght = false.obs;

  set setDisableSubmitBtn(bool value) {
    isDisableSubmitBtn.value = value;
    update();
  }

  void validatePassword(String? password) {
    isValidator.value = !!ValidationUtil.isValidPassword(password!);
    is8Lenght.value = password.trim().length > 7;
  }

  String? validateConfirmPassword(String? confirmPassword) {
    if (confirmPassword != passwordController.text) {
      return l10n.field__confirm_password_error_invalid;
    }

    return null;
  }

  Future<void> submit() async {
    // _authService.updateInfo(
    //   firstName: 'firstName',
    //   lastName: 'lastName',
    //   username: 'username',
    //   password: '@PassworddefaulPisolution07062024',
    //   passwordConfirmation: '@PassworddefaulPisolution07062024',
    //   phone: phone,
    // );
    if (isLoading) {
      return;
    }

    if (flowFrom == 'forgot') {
      final RegExp regExp = RegExp(r'^\+84');

      phone = phone.replaceFirst(regExp, '');

      updateInfo(
        password: passwordController.text,
        passwordConfirmation: confirmPasswordController.text,
        phone: phone,
      );
    } else if (flowFrom == 'change') {
      checkPassword();
    } else {
      await updateInfo(
        password: passwordController.text,
        passwordConfirmation: confirmPasswordController.text,
        phone: phone,
      );

      Get.back();
      // Get.to(() => const CreateAccountSuccess());
    }
  }

  Future checkPassword() async {
    await runAction(
      action: () async {
        isLoadingUpdateInfo.value = true;
      },
    );
  }

  Future<void> updateInfo({
    String? firstName,
    String? lastName,
    String? username,
    String? password,
    String? passwordConfirmation,
    String? phone,
  }) async {
    if (isLoadingUpdateInfo.value) {
      return;
    }
  }

  // void submit() {
  //   if (isLoading) {
  //     return;
  //   }

  //   if (formKey.currentState!.validate()) {
  //     final isFromForgotPassword = flowFrom == Routes.forgotPassword;
  //     runAction(
  //       action: () async {
  //         if (email != null) {
  //           await _authService.resetPassword(
  //             email: email,
  //             otp: otp,
  //             password: passwordController.text,
  //             passwordConfirmation: confirmPasswordController.text,
  //           );
  //         } else if (phone != null) {
  //           await _authService.resetPassword(
  //             phone: phone,
  //             otp: otp,
  //             password: passwordController.text,
  //             passwordConfirmation: confirmPasswordController.text,
  //           );
  //         }

  //         appController.setLoggedUser(null);

  //         return ViewUtil.showSuccessDialog(
  //           message: isFromForgotPassword
  //               ? l10n.set_password__success_message
  //               : l10n.create_account__success,
  //           buttonText: l10n.button__sign_in,
  //           barrierDismissible: false,
  //           onButtonPressed: () {
  //             Get.offAllNamed(Routes.login);
  //           },
  //         );
  //       },
  //       onError: (exception) {
  //         if (exception is AuthException &&
  //             exception.kind == AuthExceptionKind.resetPasswordFail) {
  //           ViewUtil.showToast(
  //             title: isFromForgotPassword
  //                 ? l10n.forgot_password__title
  //                 : l10n.set_password__fail,
  //             message: l10n.error__password_reset_fail_message,
  //           );
  //         } else {
  //           ViewUtil.showToast(
  //             title: isFromForgotPassword
  //                 ? l10n.forgot_password__title
  //                 : l10n.set_password__fail,
  //             message: l10n.error__unknown,
  //           );
  //         }
  //       },
  //     );
  //   }
  // }
}
