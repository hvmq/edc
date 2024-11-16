import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../core/all.dart';
import '../../../../../models/conversation.dart';
import '../../../../../models/message.dart';
import '../../../../base/all.dart';
import '../../../../common_widgets/all.dart';
import '../../../../common_widgets/anchor_scroll/all.dart';
import '../../../../resource/resource.dart';
import '../../../../routing/routers/app_pages.dart';
import '../../conversation_details/controllers/conversation_details_controller.dart';
import '../../conversation_details/views/widgets/mute_widget.dart';
import '../controllers/chat_hub_controller.dart';
import 'widgets/all.dart';
import 'widgets/pin_message_widget.dart';

class ChatHubView extends BaseView<ChatHubController> {
  const ChatHubView({super.key});

  @override
  bool get allowLoadingIndicator => false;

  void _goToChatDetails() {
    if (controller.conversation.isBlocked || controller.conversation.isLocked) {
      return;
    }

    Get.toNamed(
      Routes.conversationDetails,
      arguments: ConversationDetailsArguments(
        conversation: controller.conversation,
      ),
    )?.then(
      (updatedConversation) {
        if (updatedConversation != null &&
            updatedConversation is Conversation) {
          controller.conversationUpdated(updatedConversation);
        }
      },
    );
  }

  Widget _buildIconMoreTranlaste(BuildContext context) => PopupMenuButton<int>(
        color: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        position: PopupMenuPosition.under,
        onSelected: (value) {},
        itemBuilder: (context) => [
          for (int i = 0; i < languages.length; i++) ...[
            PopupMenuItem<int>(
              value: 4,
              child: Row(
                children: [
                  Text(
                    languages[i]['title'] ?? '',
                    style: AppTextStyles.s16Base,
                  ),
                ],
              ),
              onTap: () {
                controller.updateTranslateLanguageMessage(i);
              },
            )
          ],
        ],
        child: Assets.icons.more.svg(color: AppColors.subTextConversationItem),
      );

  @override
  Widget buildPage(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ViewUtil.hideKeyboard(context);
      },
      child: Obx(
        () => CommonScaffold(
          appBar: _buildAppBar(context),
          body: Column(
            children: [
              _buildDivider(),
              Obx(
                () => controller.isConversationInitiated
                    ? PinMessageWidget(
                        conversation: controller.conversation,
                      )
                    : AppSpacing.emptyBox,
              ),
              _buildTranslateWidget(context),
              _buildDivider(),
              Expanded(child: _buildMessagesList()),
              _buildChatInput(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTranslateWidget(BuildContext context) {
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        Container(
          width: 1.sw,
          color: AppColors.backgroundPinMessage.withOpacity(0.5),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: !controller.isTranslateMessage.value
              ? Center(
                  child: Text(
                  '${l10n.chat_hub__translate_to} ${languages[controller.translateLanguageMessageIndex.value]['title']}',
                  style: AppTextStyles.s16w600
                      .copyWith(color: AppColors.titlePinMessage),
                )).clickable(() {
                  controller.handleTranslateMessage(true);
                })
              : Center(
                  child: Text(
                  l10n.chat_hub__translate_back,
                  style: AppTextStyles.s16w600
                      .copyWith(color: AppColors.titlePinMessage),
                )).clickable(() {
                  controller.handleTranslateMessage(false);
                }),
        ),
        Positioned(
          right: 20,
          child: _buildIconMoreTranlaste(context),
        )
      ],
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: EdgeInsets.zero,
      child: Divider(color: AppColors.divider, thickness: 0.5, height: 1),
    );
  }

  CommonAppBar _buildAppBar(BuildContext context) {
    return CommonAppBar(
      titleWidget: Obx(() {
        if (!controller.isConversationInitiated) {
          return AppSpacing.emptyBox;
        }

        return Row(
          children: [
            AppCircleAvatar(
              url: controller.conversation.avatarUrl ?? '',
            ),
            AppSpacing.gapW10,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 100,
                  height: 30,
                  child: Obx(
                    () => MuteWidget(
                      isMuted: controller.conversation.isMuted == true,
                      child: Text(
                        controller.conversation.title(),
                        style: AppTextStyles.s16w600,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 100,
                  height: 30,
                  child: _buildOnlineStatus() ?? const SizedBox(),
                ),
              ],
            ),
          ],
        ).clickable(() {
          if (controller.conversation.isBlocked ||
              controller.conversation.isLocked) {
            return;
          }

          _goToChatDetails();
        });
      }),
      actions: !controller.isConversationInitiated
          ? []
          : [
              if (!controller.conversation.isGroup &&
                  !controller.conversation.isBlocked) ...[
                // AppIcon(
                //   padding: AppSpacing.edgeInsetsAll8,
                //   icon: AppIcons.callBroken,
                //   color: AppColors.button5,
                //   onTap: () {
                //     controller.onCallVoiceTap();

                //   },
                // ),
                Padding(
                  padding: AppSpacing.edgeInsetsAll8,
                  child: Assets.icons.phoneTranslate
                      .image(width: 24, height: 24, color: AppColors.text1),
                ).clickable(() {}),
                AppIcon(
                  padding: AppSpacing.edgeInsetsAll8,
                  icon: AppIcons.video,
                  color: AppColors.text1,
                  onTap: controller.onCallVideoTap,
                  size: 16,
                ),
              ],
              // if (controller.conversation.isGroup) ...[
              //   _buildIconMore(context),
              // ],
              if (controller.conversation.isGroup &&
                  controller.isCreatorOrAdmin) ...[
                AppIcon(
                  padding: AppSpacing.edgeInsetsAll8,
                  icon: AppIcons.video,
                  color: AppColors.text1,
                  onTap: controller.onCallVideoGroupTap,
                  size: 14,
                ),
                // _buildIconMore(context),
              ],
              // AppIcon(
              //   padding: AppSpacing.edgeInsetsAll8.copyWith(right: 0),
              //   icon: AppIcons.infoOutline,
              //   color: AppColors.button5,
              //   onTap: _goToChatDetails,
              // ),

              AppIcon(
                padding: AppSpacing.edgeInsetsAll8,
                icon: AppIcons.info,
                color: AppColors.text1,
                onTap: () {
                  if (controller.conversation.isBlocked ||
                      controller.conversation.isLocked) {
                    return;
                  }

                  _goToChatDetails();
                },
                size: 16,
              ).clickable(() {}),
            ],
      onLeadingPressed: controller.leadingIconOnTap,
    );
  }

  Widget _buildIconMore(BuildContext context) => PopupMenuButton<int>(
        surfaceTintColor: AppColors.background8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        position: PopupMenuPosition.under,
        onSelected: (value) {
          if (value == 1) {
            showBottomSheetRenameGroup(context);
          } else if (value == 5) {
            showBottomSheetLeaveGroup(context);
          }
        },
        itemBuilder: (context) => [
          PopupMenuItem<int>(
            value: 1,
            child: Row(
              children: [
                Text(
                  Get.context!.l10n.text_rename_group,
                  style: AppTextStyles.s16Base,
                ),
                const Spacer(),
                AppIcon(
                  icon: AppIcons.edit,
                  size: 18,
                ),
              ],
            ),
          ),
          PopupMenuItem<int>(
            value: 2,
            child: Row(
              children: [
                Text(
                  Get.context!.l10n.conversation_members__add_member,
                  style: AppTextStyles.s16Base,
                ),
                const Spacer(),
                AppIcon(
                  icon: AppIcons.addMember,
                  size: 18,
                ),
              ],
            ),
          ),
          PopupMenuItem<int>(
            value: 3,
            child: Row(
              children: [
                Text(Get.context!.l10n.text_mute, style: AppTextStyles.s16Base),
                const Spacer(),
                AppIcon(
                  icon: AppIcons.mute,
                  size: 18,
                ),
              ],
            ),
          ),
          PopupMenuItem<int>(
            value: 4,
            child: Row(
              children: [
                Text(
                  Get.context!.l10n.setting__title,
                  style: AppTextStyles.s16Base,
                ),
                const Spacer(),
                AppIcon(
                  icon: AppIcons.settingIcon,
                  size: 18,
                ),
              ],
            ),
          ),
          PopupMenuItem<int>(
            value: 5,
            child: Row(
              children: [
                Text(
                  Get.context!.l10n.conversation_details__leave_group,
                  style: AppTextStyles.s16Base.toColor(Colors.red),
                ),
                const Spacer(),
                AppIcon(
                  icon: AppIcons.leave,
                  size: 18,
                  color: Colors.red,
                ),
              ],
            ),
          ),
        ],
        child: AppIcon(
          padding: AppSpacing.edgeInsetsAll8.copyWith(right: 0),
          icon: AppIcons.more,
          size: 28,
          color: AppColors.button5,
        ),
      );

  Widget _buildMessagesList() {
    return CommonPagedListView<Message>(
      scrollController: controller.anchorScrollController,
      pagingController: controller.pagingController,
      padding: AppSpacing.edgeInsetsH20,
      // separatorBuilder: (context, index) => AppSpacing.gapH16,
      reverse: true,
      itemBuilder: (context, message, index) {
        final previousMessage =
            index + 1 < controller.pagingController.itemList!.length
                ? controller.pagingController.itemList![index + 1]
                : null;
        final nextMessage = index - 1 >= 0
            ? controller.pagingController.itemList![index - 1]
            : null;

        log(controller.stateMessage.value.toString());

        return Column(
          children: [
            AnchorItemWrapper(
              index: index,
              controller: controller.anchorScrollController,
              child: Obx(
                () {
                  final isShowStateMessage = index == 0 &&
                      message.isMine(myId: controller.currentUser.id);
                  final isShowMessageSeen =
                      message.isMine(myId: controller.currentUser.id) &&
                          controller.indexLastSeen.value == index;

                  return MessageItem(
                    key: ValueKey(message.id),
                    isMine: message.isMine(myId: controller.currentUser.id),
                    message: controller.isTranslateMessage.value &&
                            message.type == MessageType.text
                        ? message.copyWith(
                            content: controller
                                .translateMessageMap.value[message.id])
                        : message,
                    previousMessage: previousMessage,
                    nextMessage: nextMessage,
                    currentUserId: controller.currentUser.id,
                    // lastMessage
                    stateMessage: (isShowStateMessage && !isShowMessageSeen)
                        ? controller.stateMessage.value
                        : StateMessage.none,
                    isAdmin: controller.conversation.isAdmin(currentUser.id),
                    onTap: () => controller.onMessageTap(message),
                    onPressedUserAvatar: () =>
                        controller.onUserAvatarTap(message),
                    members: controller.conversation.members,
                    isGroup: controller.conversation.isGroup,
                    onMentionPressed: controller.onMentionPressed,
                  );
                },
              ),
            ),
            Obx(
              () => Visibility(
                visible: message.isMine(myId: controller.currentUser.id) &&
                    controller.indexLastSeen.value == index,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: AppCircleAvatar(
                      url: controller.conversation.avatarUrl ?? '',
                      size: 16,
                    ),
                  ),
                ).paddingOnly(bottom: 4, top: 2),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget? _buildOnlineStatus() {
    return Obx(
      () => controller.conversation.isGroup
          ? Text(
              '${controller.conversation.members.length.toString()} ${l10n.conversation_details__members}',
              style: AppTextStyles.s14w400.toColor(AppColors.subText2),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )
          : Text(
              controller.isOnline ? l10n.global__online : l10n.global__offline,
              style: AppTextStyles.s14w400.toColor(
                controller.isOnline ? AppColors.positive : AppColors.subText3,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
    );
  }

  Widget _buildChatInput() {
    return Obx(
      () => controller.isConversationInitiated
          ? !controller.conversation.isGroup &&
                  controller.conversation.isBlocked
              ? _buildBlockedConversationWidget()
              : controller.conversation.isLocked
                  ? AppSpacing.gapH32
                  : const ChatInput()
          : AppSpacing.gapH32,
    );
  }

  Widget _buildBlockedConversationWidget() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: Sizes.s20,
        vertical: Sizes.s32,
      ),
      color: AppColors.white,
      child: Column(
        children: [
          Text(
            controller.conversation.blockedByMe
                ? l10n.chat_hub__you_blocked
                : l10n.chat_hub__blocked_by_user,
            style: AppTextStyles.s14w400.toColor(AppColors.subText2),
          ),
          if (controller.conversation.blockedByMe)
            Padding(
              padding: AppSpacing.edgeInsetsOnlyTop16,
              child: AppButton.secondary(
                color: AppColors.button5,
                width: double.infinity,
                label: l10n.chat_hub__unblock_btn,
                onPressed: controller.unblockUser,
              ),
            ),
        ],
      ),
    );
  }

  void showBottomSheetRenameGroup(BuildContext context) => showModalBottomSheet(
        context: context,
        builder: (context) => const BottomSheetRenameGroup(),
      );

  void showBottomSheetLeaveGroup(BuildContext context) => showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.black45,
        isDismissible: false,
        context: context,
        builder: (context) => const BottomSheetLeaveGroup(),
      );
}
