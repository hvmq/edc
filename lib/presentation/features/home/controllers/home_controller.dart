import 'dart:async';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/preferences/app_preferences.dart';
import '../../../base/all.dart';
import '../../library/api/repos/impl/public_book_api.swagger.dart';
import '../../library/core/routes/app_routes.dart';
import '../../library/core/utils/show_noti.dart';

class HomeController extends BaseController with SingleGetTickerProviderMixin {
  RxInt currentIndex = 0.obs;
  late PageController pageController;

  RxBool showCard = false.obs;

  final ScrollController scrollController = ScrollController();

  GetUserInfoApiRepository getUserInfoApiRepository =
      GetUserInfoApiRepository();
  PublicBookRequestInfoApiRepository publicBookRequestInfoApiRepository =
      PublicBookRequestInfoApiRepository();

  set changeTab(int index) {
    currentIndex.value = index;
    pageController.jumpToPage(index);
  }

  String accessToken = '';

  @override
  void onInit() {
    pageController = PageController(initialPage: currentIndex.value);
    checkSystemAlertWindowPermission();
    checkPermissionFullScreen();

    // scrollController.addListener(_scrollListener);
    super.onInit();
    getBlogs();
    unawaited(getToken());
    // updateUserPremium();
  }

  Future getToken() async {
    accessToken = await Get.find<AppPreferences>().getAccessToken() ?? '';
  }

  var blogData = <String, dynamic>{}.obs;

  Future<void> getBlogs() async {
    final response = await Dio()
        .get('https://educhain-server.vercel.app/blogs-multi-language');
    // final data = json.decode(response.data);
    final dynamic data = response.data['data'];
    blogData.value = data;
    update();
  }

  @override
  void onClose() {
    pageController.dispose();
    scrollController.dispose();
    super.onClose();
  }

  // void _scrollListener() {
  //   if (scrollController.offset <= scrollController.position.minScrollExtent &&
  //       !scrollController.position.outOfRange) {
  //     showCard.value = true;
  //   }
  // }

  void setShowCard(bool value) {
    showCard.value = value;
  }

  Future checkPermissionFullScreen() async {}

  Future<void> checkSystemAlertWindowPermission() async {
    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      final sdkInt = androidInfo.version.sdkInt;
    }
  }

  Future<void> updateUserPremium() async {
    if (currentUser.premium != null &&
        currentUser.premium != '' &&
        currentUser.premium != 'null') {
      return;
    }
  }

  Future<bool> isAllowPublicBook() async {
    try {
      final response = await getUserInfoApiRepository.get_info();

      if (response.statusCode == 200) {
        final userData = response.body;
        return userData?.isAllowPublicBook ?? false;
      } else {
        return false;
      }
    } catch (e) {
      print('Error occurred: $e');
      return false;
    }
  }

  Future<void> checkAlreadySendPublicBookRequest() async {
    try {
      final response = await publicBookRequestInfoApiRepository.get_info();

      if (response.statusCode == 201 || response.statusCode == 202) {
        if (response.statusCode == 201) {
          showSuccessWithTitle('Register public book success',
              'Please wait for the admin to approve your request');
        } else if (response.statusCode == 202) {
          showSuccessWithTitle('Request is approved',
              'Please wait for the admin allow you to access the create book');
        }
      } else {
        Get.toNamed(AppRoutes.TermsAndPrivacyPolicy);
      }
    } catch (e) {
      print('Error occurred: $e');
      Get.toNamed(AppRoutes.TermsAndPrivacyPolicy);
    }
  }
}
