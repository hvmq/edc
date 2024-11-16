import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/all.dart';
import '../../../../models/all.dart';
import '../../../base/all.dart';
import '../../../common_widgets/all.dart';
import '../../../resource/resource.dart';
import '../../../routing/routing.dart';
import 'all.dart';
import 'widgets/contact_info_detail.dart';

class ContactBody extends BaseView<ContactController> {
  const ContactBody({super.key});

  @override
  Widget buildPage(BuildContext context) {
    return CommonScaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppSpacing.gapH20,
            const AppDivider(),
            AppSpacing.gapH16,
            CardNumberWidget(
              controller: controller,
            ),
            _buildTextTitle(),
            AppSpacing.gapH16,
            _buildTextDescription(),
            AppSpacing.gapH16,
            _buildButtonStartCall(),
          ],
        ),
      ),
    );

    // return Column(
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: [
    //     AppTextField(
    //       controller: controller.searchController,
    //       hintText: controller.l10n.contact__search_hint,
    //       prefixIcon: AppIcon(
    //         icon: AppIcons.search,
    //         color: AppColors.subText2,
    //       ),
    //       hintStyle:
    //           AppTextStyles.s16w400.copyWith(color: AppColors.subText2),
    //     ).paddingOnly(bottom: Sizes.s16),
    //     Expanded(
    //       child: Obx(
    //         () {
    //           if (controller.isSearching.value) {
    //             if (controller.contactsSearching.isEmpty) {
    //               return _buildNoContactsWidget(context);
    //             }

    //             return GroupedListView<UserContact, String>(
    //               controller: controller.scrollController,
    //               // ignore: invalid_use_of_protected_member
    //               elements: controller.contactsSearching.value,
    //               groupBy: (element) => element.fullName
    //                   .trim()
    //                   .toUpperCase()
    //                   .toString()
    //                   .substring(0, 1),
    //               groupSeparatorBuilder: (String groupByValue) => Text(
    //                 groupByValue,
    //                 style: AppTextStyles.s18w700,
    //               ).paddingOnly(top: Sizes.s8, bottom: Sizes.s4),
    //               itemBuilder: (context, dynamic element) =>
    //                   _buildItemSearch(element),
    //               separator: AppSpacing.gapH12,
    //             );
    //           } else {
    //             if (controller.usersList.isEmpty) {
    //               return _buildNoContactsWidget(context);
    //             }

    //             return RefreshIndicator(
    //               onRefresh: () async {
    //                 controller.getUserContacts(isLoading: false);
    //               },
    //               child: GroupedListView<UserContact, String>(
    //                 physics: const AlwaysScrollableScrollPhysics(),
    //                 controller: controller.scrollController,
    //                 // ignore: invalid_use_of_protected_member
    //                 elements: controller.usersList.value,
    //                 groupBy: (element) => element.fullName.isNotEmpty
    //                     ? element.fullName
    //                         .trim()
    //                         .toUpperCase()
    //                         .toString()
    //                         .substring(0, 1)
    //                     : '',
    //                 groupSeparatorBuilder: (String groupByValue) => Text(
    //                   groupByValue,
    //                   style: AppTextStyles.s18w700,
    //                 ).paddingOnly(top: Sizes.s8, bottom: Sizes.s4),
    //                 itemBuilder: (context, dynamic element) =>
    //                     _buildItemSearch(element),
    //                 separator: AppSpacing.gapH12,
    //               ),
    //             );
    //           }
    //         },
    //       ),
    //     ),
    //   ],
    // ).paddingOnly(left: 20, right: 20, bottom: 10);
  }

  CommonAppBar _buildAppBar() {
    return CommonAppBar(
      automaticallyImplyLeading: false,
      titleWidget: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: AppCircleAvatar(
          url: controller.currentUser.avatarPath ?? '',
        ),
        title: Text(
          DateTimeUtil.getGreetingMessage(),
          style: AppTextStyles.s18w600,
        ),
        subtitle: Text(
          controller.currentUser.fullName,
          style: AppTextStyles.s16w500.toColor(AppColors.button5),
          overflow: TextOverflow.ellipsis,
        ),
        // trailing: const NotificationsIcon(),
      ),
    );
  }

  Widget _buildTextTitle() => Text(
        l10n.title_contact_body,
        style: AppTextStyles.s24w600,
        textAlign: TextAlign.center,
      );

  Widget _buildTextDescription() => Text(
        l10n.decription_contact_body,
        style: AppTextStyles.s16Base.toColor(AppColors.border2),
        textAlign: TextAlign.center,
      );

  Widget _buildButtonStartCall() => Padding(
        padding: AppSpacing.edgeInsetsAll20,
        child: AppButton.secondary(
          label: l10n.button_start_a_call,
          color: AppColors.button5,
          width: double.infinity,
          onPressed: () {
            Get.toNamed(Routes.callPage);
          },
        ),
      );

  Widget _buildItemSearch(UserContact user) {
    return _buildExpansion(user);
  }

  void _onInfoPressed(UserContact user) {
    ViewUtil.showBottomSheet(
      child: ContactInfoDetail(
        user: user,
      ),
      isScrollControlled: true,
      isFullScreen: true,
    ).then((value) {
      controller.isoCode.value = '';
      controller.phoneEdit.value = '';
      controller.avatarUrl.value = '';
      controller.inputEnterPhoneController.clear();
      controller.changeIsEditContact = false;
      controller.isAvatarLocal.value = false;
    });
  }

  Widget _buildBtnIcon({required Object icon, Function()? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: AppColors.button2,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: AppIcon(
          icon: icon,
          size: 22,
        ),
      ),
    );
  }

  Widget _buildNoContactsWidget(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppIcon(
              icon: AppIcons.contacts,
              size: 80.w,
              color: AppColors.subText1,
            ),
            AppSpacing.gapH12,
            Text(
              context.l10n.contact__no_contacts,
              style: AppTextStyles.s16w500.subText1Color,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildExpansion(UserContact user) {
    final Widget header = GestureDetector(
      onTap: () {
        controller.updateExpanded(user);
      },
      child: Row(
        children: <Widget>[
          Expanded(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              curve: Curves.fastOutSlowIn,
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  minHeight: Sizes.s48,
                ),
                child: Container(
                  color: Colors.transparent,
                  child: Row(
                    children: [
                      AppCircleAvatar(
                        url: user.user?.avatarPath ?? '',
                        size: Sizes.s48,
                      ).paddingOnly(right: Sizes.s12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            user.fullName.isNotEmpty
                                ? user.fullName.trim()
                                : user.contactPhoneNumber,
                            style: AppTextStyles.s16w400,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            (user.user?.nickname ?? '').isNotEmpty
                                ? user.user?.nickname ?? ''
                                : user.user?.fullName ?? '',
                            style: AppTextStyles.s12w400.subText2Color,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );

    return GetBuilder<ContactController>(
      init: controller,
      builder: (controller) {
        return Column(
          children: <Widget>[
            header,
            AnimatedCrossFade(
              firstChild: Container(height: 0.0),
              secondChild: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildBtnIcon(
                    icon: AppIcons.callBroken,
                    onTap: () => controller.onCallVoice(user),
                  ),
                  _buildBtnIcon(
                    icon: AppIcons.video,
                    onTap: () => controller.onVideoCall(user),
                  ),
                  _buildBtnIcon(
                    icon: AppIcons.chat,
                    onTap: () {
                      controller.goToPrivateChat(user);
                    },
                  ),
                  _buildBtnIcon(
                    icon: AppIcons.info,
                    onTap: () {
                      _onInfoPressed(user);
                    },
                  ),
                ],
              ).paddingOnly(top: Sizes.s12),
              firstCurve: const Interval(0.0, 0.6, curve: Curves.fastOutSlowIn),
              secondCurve:
                  const Interval(0.4, 1.0, curve: Curves.fastOutSlowIn),
              sizeCurve: Curves.fastOutSlowIn,
              crossFadeState: user.isExpanded
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 500),
            ),
          ],
        );
      },
    );
  }
}
