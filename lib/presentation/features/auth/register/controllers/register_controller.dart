import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../../../../core/all.dart';
import '../../../../../models/all.dart';

import '../../../../base/all.dart';
import '../../../../common_controller.dart/all.dart';
import '../../../../resource/resource.dart';
import '../../../../routing/routers/app_pages.dart';
import '../../../all.dart';
import '../views/widgets/complete_register.dart';

enum RegisterKind {
  email,
  phone,
}

class RegisterController extends BaseController {
  final formKey = GlobalKey<FormState>();
  var registerKind = RegisterKind.email.obs;

  final emailController = TextEditingController();
  Rx<TextEditingController> phoneController = TextEditingController().obs;
  final referralIdController = TextEditingController();
  FocusNode phoneFocus = FocusNode();
  FocusNode emailFocus = FocusNode();

  RxString phoneRegister = ''.obs;
  RxString initIsoCode = 'VN'.obs;

  RxBool isAgree = false.obs;
  RxBool isDisableReceiveBtn = true.obs;
  RxBool isLoadingUpdateInfo = false.obs;

  String firstName = '';
  String lastName = '';
  String username = '';
  String avatarPath = '';
  int currentId = 0;
  String email = '';

  RxBool isAppleSignInAvailable = false.obs;

  @override
  void onInit() {
    getAppleSignInAvailable();
    super.onInit();
  }

  Future<void> updateAvatar({
    required File file,
  }) async {}

  void setDisableOtpReceiveBtn(bool value) {
    isDisableReceiveBtn.value = value;
  }

  // set setRegisterKind(RegisterKind kind) {
  //   registerKind.value = kind;
  //   if (kind == RegisterKind.email) {
  //     final mess = validateEmail(emailController.text);
  //     setDisableOtpReceiveBtn = mess != null;
  //   } else {
  //     final mess = validatePhone(phoneController.text);
  //     setDisableOtpReceiveBtn = mess != null;
  //   }
  //   update();
  // }

  void setTextFieldPhone(String text) {
    phoneController.value.text = text;
  }

  String? validateEmail(String? email) {
    if (!ValidationUtil.isEmptyEmail(email!)) {
      return l10n.field_email__error_empty;
    }

    if (!ValidationUtil.isValidEmail(email)) {
      return l10n.field_email__error_invalid;
    }

    return null;
  }

  String? validatePhone(String? phone) {
    if (!ValidationUtil.isEmptyPhoneNumber(phone!)) {
      return l10n.field_phone__error_empty;
    }

    // if (!ValidationUtil.isValidPhoneNumber(phone)) {
    //   return l10n.field_phone__error_invalid;
    // }

    return null;
  }

  String? validateNotEmpty(String? string) {
    if (string!.isEmpty) {
      return l10n.is_required;
    }

    // if (!ValidationUtil.isValidPhoneNumber(phone)) {
    //   return l10n.field_phone__error_invalid;
    // }

    return null;
  }

  Future<void> loginBy3rd(String accessToken, String type, BuildContext context,
      RegisterController controller, String? phone) async {}

  Future<void> updateInfo(
    String? firstName,
    String? lastName,
    String? username,
    String? password,
    String? passwordConfirmation,
    String? phone,
    PickedMedia? avatarFile,
    BuildContext context,
    RegisterController controller,
  ) async {}

  Future<void> _onLoginSuccess(
    int userId,
    BuildContext context,
    RegisterController controller,
  ) async {}

  Future<bool> checkPhoneNumberIsExists(String phone) async {
    return true;
  }

  void signInWithApple(
    BuildContext context,
    RegisterController controller, {
    bool isRegisterPhone = false,
  }) {}

  void getAppleSignInAvailable() {
    SignInWithApple.isAvailable().then((value) {
      isAppleSignInAvailable.value = value;
    });
  }
}
