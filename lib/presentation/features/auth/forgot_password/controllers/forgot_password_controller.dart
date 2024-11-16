import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../../../core/all.dart';
import '../../../../../models/all.dart';

import '../../../../base/all.dart';
import '../../../../resource/resource.dart';
import '../../../../routing/routers/app_pages.dart';
import '../../../all.dart';

enum ForgotSendKind {
  email,
  phone,
}

class ForgotPasswordController extends BaseController {
  final formKey = GlobalKey<FormState>();
  var selectKind = ForgotSendKind.email.obs;
  var isDisableReceiveBtn = true.obs;

  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  FocusNode phoneFocus = FocusNode();
  FocusNode emailFocus = FocusNode();

  RxString phoneForgot = ''.obs;
  RxString initIsoCode = 'VN'.obs;

  set setDisableOtpReceiveBtn(bool value) {
    isDisableReceiveBtn.value = value;
    update();
  }

  set setForgotSendKind(ForgotSendKind kind) {
    selectKind.value = kind;
    if (kind == ForgotSendKind.email) {
      final mess = validateEmail(emailController.text);
      setDisableOtpReceiveBtn = mess != null;
    } else {
      final mess = validatePhone(phoneController.text);
      setDisableOtpReceiveBtn = mess != null;
    }
    update();
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

    if (!ValidationUtil.isValidPhoneNumber(phone)) {
      return l10n.field_phone__error_invalid;
    }

    return null;
  }

  Future<void> loginBy3rd(
    String accessToken,
    BuildContext context,
    RegisterController controller,
  ) async {
    if (isLoading) {
      return;
    }
  }

  Future<void> resetPassword() async {}
}
