import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../../../../core/all.dart';
import '../../../../../models/all.dart';

import '../../../../base/all.dart';
import '../../../../common_controller.dart/app_controller.dart';
import '../../../../resource/resource.dart';
import '../../../../routing/routing.dart';
import '../../../all.dart';

enum LoginKind {
  email,
  phone,
}

class LoginController extends BaseController {
  final appController = Get.find<AppController>();

  var isHidePassword = true.obs;
  var isDisableLoginBtn = true.obs;
  var loginKind = LoginKind.phone.obs;

  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  FocusNode phoneFocus = FocusNode();
  FocusNode emailFocus = FocusNode();

  RxString phoneLogin = ''.obs;
  RxString initIsoCode = 'VN'.obs;

  RxBool isAppleSignInAvailable = false.obs;
  int currentId = 0;
  String email = '';

  @override
  void onInit() {
    getAppleSignInAvailable();
    super.onInit();
  }

  set setHidePassword(bool value) {
    isHidePassword.value = value;
    update();
  }

  set setDisableLoginBtn(bool value) {
    isDisableLoginBtn.value = value;
    update();
  }

  set setLoginKind(LoginKind kind) {
    loginKind.value = kind;
    update();
  }

  String validateEmail(String email) {
    if (!ValidationUtil.isEmptyEmail(email)) {
      return l10n.field__email_error_empty;
    }

    if (!ValidationUtil.isValidEmail(email)) {
      return l10n.field__email_error_invalid;
    }

    return '';
  }

  String validatePassword(String password) {
    if (password.isEmpty) {
      return l10n.field__password_error_empty;
    }

    if (!ValidationUtil.isValidPassword(password)) {
      return l10n.field__password_error_invalid;
    }

    return '';
  }

  Future<void> login() async {
    if (isLoading) {
      return;
    }
  }

  Future<void> _onLoginSuccess(
    int userId,
    BuildContext? context,
    RegisterController? controller, {
    required bool isGoogle,
    String? firstName,
    String? lastName,
  }) async {}

  void goToForgotPassword() {
    Get.toNamed(Routes.forgotPassword);
  }

  void signInWithApple(
    BuildContext context,
    RegisterController controller,
  ) {}

  void getAppleSignInAvailable() {
    SignInWithApple.isAvailable().then((value) {
      isAppleSignInAvailable.value = value;
    });
  }
}
