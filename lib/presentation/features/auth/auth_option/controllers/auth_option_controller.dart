import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/all.dart';
import '../../../../base/all.dart';

class AuthOptionController extends BaseController {
  AuthOptionController() : super();
  RxString localeDefault = 'EN'.obs;

  @override
  void onInit() {
    getLocaleDefault();
    super.onInit();
  }

  void getLocaleDefault() {
    localeDefault.value = LocaleConfig.defaultLocale.languageCode == 'en'
        ? l10n.locale_en
        : l10n.locale_vi;
  }

  void updateLocaleDefault(String locale) {
    if (locale == l10n.locale_en) {
      Get.updateLocale(const Locale('en'));
      localeDefault.value = l10n.locale_en;
    } else {
      Get.updateLocale(const Locale('vi'));
      localeDefault.value = l10n.locale_vi;
    }
  }
}
