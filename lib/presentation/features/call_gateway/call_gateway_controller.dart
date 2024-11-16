import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../base/all.dart';
import 'contact/all.dart';

const _kInitialIndex = 0;

class CallGatewayController extends BaseController {
  final _contactController = Get.put(ContactController());

  RxInt currentIndex = _kInitialIndex.obs;
  PageController pageController = PageController();

  RxBool initFirstTimeGetContact = true.obs;

  @override
  void onInit() {
    initFirstTimeGetContact.value = true;
    super.onInit();
  }

  set changeTab(int index) {
    currentIndex.value = index;
    pageController.jumpToPage(index);
    update();

    // Load contact list when user switch to contact tab
    if (index == 2 && initFirstTimeGetContact.value) {
      _contactController.getUserContacts();
      initFirstTimeGetContact.value = false;
    }
  }
}
