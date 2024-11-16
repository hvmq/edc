import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../api/repos/impl/public_book_api.swagger.dart';
import '../../core/controllers/app_controller.dart';
import '../../core/routes/app_routes.dart';
import '../../core/utils/show_noti.dart';
import '../../features/account/account_controller.dart';
import '../../features/chat/chat_controller.dart';
import '../../features/edc_zoom/edc_zoom_controller.dart';
import '../../features/educhain/educhain_controller.dart';
import '../../features/library/library_controller.dart';

class MainController extends AppController {
  PageController controller = PageController(initialPage: 3);
  RxInt currentPage = 3.obs;
  RxInt selectedIndexPage = 3.obs;
  ChatController chatController = ChatController();
  LibraryController libraryController = LibraryController();
  EduchainController educhainController = EduchainController();
  EDCZoomController edcZoomController = EDCZoomController();
  AccountController accountController = AccountController();
  GetUserInfoApiRepository getUserInfoApiRepository =
      GetUserInfoApiRepository();
  PublicBookRequestInfoApiRepository publicBookRequestInfoApiRepository =
      PublicBookRequestInfoApiRepository();

  @override
  Future<void> onInit() async {
    super.onInit();
    Get.put<EduchainController>(educhainController);
    Get.put<ChatController>(chatController);
    Get.put<LibraryController>(libraryController);
    Get.put<EDCZoomController>(edcZoomController);
    Get.put<AccountController>(accountController);
  }

  Future<UserData?> getUserInfo() async {
    try {
      final response = await getUserInfoApiRepository.get_info();

      if (response.statusCode == 200) {
        return response.body; // Directly returning the UserData object
      } else {
        showErrorWithTitle('Error', 'Failed to fetch user info');
        return null;
      }
    } catch (e) {
      showErrorWithTitle('Error', 'Failed to fetch user info: $e');
      return null;
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
