import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/routes/app_routes.dart';
import '../../core/utils/color.dart';
import '../../core/utils/common/commonWidget.dart';
import '../../core/utils/resource/assets_constant/icon_constatnt.dart';
import '../../core/utils/text_style.dart';
import '../../features/account/account_screen.dart';
import '../../features/chat/chat_screen.dart';
import '../../features/edc_zoom/edc_zoom_screen.dart';
import '../../features/educhain/educhain_screen.dart';
import '../../features/library/library_screen.dart';
import '../../features/main/main_controller.dart';

class MainScreen extends GetView<MainController> {
  const MainScreen({super.key});
  List<Widget> _buildScreens() {
    return [
      EduchainScreen(controller.educhainController),
      ChatScreen(controller.chatController),
      EDCZoomScreen(controller.edcZoomController),
      LibraryScreen(controller.libraryController),
      AccountScreen(controller.accountController),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      bottomNavigationBar: _buildBottomNavigationBar(),
      resizeToAvoidBottomInset: false,
      extendBody: true,
      appBar: appBarWidget(title: '', onTap1: _showSubMenu),
      body: SafeArea(
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: controller.controller,
          onPageChanged: (index) {
            controller.currentPage.value = index;
          },
          children: _buildScreens(),
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(10),
        topLeft: Radius.circular(10),
      ),
      child: BottomAppBar(
        color: AppColor.secondaryColor,
        height: kBottomNavigationBarHeight + 32,
        elevation: 0,
        padding: const EdgeInsets.all(0),
        surfaceTintColor: AppColor.secondaryColor,
        clipBehavior: Clip.antiAlias,
        shape: const CircularNotchedRectangle(),
        child: Container(
          padding: const EdgeInsets.only(),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _buildBottomNavItem(
                    IconConstants.bar1, IconConstants.bar1_1, 'Education', 0),
                _buildBottomNavItem(
                    IconConstants.bar2, IconConstants.bar2_1, 'Chat', 1),
                _buildBottomNavItem(
                    IconConstants.bar3, IconConstants.bar3_1, 'EDC Zoom', 2),
                _buildBottomNavItem(
                    IconConstants.bar4, IconConstants.bar4_1, 'Library', 3),
                _buildBottomNavItem(
                    IconConstants.bar5, IconConstants.bar5_1, 'Account', 4),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavItem(
      String urlActive, String url, String label, int index) {
    return GestureDetector(
      onTap: () {
        controller.controller.jumpToPage(index);
      },
      child: Obx(
        () => Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Background for selected item
              Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF124984), // #124984
                      Color(0xFF369C09), // #369C09
                    ],
                    stops: [0.0505, 1.0], // Corresponds to 5.05% and 100%
                  ),
                  color: controller.currentPage.value == index
                      ? Colors.green // Active background color
                      : const Color.fromARGB(0, 47, 23, 23),
                  borderRadius: BorderRadius.circular(16),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(0),
                      width: 24,
                      child: Image.asset(controller.currentPage.value == index
                          ? url
                          : urlActive),
                    ),
                    if (controller.currentPage.value == index) ...[
                      const SizedBox(
                          width: 8), // Spacing between icon and label
                      Text(
                        label.tr,
                        style: TextAppStyle().titleStyleLight().copyWith(
                              fontSize: 14,
                              color: Colors.white, // Active text color
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.25,
                            ),
                      )
                    ]
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSubMenu() {
    showModalBottomSheet(
      context: Get.context!,
      backgroundColor: AppColor.primaryColor,
      isDismissible: false, // Prevents dismissing by tapping outside
      isScrollControlled: true, // Allow full height
      builder: (context) {
        return Stack(
          children: [
            // Main content
            FractionallySizedBox(
              alignment: Alignment.centerLeft, // Align to the center left
              widthFactor:
                  0.98, // Adjust width factor to control the width of the modal
              heightFactor: 0.97, // Full height of the screen
              child: Container(
                margin: const EdgeInsets.only(top: 40),
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                        'Public Book',
                        style: TextStyle(color: AppColor.textColor),
                      ),
                      leading: SizedBox(
                        width: 24,
                        height: 24,
                        child: Image.asset(IconConstants.cli_book),
                      ),
                      onTap: () async {
                        final bool check = await controller.isAllowPublicBook();
                        Get.back();
                        if (check) {
                          Get.toNamed(AppRoutes.PublicBook, arguments: {
                            'title': 'Public Book',
                            'isVideo': false
                          });
                        } else {
                          await controller.checkAlreadySendPublicBookRequest();
                        }
                      },
                    ),
                    ListTile(
                      title: Text(
                        'Public Video',
                        style: TextStyle(color: AppColor.textColor),
                      ),
                      leading: SizedBox(
                        width: 24,
                        height: 24,
                        child: Image.asset(IconConstants.ph_video),
                      ),
                      onTap: () async {
                        final bool check = await controller.isAllowPublicBook();
                        Get.back();
                        if (check) {
                          Get.toNamed(AppRoutes.PublicBook, arguments: {
                            'title': 'Public Video',
                            'isVideo': true
                          });
                        } else {
                          await controller.checkAlreadySendPublicBookRequest();
                        }
                      },
                    ),
                    ListTile(
                      leading: SizedBox(
                        width: 24,
                        height: 24,
                        child: Image.asset(IconConstants.codicon_book),
                      ),
                      title: Text('My Book',
                          style: TextStyle(color: AppColor.textColor)),
                      onTap: () {
                        Get.back();
                        Get.toNamed(AppRoutes.MyBook, arguments: {
                          'title': 'My Book',
                          'isVideo': false
                        }); // Close the modal
                      },
                    ),
                    ListTile(
                      leading: SizedBox(
                        width: 24,
                        height: 24,
                        child: Image.asset(IconConstants.users),
                      ),
                      title: Text('My Video',
                          style: TextStyle(color: AppColor.textColor)),
                      onTap: () {
                        Get.back();
                        Get.toNamed(AppRoutes.MyBook, arguments: {
                          'title': 'My Video',
                          'isVideo': true
                        }); // Close the modal
                      },
                    ),
                    ListTile(
                      leading: SizedBox(
                        width: 24,
                        height: 24,
                        child: Image.asset(IconConstants.solar_chart_outline),
                      ),
                      title: Text('Revenue statistics',
                          style: TextStyle(color: AppColor.textColor)),
                      onTap: () {
                        Get.back();
                        Get.toNamed(
                            AppRoutes.Revenuestatistics); // Close the modal
                      },
                    ),
                    ListTile(
                      leading: SizedBox(
                        width: 24,
                        height: 24,
                        child: Image.asset(IconConstants.thumbsup),
                      ),
                      title: Text('My Favorite',
                          style: TextStyle(color: AppColor.textColor)),
                      onTap: () {
                        Get.back();
                        Get.toNamed(AppRoutes.MyFavorite, arguments: {
                          'title': 'MyFavorite'.tr
                        }); // Close the modal
                      },
                    ),
                    ListTile(
                      leading: SizedBox(
                        width: 24,
                        height: 24,
                        child: Image.asset(IconConstants.iconHistory),
                      ),
                      title: Text('History',
                          style: TextStyle(color: AppColor.textColor)),
                      onTap: () {
                        Get.back();
                        Get.toNamed(AppRoutes.History, arguments: {
                          'title': 'History'.tr
                        }); // Close the modal
                      },
                    ),
                  ],
                ),
              ),
            ),
            // Close button on the right
            Positioned(
              right: 16,
              top: 40,
              child: GestureDetector(
                onTap: () {
                  Get.back(); // Close the modal
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColor.blueColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.close,
                    color: AppColor.textColor,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
