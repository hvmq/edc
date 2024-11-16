import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/all.dart';
import '../../../base/all.dart';

class SettingController extends BaseController {
  RxString version = ''.obs;
  // final String code = Get.arguments['code'] as String;
  RxString codeRx = ''.obs;
  RxBool isLoadingBtnDeleteAccount = false.obs;

  TextEditingController deleteController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  RxList<Map<String, dynamic>> userInfoList = <Map<String, dynamic>>[].obs;

  @override
  void onReady() {
    // codeRx.value = code;

    getVerSion();
    getBlocklist();
    callCheckPassword();
    super.onReady();
  }

  void callCheckPassword() {}

  void setCodeRx() {
    codeRx.value = 'not_match';
  }

  Future<void> getVerSion() async {
    final version = await AppUtil.getVersion();
    this.version.value = version;
  }

  Future getBlocklist() async {}

  Future<void> confirmUnBlockUser(int id, int index) async {
    await ViewUtil.showAppCupertinoAlertDialog(
      title: l10n.button__unblock_user,
      message: l10n.newsfeed__unblock_user_confirm,
      negativeText: l10n.button__cancel,
      positiveText: l10n.text_unblock,
      onPositivePressed: () {
        onUnBlockUser(id, index);
      },
    );
  }

  Future<void> onUnBlockUser(int id, int index) async {}

  Future<void> deleteAccount() async {
    isLoadingBtnDeleteAccount.value = true;
    update();
  }
}
