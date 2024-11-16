import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../../../core/all.dart';
import '../../../../../models/user.dart';
import '../../../../base/all.dart';
import '../../../../common_widgets/all.dart';
import '../../../../resource/resource.dart';
import '../../../../routing/routers/app_pages.dart';
import '../../../all.dart';
import '../../../call_gateway/contact/widgets/call_widget.dart';
import '../../../library/core/utils/resource/assets_constant/image_constant.dart';
import '../../../search_user/all.dart';

class ChatDashboardView extends BaseView<ChatDashboardController> {
  const ChatDashboardView({super.key});

  @override
  bool get allowLoadingIndicator => true;

  @override
  Widget buildPage(BuildContext context) {
    return SlidableAutoCloseBehavior(
        child: NestedScrollView(
      floatHeaderSlivers: true,
      physics: const BouncingScrollPhysics(),
      headerSliverBuilder: _buildAppBar,
      body: Column(
        children: [
          AppSpacing.gapH24,
          Padding(
            padding: AppSpacing.edgeInsetsH20,
            child: Row(
              children: [
                Expanded(
                  child: AppTextField(
                    enabled: false,
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
                    fillColor: AppColors.text2,
                    hintText: 'Search',
                    hintStyle:
                        AppTextStyles.s14w600.toColor(AppColors.subText3),
                    prefixIcon: AppIcon(
                        icon: AppIcons.search, color: AppColors.subText3),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.borderSearch),
                      borderRadius: BorderRadius.all(Radius.circular(42)),
                    ),
                  ).clickable(() {
                    showBottomSheetSearchMessage(context);
                  }),
                ),
                AppSpacing.gapW16,
                AppIcon(
                  icon: Assets.icons.contact,
                  size: 27,
                ).clickable(() {
                  Get.to(() => const CallPage());
                }),
                AppSpacing.gapW16,
                AppIcon(
                  icon: Assets.icons.add,
                  size: 20,
                ).clickable(() {
                  showBottomSheetCreateMessage(context);
                }),
              ],
            ),
          ),
          AppSpacing.gapH32,
          Expanded(
            child: Obx(
              () => controller.conversations.isEmpty
                  ? _buildNoMessageWidget(context)
                  : _buildConversationsList(),
            ),
          ),
        ],
      ),
    )).clickable(() {
      controller.isSearching.value = false;
    });
  }

  List<Widget> _buildAppBar(context, innerBoxIsScrolled) => [
        SliverAppBar(
          pinned: true,
          centerTitle: false,
          automaticallyImplyLeading: false,
          title: Image.asset(
            ImageConstants.logo,
            width: 104,
          ),
          actions: [
            if (controller.isSelect.value) ...[
              IconButton(
                onPressed: () {
                  final List<int> newIndexes =
                      List.generate(10, (index) => index);
                  controller.selects.addAll(newIndexes);
                },
                icon: Text(
                  l10n.button_select_all,
                  style:
                      AppTextStyles.s16w600.copyWith(color: AppColors.button5),
                ),
              ),
            ] else ...[
              // IconButton(
              //   onPressed: () {
              //     showBottomSheetSearchMessage(context);
              //   },
              //   icon: AppIcon(
              //     icon: AppIcons.searchLg,
              //     color: AppColors.button5,
              //   ),
              // ),
              // IconButton(
              //   onPressed: () => showBottomSheetCreateMessage(context),
              //   icon: AppIcon(
              //     icon: AppIcons.create,
              //     color: AppColors.button5,
              //     size: Sizes.s28,
              //   ),
              // ),
              AppIcon(
                padding: AppSpacing.edgeInsetsAll4,
                icon: AppIcons.notification,
                backgroundColor: AppColors.appIconBackground,
                onTap: () {},
                size: 20,
                isCircle: true,
              ).marginOnly(right: 20),
            ],
          ],
          backgroundColor: AppColors.white,
          surfaceTintColor: AppColors.white,
          elevation: 0,
        ),
      ];

  Widget _buildConversationsList() {
    return RefreshIndicator(
      onRefresh: controller.refresh,
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: controller.conversations.length,
        itemBuilder: (context, index) {
          final conversation = controller.conversations[index];

          return Obx(
            () => Row(
              children: [
                controller.isSelect.value
                    ? AppCheckBox(
                        value: controller.selects.contains(index),
                        onChanged: (value) {
                          if (value != null) {
                            if (value) {
                              controller.selects.add(index);
                            } else {
                              controller.selects.remove(index);
                            }
                          }
                        },
                      )
                    : const SizedBox.shrink(),
                Expanded(
                  child: ConversationItem(
                    key: ValueKey(conversation.id),
                    conversation: conversation,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildNoMessageWidget(BuildContext context) {
    return RefreshIndicator(
      onRefresh: controller.refresh,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: AppSpacing.edgeInsetsH32.copyWith(top: 0.2.sh),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Assets.images.noMessage.image(scale: 2),
              AppSpacing.gapH32,
              Text(
                context.l10n.chat__no_message_title,
                style: AppTextStyles.s20w600,
                textAlign: TextAlign.center,
              ),
              AppSpacing.gapH4,
              Text(
                context.l10n.chat__no_message_message,
                style: AppTextStyles.s14w400.copyWith(color: AppColors.border2),
                textAlign: TextAlign.center,
              ),
              AppSpacing.gapH32,
              AppButton.secondary(
                label: l10n.button_send_mess,
                color: AppColors.button5,
                width: double.infinity,
                onPressed: () => showBottomSheetCreateMessage(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showBottomSheetCreateMessage(BuildContext context) {
    final controller = Get.find<ChatDashboardController>();

    ViewUtil.showBottomSheet<List<User>>(
      isScrollControlled: true,
      isFullScreen: true,
      child: const CreateChatSearchUsersBottomSheet(),
    ).then(
      (selectedUsers) {
        if (selectedUsers != null) {
          controller.createConversationAndGotoChatHub(selectedUsers);
        }
      },
    );
  }

  void showBottomSheetSearchMessage(BuildContext context) {
    showCupertinoModalBottomSheet(
      topRadius: const Radius.circular(20),
      context: context,
      builder: (context) => SearchInfoView(
        type: 'message',
        bindingCreator: () => SearchInfoBinding(),
      ),
    );
  }

  void showBottomSheetBlockList(BuildContext context) =>
      showCupertinoModalBottomSheet(
        topRadius: const Radius.circular(20),
        context: context,
        builder: (context) => const BottomSheetBlockList(),
      );

  void showBottomSheetAutoDelete(BuildContext context) =>
      showCupertinoModalBottomSheet(
        topRadius: const Radius.circular(20),
        context: context,
        builder: (context) => const BottomSheetAutoDelete(),
      );
}

// ignore: prefer-single-widget-per-file
class ChatDashBoardAppBar extends CommonAppBar {
  ChatDashBoardAppBar({super.key});

  void _onSearchPressed() {
    Get.toNamed(Routes.search);
  }

  void _onCreateConversationPressed() {
    final controller = Get.find<ChatDashboardController>();

    ViewUtil.showBottomSheet<List<User>>(
      isScrollControlled: true,
      isFullScreen: true,
      child: const CreateChatSearchUsersBottomSheet(),
    ).then(
      (selectedUsers) {
        if (selectedUsers != null) {
          controller.createConversationAndGotoChatHub(selectedUsers);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ChatDashboardController>();

    // final isHomePage = Get.currentRoute == Routes.home;

    return CommonAppBar(
      automaticallyImplyLeading: false,
      // automaticallyImplyLeading: !isHomePage,
      // titleWidget: _buildTitleWidget(context),
      actions: [
        // Obx(
        //   () => controller.isSearching.value
        //       ? AppSpacing.emptyBox
        //       : AppIcon(
        //           padding: AppSpacing.edgeInsetsAll12,
        //           icon: AppIcons.search,
        //           onTap: _onSearchPressed,
        //         ),
        // ),
        // AppIcon(
        //   padding: AppSpacing.edgeInsetsAll12.copyWith(right: 0),
        //   icon: AppIcons.edit,
        //   onTap: _onCreateConversationPressed,
        // ),
        AppIcon(
          padding: AppSpacing.edgeInsetsAll12.copyWith(right: 0),
          icon: AppIcons.notification,
          backgroundColor: AppColors.appIconBackground,
          onTap: _onCreateConversationPressed,
        ),
      ],
    );
  }

  Widget _buildTitleWidget(BuildContext context) {
    final controller = Get.find<ChatDashboardController>();

    return Obx(
      () {
        if (controller.isSearching.value) {
          return CustomSearchBar(
            onChanged: (value) {
              controller.filterConversations(value);
            },
            onClear: () {
              controller.clearSearch();
            },
          );
        }

        return SlidingSwitch(
          value: controller.showGroupConversations.value,
          textOn: context.l10n.chat__group_label,
          textOff: context.l10n.chat__private_label,
          colorOn: AppColors.white,
          colorOff: AppColors.white,
          inactiveColor: AppColors.text4,
          contentSize: 14,
          width: 184.w,
          height: 55.h,
          onChanged: (value) {
            controller.updateShowGroupConversations(value);
          },
          onTap: () {},
          onSwipe: () {},
        );
      },
    );
  }
}
