import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/all.dart';
import '../../../base/all.dart';
import '../../../common_widgets/all.dart';
import '../../../resource/resource.dart';
import '../../../routing/routers/app_pages.dart';
import '../../all.dart';
import '../../library/core/routes/app_routes.dart';
import '../../library/core/utils/color.dart';
import '../../library/core/utils/common/commonWidget.dart';
import '../../library/core/utils/resource/assets_constant/icon_constatnt.dart';
import '../../library/core/utils/text_style.dart';
import '../../library/features/library/library_screen.dart';
import '../../library/features/main/main_controller.dart';
import '../../newsfeed/personal_page/all.dart';
import '../../newsfeed/personal_page/personal_page_business_body_view.dart';

import '../../zoom/zoom_home_view.dart';
import 'widgets/all.dart';
import 'widgets/body_home.dart';

class HomeView extends BaseView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  void _showMoreBottomSheet() {
    Get.bottomSheet(HomeMoreBottomSheet(controller: controller));
  }

  void _goToCallGateway() {
    Get.toNamed(Routes.callGateway);
  }

  @override
  Widget buildPage(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Disable the back button behavior
        return false;
      },
      child: Obx(
        () => CommonScaffold(
          applyAutoPaddingBottom: true,
          // appBar: _buildAppBar(),
          body: _buildBody(),
          bottomNavigationBar: Container(
            padding: EdgeInsets.only(
                left: 20.w, right: 20.w, bottom: 22.h, top: 10.h),
            decoration: BoxDecoration(
              color: Colors.white, // Màu nền của bottom bar
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2), // Màu đổ bóng với độ mờ
                  spreadRadius: 5, // Độ lan tỏa của đổ bóng
                  blurRadius: 7, // Độ mờ của đổ bóng
                  offset: const Offset(0, 3), // Vị trí của đổ bóng (x, y)
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildBottomNavItem(
                  IconConstants.bar1,
                  IconConstants.bar1_1,
                  'Education',
                  0,
                ),
                _buildBottomNavItem(
                  IconConstants.bar2,
                  IconConstants.bar2_1,
                  'Chat',
                  1,
                ),
                _buildBottomNavItem(
                  IconConstants.bar3,
                  IconConstants.bar3_1,
                  'EDC Zoom',
                  2,
                ),
                _buildBottomNavItem(
                  IconConstants.bar4,
                  IconConstants.bar4_1,
                  'Library',
                  3,
                ),
                _buildBottomNavItem(
                  IconConstants.bar5,
                  IconConstants.bar5_1,
                  'Account',
                  4,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  CommonAppBar _buildCommonAppBar() {
    return CommonAppBar(
      leadingIcon: LeadingIcon.custom,
      leadingWidth: Sizes.s60,
      leadingIconWidget: _buildNotificationIcon(),
      actions: [
        _buildSearchIcon(),
        AppSpacing.gapW12,
        _buildAssistantIcon(),
      ],
    );
  }

  Widget _buildNotificationIcon() {
    return Container(
      alignment: Alignment.centerRight,
      margin: const EdgeInsets.only(left: Sizes.s20),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.0, 1.0],
          colors: AppColors.button2,
        ),
      ),
      child: AppIcon(
        icon: AppIcons.bell,
        padding: const EdgeInsets.all(Sizes.s8),
      ),
    ).clickable(() {
      Get.toNamed(Routes.notification);
    });
  }

  Widget _buildSearchIcon() {
    return Container(
      alignment: Alignment.centerRight,
      margin: const EdgeInsets.only(left: Sizes.s20),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.0, 1.0],
          colors: AppColors.button2,
        ),
      ),
      child: AppIcon(
        icon: AppIcons.search,
        padding: const EdgeInsets.all(Sizes.s8),
      ),
    ).clickable(() {
      Get.toNamed(Routes.search);
    });
  }

  Widget _buildAssistantIcon() {
    return Container(
      alignment: Alignment.centerLeft,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.0, 1.0],
          colors: AppColors.button2,
        ),
      ),
      child: AppIcon(
        icon: AppIcons.assistant,
        padding: const EdgeInsets.all(Sizes.s8),
      ),
    ).clickable(() {
      Get.toNamed(Routes.createPost);
    });
  }

  Widget _buildNavItem({
    required String title,
    required Object icon,
    required int index,
    required VoidCallback onTap,
    required BuildContext context,
  }) {
    return Obx(
      () => Padding(
        padding: AppSpacing.edgeInsetsH4.r,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppIcon(
              icon: icon,
              size: 24.w,
              color: controller.currentIndex.value == index
                  ? AppColors.button5
                  : AppColors.subText3,
            ),
            AppSpacing.gapH4,
            Text(
              title,
              style: controller.currentIndex.value == index
                  ? AppTextStyles.s14w600
                      .merge(const TextStyle(color: AppColors.button5))
                      .copyWith(
                          fontSize:
                              (Localizations.localeOf(context).toString() ==
                                      'vi')
                                  ? 12
                                  : null)
                  : AppTextStyles.s14w600.toColor(AppColors.subText3).copyWith(
                      fontSize:
                          (Localizations.localeOf(context).toString() == 'vi')
                              ? 12
                              : null),
            ),
          ],
        ),
      ).clickable(onTap),
    );
  }

  Obx _buildPersonalItem(
      {required VoidCallback onTap,
      required int index,
      required BuildContext context}) {
    return Obx(
      () => Padding(
        padding: AppSpacing.edgeInsetsH4.r,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppCircleAvatar(
              url: controller.currentUser.avatarPath ?? '',
              size: 24.w,
            ),
            AppSpacing.gapH4,
            Text(
              l10n.bottom_bar__account,
              style: controller.currentIndex.value == index
                  ? AppTextStyles.s14w600
                      .merge(const TextStyle(color: AppColors.button5))
                      .copyWith(
                          fontSize:
                              (Localizations.localeOf(context).toString() ==
                                      'vi')
                                  ? 12
                                  : null)
                  : AppTextStyles.s14w600
                      .toColor(AppColors.subText3)
                      .merge(const TextStyle(color: AppColors.subText3))
                      .copyWith(
                          fontSize:
                              (Localizations.localeOf(context).toString() ==
                                      'vi')
                                  ? 12
                                  : null),
            ),
          ],
        ),
      ).clickable(() {
        onTap();
      }),
    );
  }

  Widget _buildBody() {
    if (controller.currentIndex.value == -1) {
      return const ChatDashboardView();
    }
    const accountWidget = PersonalPageView();

    final libController = Get.find<MainController>();
    return PageView(
      // physics: const NeverScrollableScrollPhysics(),
      controller: controller.pageController,
      onPageChanged: (index) => controller.changeTab = index,
      children: [
        const BodyHome(),
        const ChatDashboardView(),
        const ZoomHomeView(),

        // const CallPage(),
        // const CourseView(),

        Scaffold(
          backgroundColor: AppColors.text2,
          resizeToAvoidBottomInset: false,
          extendBody: true,
          appBar: appBarWidget(title: '', onTap1: () => _showSubMenu()),
          body: SafeArea(
            child: LibraryScreen(libController.libraryController),
          ),
        ),
        // const MainScreen(),
        accountWidget,
      ],
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
                        child: Image.asset(
                          IconConstants.cli_book,
                          color: Colors.black,
                        ),
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
                        child: Image.asset(
                          IconConstants.ph_video,
                          color: Colors.black,
                        ),
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
                        child: Image.asset(
                          IconConstants.codicon_book,
                          color: Colors.black,
                        ),
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
                        child: Image.asset(
                          IconConstants.users,
                          color: Colors.black,
                        ),
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
                        child: Image.asset(
                          IconConstants.solar_chart_outline,
                          color: Colors.black,
                        ),
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
                        child: Image.asset(
                          IconConstants.thumbsup,
                          color: Colors.black,
                        ),
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
                        child: Image.asset(
                          IconConstants.iconHistory,
                          color: Colors.black,
                        ),
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
                    color: AppColor.textColor.withOpacity(0.2),
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
        controller.changeTab = index;
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
                    stops: [0.0505, 1.0],
                  ),
                  color: controller.currentIndex.value == index
                      ? Colors.green
                      : const Color.fromARGB(0, 47, 23, 23),
                  borderRadius: BorderRadius.circular(100),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(0),
                      width: 24,
                      child: Image.asset(controller.currentIndex.value == index
                          ? url
                          : urlActive),
                    ),
                    if (controller.currentIndex.value == index) ...[
                      const SizedBox(
                        width: 8,
                      ), // Spacing between icon and label
                      Text(
                        label.tr,
                        style: TextAppStyle().titleStyleLight().copyWith(
                              fontSize: 14,
                              color: Colors.white, // Active text color
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.25,
                            ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
