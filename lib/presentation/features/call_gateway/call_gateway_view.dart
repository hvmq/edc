import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/all.dart';
import '../../base/all.dart';
import '../../common_widgets/all.dart';
import '../../resource/resource.dart';
import '../all.dart';
import 'call_gateway_controller.dart';
import 'contact/all.dart';

class CallGatewayView extends BaseView<CallGatewayController> {
  const CallGatewayView({super.key});

  @override
  Widget buildPage(BuildContext context) {
    return CommonScaffold(
      applyAutoPaddingBottom: true,
      // appBar: _buildAppBar(),
      body: GestureDetector(
        onHorizontalDragUpdate: (details) {
          final homeController = Get.find<HomeController>();
          // Kiểm tra điều kiện kéo
          if (details.delta.dx > 0) {
            // Kéo sang phải
            if (controller.pageController.page == 0) {
              homeController.pageController.previousPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            }
          } else if (details.delta.dx < 0) {
            // Kéo sang trái
            if (controller.pageController.page == 2) {
              homeController.pageController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            }
          }
        },
        child: _buildBody(),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 80.h,
        color: Colors.transparent,
        elevation: 0,
        padding: EdgeInsets.only(
          left: 20.w,
          right: 20.w,
        ),
        child: Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // _buildItemBottomBar(
              //   icon: AppIcons.match,
              //   title: l10n.home__match_title,
              //   isSelected: controller.currentIndex.value == 0,
              //   action: () => controller.changeTab = 0,
              // ),
              // _buildItemBottomBar(
              //   icon: AppIcons.live,
              //   title: l10n.home__lives_title,
              //   isSelected: controller.currentIndex.value == 1,
              //   action: () => controller.changeTab = 1,
              // ),
              _buildItemBottomBar(
                  icon: AppIcons.news,
                  title: l10n.home__newsfeed_title,
                  isSelected: controller.currentIndex.value == 3,
                  action: () {
                    controller.changeTab = 3;
                    if (controller.currentIndex.value == 3) {}
                  }),
              _buildItemBottomBar(
                icon: AppIcons.phoneCall,
                title: l10n.home__call_title,
                isSelected: controller.currentIndex.value == 0,
                action: () => controller.changeTab = 0,
              ),

              // _buildItemBottomBar(
              //   icon: AppIcons.keyboard,
              //   title: l10n.call__numpad,
              //   isSelected: controller.currentIndex.value == 2,
              //   action: () => controller.changeTab = 2,
              // ),
              // _buildItemBottomBar(
              //   icon: AppIcons.history,
              //   title: l10n.call__history,
              //   isSelected: controller.currentIndex.value == 2,
              //   action: () => controller.changeTab = 2,
              // ),

              // _buildItemBottomBar(
              //   icon: AppIcons.addTab,
              //   title: l10n.home__more_title,
              //   isSelected: controller.currentIndex.value == 3,
              //   action: _showMoreBottomSheet,
              // ),
              // _buildItemBottomBar(
              //     icon: AppIcons.hugeiconsMore,
              //     title: l10n.home__more_title,
              //     isSelected: false,
              //     action: () => Navigator.push(context,
              //         IosPageRoute(builder: (context) => const MoreView()))),
              _buildPersonalItem(
                onTap: () {
                  controller.changeTab = 2;
                },
                title: l10n.navigation__account,
                isSelected: controller.currentIndex.value == 2,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPersonalItem({
    required VoidCallback onTap,
    required String title,
    required bool isSelected,
  }) {
    return Column(
      children: [
        Obx(
          () => Container(
            padding: AppSpacing.edgeInsetsH4.r,
            child: AppCircleAvatar(
              url: controller.currentUser.avatarPath ?? '',
              size: Sizes.s32,
            ),
          ),
        ),
        Text(
          title,
          style: AppTextStyles.s12w400.copyWith(
            color: isSelected ? AppColors.text1 : AppColors.border2,
          ),
        ).paddingOnly(top: 6.w),
      ],
    ).clickable(onTap);
  }

  // void _showMoreBottomSheet() {
  //   Get.bottomSheet(
  //     HomeMoreBottomSheet(
  //       controller: Get.find<HomeController>(),
  //     ),
  //   );
  // }

  // CommonAppBar _buildAppBar() {
  //   switch (controller.currentIndex.value) {
  //     case 0:
  //       return ContactAppBar();
  //     case 1:
  //       return ChatDashBoardAppBar();
  //     // case 2:
  //     //   return CommonAppBar(
  //     //     automaticallyImplyLeading: false,
  //     //     titleType: AppBarTitle.none,
  //     //   );
  //     case 2:
  //       return CallHistoryAppBar();
  //     case 3:
  //       return PersonalPageHiddenNewfeedsAppBarView();
  //     default:
  //       return CommonAppBar(
  //         automaticallyImplyLeading: false,
  //       );
  //   }
  // }

  Widget _buildItemBottomBar({
    required SvgGenImage icon,
    required String title,
    required bool isSelected,
    required Function() action,
  }) {
    return Column(
      children: [
        AppIcon(
          icon: icon,
          color: isSelected ? AppColors.text1 : AppColors.border2,
          size: 28.w,
        ),
        Text(
          title,
          style: AppTextStyles.s12w400.copyWith(
            color: isSelected ? AppColors.text1 : AppColors.border2,
          ),
        ).paddingOnly(top: 6.w),
      ],
    ).clickable(action);
  }

  Widget _buildBody() {
    return PageView(
      controller: controller.pageController,
      // physics: const NeverScrollableScrollPhysics(),
      onPageChanged: (index) => controller.changeTab = index,
      children: const [
        // MatchView(),
        // LiveView(),
        // PostsView(),
        ContactBody(),
        ChatDashboardView(),
        // NumpadView(),
        // CallHistoryBody(),

        // AppSpacing.emptyBox,
      ],
    );
  }
}
