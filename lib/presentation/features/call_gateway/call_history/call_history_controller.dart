import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../models/all.dart';
import '../../../../models/call_history.dart';
import '../../../base/all.dart';
import '../contact/all.dart';

class CallHistoryController extends BaseController {
  final contactController = Get.find<ContactController>();

  RxBool switchCallHistory = false.obs;
  RxInt currentIndex = 0.obs;
  RxString nameGroup = ''.obs;
  RxString avatarGroup = ''.obs;
  PageController pageController = PageController();

  static const _pageSize = 15;

  final PagingController<int, CallHistory> allHistoryPagingController =
      PagingController(firstPageKey: 0);
  // final PagingController<int, CallHistory> missedHistoryPagingController =
  //     PagingController(firstPageKey: 0);

  @override
  void onInit() {
    allHistoryPagingController.addPageRequestListener((pageKey) {
      getAllCallHistory(pageKey, handleLoading: pageKey == 0);
    });

    // missedHistoryPagingController.addPageRequestListener((pageKey) {
    //   getMissedCallHistory(pageKey);
    // });

    super.onInit();
  }

  set changeTab(int index) {
    currentIndex.value = index;
    pageController.jumpToPage(index);
  }

  void updateCallHistoryAppBar(bool switchValue) {
    switchCallHistory.value = switchValue;
    changeTab = switchValue ? 1 : 0;
    update();
  }

  void getAllCallHistory(int pageKey, {bool handleLoading = true}) {}

  // Future<void> getMissedCallHistory(int pageKey) async {
  //   await runAction(
  //     action: () async {
  //       final callHistories = await _callRepository.getMissedCallHistory(
  //         userId: currentUser.id,
  //         pageSize: _pageSize,
  //         offset: pageKey * _pageSize,
  //       );

  //       final isLastPage = callHistories.length < _pageSize;
  //       if (isLastPage) {
  //         missedHistoryPagingController.appendLastPage(callHistories);
  //       } else {
  //         final nextPageKey = pageKey + 1;
  //         missedHistoryPagingController.appendPage(callHistories, nextPageKey);
  //       }
  //     },
  //   );
  // }

  Future<Conversation?> getConversationById(String conversationId) async {
    return null;
  }

  Future onCallAction(
      CallHistory callHistory, bool isCaller, bool isTranslate) async {}

  void updateExpanded(CallHistory callHistory) {
    if ((allHistoryPagingController.itemList ?? []).isNotEmpty &&
        callHistory.isExpanded) {
      for (var history in allHistoryPagingController.itemList ?? []) {
        history.isExpanded = false;
      }
    } else if ((allHistoryPagingController.itemList ?? []).isNotEmpty) {
      for (var history in allHistoryPagingController.itemList ?? []) {
        history.isExpanded = false;
      }
      callHistory.isExpanded = true;
    }

    update();
  }

  Future<void> goToPrivateChat(User user) async {}

  void refreshContact() {
    final contactController = Get.find<ContactController>();
    contactController.getUserContacts(isLoading: false);
  }

  void onAddContactClick({required UserContact userContact}) {}

  void onEditContactClick({required UserContact userContact}) {}

  void deleteContact(int callHistoryId) {}
}
