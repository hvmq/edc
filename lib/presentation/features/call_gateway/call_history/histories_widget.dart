import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../core/all.dart';
import '../../../../models/all.dart';
import '../../../../models/call_history.dart';
import '../../../base/all.dart';
import '../../../common_widgets/all.dart';
import '../../../resource/resource.dart';
import '../../../routing/routers/app_pages.dart';
import '../contact/all.dart';
import 'call_history_controller.dart';

class HistoriesWidget extends BaseView<CallHistoryController> {
  const HistoriesWidget({Key? key}) : super(key: key);

  @override
  Widget buildPage(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        controller.allHistoryPagingController.refresh();
      },
      child: Container(
        padding: const EdgeInsets.only(
          top: Sizes.s16,
          bottom: Sizes.s16,
        ),
        child: PagedListView<int, CallHistory>.separated(
          pagingController: controller.allHistoryPagingController,
          builderDelegate: PagedChildBuilderDelegate<CallHistory>(
            animateTransitions: true,
            itemBuilder: (context, item, index) {
              if (item.call == null) {
                return const SizedBox.shrink();
              }

              return _buildItemHistory(
                callHistory: item,
                isLast: index ==
                    controller.allHistoryPagingController.itemList!.length - 1,
                context: context,
              );
            },
            noItemsFoundIndicatorBuilder: (context) {
              return buildNoContacts(context);
            },
          ),
          separatorBuilder: (context, index) => const SizedBox(),
        ),
      ),
    );
  }

  Widget _buildItemCallHistory(CallHistory callHistory) {
    if (callHistory.status == 'outgoing' || callHistory.status == 'canceled') {
      if (callHistory.call!.isGroup ?? false) {
        return _buildWidgetItemCallHistory(
          isGroup: true,
          avatarPath: callHistory.call?.conversation?.avatarUrl ?? '',
          fullName: callHistory.call?.conversation?.name ?? 'Unknown',
          status: callHistory.status,
          createdAt: callHistory.call?.createdAt ?? DateTime.now(),
          isVideo: callHistory.call?.isVideo ?? false,
          timeCall: callHistory.duration,
          isExpanded: callHistory.isExpanded,
          // onTap: () => controller.onCallAction(callHistory, true),
        );
      }

      final User? receiver = callHistory.call!.receivers.isNotEmpty
          ? callHistory.call!.receivers.first.user
          : null;

      return _buildWidgetItemCallHistory(
        user: receiver,
        avatarPath: receiver?.avatarPath ?? '',
        fullName: receiver?.contactName ?? 'unknown',
        status: callHistory.status,
        createdAt: callHistory.call?.createdAt ?? DateTime.now(),
        isVideo: callHistory.call?.isVideo ?? false,
        timeCall: callHistory.duration,
        isExpanded: callHistory.isExpanded,
        // onTap: () => controller.onCallAction(callHistory, true),
      );
    } else if (callHistory.status == 'incoming' ||
        callHistory.status == 'declined' ||
        callHistory.status == 'missed') {
      if (callHistory.call!.isGroup ?? false) {
        return _buildWidgetItemCallHistory(
          isGroup: true,
          avatarPath: callHistory.call?.conversation?.avatarUrl ?? '',
          fullName: callHistory.call?.conversation?.name ?? 'Unknown',
          status: callHistory.status,
          createdAt: callHistory.call?.createdAt ?? DateTime.now(),
          isVideo: callHistory.call?.isVideo ?? false,
          timeCall: callHistory.duration,
          isExpanded: callHistory.isExpanded,
          // onTap: () => controller.onCallAction(callHistory, false),
        );
      }

      final User? caller = callHistory.call!.callers.isNotEmpty
          ? callHistory.call!.callers.first.user
          : null;

      return _buildWidgetItemCallHistory(
        user: caller,
        avatarPath: caller?.avatarPath ?? '',
        fullName: caller?.contactName ?? caller?.fullName ?? '',
        status: callHistory.status,
        createdAt: callHistory.call?.createdAt ?? DateTime.now(),
        isVideo: callHistory.call?.isVideo ?? false,
        timeCall: callHistory.duration,
        isExpanded: callHistory.isExpanded,
        // onTap: () => controller.onCallAction(callHistory, false),
      );
    }

    return const SizedBox();
  }

  Widget _buildWidgetItemCallHistory({
    required String avatarPath,
    required String fullName,
    required String status,
    required DateTime createdAt,
    required bool isVideo,
    required int timeCall,
    User? user,
    bool isExpanded = false,
    Function()? onTap,
    bool isGroup = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Sizes.s16,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    AppCircleAvatar(
                      url: avatarPath,
                      size: 50,
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              if (isGroup) ...[
                                Text(
                                  fullName,
                                  style: AppTextStyles.s16w400,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ] else if (user != null)
                                ...[],
                              const Expanded(child: SizedBox.shrink()),
                              // if (isExpanded) ...[
                              //   const Icon(Icons.keyboard_arrow_down),
                              // ] else ...[
                              //   const Icon(Icons.keyboard_arrow_up),
                              // ],
                            ],
                          ),
                          const SizedBox(
                            height: Sizes.s2,
                          ),
                          Row(
                            children: [
                              _buildStatusCall(
                                status,
                              ),
                              const SizedBox(
                                width: Sizes.s12,
                              ),
                              Text(
                                DateTimeUtil.timeAgo(
                                  Get.context!,
                                  createdAt,
                                  format: DateTimeFormatConstants.MMM_dd,
                                ),
                                style: AppTextStyles.s12w400.copyWith(
                                  color: AppColors.border3,
                                ),
                              ).paddingOnly(right: Sizes.s12),
                            ],
                          ),
                        ],
                      ).paddingOnly(left: Sizes.s12),
                    ),
                  ],
                ),
              ),
            ],
          ).paddingOnly(bottom: Sizes.s8, top: Sizes.s8),
        ],
      ),
    );
  }

  Widget _buildStatusCall(String status) {
    Widget result = const SizedBox();
    switch (status) {
      case 'outgoing':
        result = buildItemStatusCall(
          AppIcons.phoneOut,
          AppLocalizations.of(Get.context!)!.call_history__outgoing,
          AppColors.text1,
        );
        break;
      case 'incoming':
        result = buildItemStatusCall(
          AppIcons.phoneIn,
          AppLocalizations.of(Get.context!)!.call_history__incoming,
          AppColors.text1,
        );
        break;
      case 'missed':
        result = buildItemStatusCall(
          AppIcons.phoneIn,
          AppLocalizations.of(Get.context!)!.call_history__missed,
          AppColors.negative,
        );
        break;
      case 'canceled':
        result = buildItemStatusCall(
          AppIcons.phoneOut,
          AppLocalizations.of(Get.context!)!.call_history__outgoing,
          AppColors.text1,
        );
      case 'declined':
        result = buildItemStatusCall(
          AppIcons.phoneIn,
          AppLocalizations.of(Get.context!)!.call_history__missed,
          AppColors.negative,
        );
        break;
    }

    return result;
  }

  Widget buildItemStatusCall(
    SvgGenImage icon,
    String title,
    Color color,
  ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppIcon(
          icon: icon,
          size: Sizes.s20,
          color: color,
        ),
        const SizedBox(
          width: Sizes.s4,
        ),
        Text(
          title,
          style: AppTextStyles.s12w400.copyWith(color: color),
        ),
      ],
    );
  }

  Widget _buildItemHistory({
    required CallHistory callHistory,
    required BuildContext context,
    bool isLast = false,
  }) {
    final child = GetBuilder<CallHistoryController>(
      init: controller,
      builder: (controller) {
        return GestureDetector(
          onTap: () {
            controller.updateExpanded(callHistory);

            // if (callHistory.status == 'outgoing' ||
            //     callHistory.status == 'canceled') {
            //   final User? receiver = callHistory.call!.receivers.isNotEmpty
            //       ? callHistory.call!.receivers.first.user
            //       : null;
            //   log('message11111111${receiver!.id}');
            //   if (!(callHistory.call!.isGroup ?? false)) {
            //     controller.goToPrivateChat(receiver);
            //   }
            // } else if (callHistory.status == 'incoming' ||
            //     callHistory.status == 'declined' ||
            //     callHistory.status == 'missed') {
            //   final User? receiver = callHistory.call!.callers.isNotEmpty
            //       ? callHistory.call!.callers.first.user
            //       : null;
            //   log('message11111111${receiver!.id}');
            //   if (!(callHistory.call!.isGroup ?? false)) {
            //     controller.goToPrivateChat(receiver);
            //   }
            // }
          },
          child: Container(
            decoration: BoxDecoration(
              color: callHistory.isExpanded
                  ? const Color(0xff9493AC).withOpacity(0.08)
                  : Colors.transparent,
            ),
            child: Column(
              children: [
                AppSpacing.gapH12,
                _buildItemCallHistory(callHistory),
                AnimatedCrossFade(
                  firstChild: Container(height: 0.0),
                  secondChild: !(callHistory.call!.isGroup ?? false)
                      ? _buildExpandedItemHistory(
                          callHistory: callHistory, context: context)
                      : const SizedBox.shrink(),
                  firstCurve: const Interval(
                    0.0,
                    0.6,
                    curve: Curves.fastOutSlowIn,
                  ),
                  secondCurve: const Interval(
                    0.4,
                    1.0,
                    curve: Curves.fastOutSlowIn,
                  ),
                  sizeCurve: Curves.fastOutSlowIn,
                  crossFadeState: callHistory.isExpanded
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                  duration: const Duration(milliseconds: 300),
                ),
                AppSpacing.gapH12,
                if (callHistory.isExpanded) ...[
                  Divider(
                    color: AppColors.border3,
                    height: 1,
                  ),
                ] else ...[
                  if (!isLast) ...[
                    Divider(
                      color: AppColors.border3,
                      height: 1,
                      indent: 64,
                    ),
                  ],
                ],
              ],
            ),
          ),
        );
      },
    );

    return Slidable(
      key: ValueKey(callHistory.id),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        extentRatio: 0.12,
        children: [
          _buildDeleteAction(context).clickable(() {
            if (callHistory.id == null) return;
            controller.deleteContact(callHistory.id!);
          })
        ],
      ),
      child: child,
    );
  }

  Widget _buildDeleteAction(BuildContext context) {
    return Container(
      width: 0.12.sw,
      color: AppColors.negative,
      height: double.infinity,
      child: AppIcon(
        icon: AppIcons.removeChatDashboard,
        color: AppColors.white,
        padding: const EdgeInsets.symmetric(horizontal: 12),
      ),
    );
  }

  Widget _buildExpandedItemHistory({
    required CallHistory callHistory,
    required BuildContext context,
  }) {
    final bool isGroup = callHistory.call!.isGroup ?? false;
    final contactController = Get.find<ContactController>();
    var isHaveContact = false;

    final User? receiver = callHistory.call!.receivers.isNotEmpty
        ? callHistory.call!.receivers.first.user
        : null;
    final User? caller = callHistory.call!.callers.isNotEmpty
        ? callHistory.call!.callers.first.user
        : null;

    final User? partner =
        (controller.currentUser.id == receiver?.id) ? caller : receiver;

    try {
      isHaveContact = contactController.usersList.value
          .where((user) {
            return user.contactPhoneNumber == (partner?.phone ?? '');
          })
          .toList()
          .isNotEmpty;
    } catch (e) {
      LogUtil.e(e);
    }

    return Padding(
      padding: const EdgeInsets.only(
        left: 68,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppSpacing.gapH4,
          Row(
            children: [
              // GestureDetector(
              //   onTap: () {
              //     if (callHistory.status == 'outgoing' ||
              //         callHistory.status == 'canceled') {
              //       controller.onCallAction(callHistory, true, false);
              //     } else if (callHistory.status == 'incoming' ||
              //         callHistory.status == 'declined' ||
              //         callHistory.status == 'missed') {
              //       controller.onCallAction(callHistory, false, false);
              //     }
              //   },
              //   child: Container(
              //     padding: const EdgeInsets.all(Sizes.s8),
              //     decoration: const BoxDecoration(
              //       shape: BoxShape.circle,
              //       border: Border.fromBorderSide(
              //         BorderSide(color: AppColors.subText3, width: 2),
              //       ),
              //     ),
              //     child: AppIcon(
              //       icon: AppIcons.call,
              //       color: AppColors.button5,
              //     ),
              //   ),
              // ),
              // AppSpacing.gapW24,
              GestureDetector(
                onTap: () {
                  // ViewUtil.showAlertDialog(
                  //   type: AlertDialogType.success,
                  //   image: Assets.images.successIcon,
                  //   title: l10n.notification__title,
                  //   content: 'Continue to call Translate',
                  //   textTopButton: l10n.button_close,
                  //   onTapTopButton: () => Get.back(),
                  //   textBottomButton: 'Start',
                  //   onTapBottomButton: () {
                  //     if (callHistory.status == 'outgoing' ||
                  //         callHistory.status == 'canceled') {
                  //       controller.onCallAction(callHistory, true, true);
                  //     } else if (callHistory.status == 'incoming' ||
                  //         callHistory.status == 'declined' ||
                  //         callHistory.status == 'missed') {
                  //       controller.onCallAction(callHistory, false, true);
                  //     }
                  //   },
                  // );

                  // controller.confirmCallTranslate(user);
                },
                child: Container(
                  padding: const EdgeInsets.all(Sizes.s8),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.fromBorderSide(
                      BorderSide(color: AppColors.subText3, width: 2),
                    ),
                  ),
                  child: AppIcon(
                    icon: Assets.icons.phoneTranslate.image(
                      width: 24,
                      height: 24,
                      color: AppColors.button5,
                    ),
                    color: AppColors.button5,
                  ),
                ),
              ),
              AppSpacing.gapW24,
              GestureDetector(
                onTap: () {
                  if (callHistory.status == 'outgoing' ||
                      callHistory.status == 'canceled') {
                    controller.onCallAction(callHistory, true, false);
                  } else if (callHistory.status == 'incoming' ||
                      callHistory.status == 'declined' ||
                      callHistory.status == 'missed') {
                    controller.onCallAction(callHistory, false, false);
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(Sizes.s8),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.fromBorderSide(
                      BorderSide(color: AppColors.subText3, width: 2),
                    ),
                  ),
                  child:
                      AppIcon(icon: AppIcons.video, color: AppColors.button5),
                ),
              ),
              AppSpacing.gapW24,

              GestureDetector(
                onTap: () {
                  if (callHistory.status == 'outgoing' ||
                      callHistory.status == 'canceled') {
                    final User? receiver =
                        callHistory.call!.receivers.isNotEmpty
                            ? callHistory.call!.receivers.first.user
                            : null;
                    log('message11111111${receiver!.id}');
                    if (!(callHistory.call!.isGroup ?? false)) {
                      controller.goToPrivateChat(receiver);
                    }
                  } else if (callHistory.status == 'incoming' ||
                      callHistory.status == 'declined' ||
                      callHistory.status == 'missed') {
                    final User? receiver = callHistory.call!.callers.isNotEmpty
                        ? callHistory.call!.callers.first.user
                        : null;
                    log('message11111111${receiver!.id}');
                    if (!(callHistory.call!.isGroup ?? false)) {
                      controller.goToPrivateChat(receiver);
                    }
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(Sizes.s8),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.fromBorderSide(
                      BorderSide(color: AppColors.subText3, width: 2),
                    ),
                  ),
                  child: AppIcon(
                    icon: AppIcons.message,
                    color: AppColors.button5,
                  ),
                ),
              ),
              // AppSpacing.gapW24,
              // IgnorePointer(
              //   child: Opacity(
              //     opacity: 0.5,
              //     child: GestureDetector(
              //       onTap: () {},
              //       child: Container(
              //         padding: const EdgeInsets.all(Sizes.s8),
              //         decoration: const BoxDecoration(
              //           shape: BoxShape.circle,
              //           border: Border.fromBorderSide(
              //             BorderSide(color: Color(0xff252531), width: 2),
              //           ),
              //         ),
              //         child: AppIcon(icon: AppIcons.blockCall),
              //       ),
              //     ),
              //   ),
              // ),
              if (!isGroup) ...[
                AppSpacing.gapW24,
                GestureDetector(
                  onTap: () async {},
                  child: Container(
                    padding: const EdgeInsets.all(Sizes.s8),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.fromBorderSide(
                        BorderSide(color: AppColors.subText3, width: 2),
                      ),
                    ),
                    child: AppIcon(
                      icon: isHaveContact ? AppIcons.edit : AppIcons.addContact,
                      color: AppColors.button5,
                    ),
                  ),
                ),
              ]
            ],
          ),
        ],
      ),
    );
  }

  void _onEditContact(UserContact userContact, BuildContext context) {
    Get.toNamed(Routes.addContactNumber, arguments: {
      'user': userContact, // your user contact object
      'isAddContact': false, // or false, depending on your logic
    });

    // showCupertinoModalBottomSheet(
    //   topRadius: const Radius.circular(20),
    //   expand: true,
    //   context: context,
    //   builder: (context) => ContactInfoHistory(
    //     userContact: userContact,
    //     isEditContact: true,
    //     controller: controller,
    //   ),
    // );
  }

  void _onAddContact(
    UserContact userContact,
    BuildContext context,
  ) {
    Get.toNamed(Routes.addContactNumber, arguments: {
      'user': userContact, // your user contact object
      'isAddContact': true, // or false, depending on your logic
    });

    // showCupertinoModalBottomSheet(
    //   topRadius: const Radius.circular(20),
    //   expand: true,
    //   context: context,
    //   builder: (context) => ContactInfoHistory(
    //     userContact: userContact,
    //     isAddContact: true,
    //     controller: controller,
    //   ),
    // );
  }

  Widget buildNoContacts(
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.all(Sizes.s16),
      child: Column(
        children: [
          // AppIcon(
          //   icon: AppIcons.noContact,
          //   size: 280,
          // ),
          AppSpacing.gapH16,
          Text(
            context.l10n.history_call__empty_title,
            style: AppTextStyles.s16w500.copyWith(
              fontSize: 24,
              color: AppColors.white,
            ),
          ),
          AppSpacing.gapH24,
          Text(
            context.l10n.history_call__empty_content,
            style: AppTextStyles.s14w400.copyWith(
              color: AppColors.bodyText1,
            ),
            textAlign: TextAlign.center,
          ),
          AppSpacing.gapH24,
          AppButton.secondary(
            label: context.l10n.history_call__empty_btn,
            color: AppColors.button5,
            width: double.infinity,
            onPressed: () {
              controller.contactController.tabController.animateTo(0);
            },
          ),
        ],
      ),
    );
  }
}
