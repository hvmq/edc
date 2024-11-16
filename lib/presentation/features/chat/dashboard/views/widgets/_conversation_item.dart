import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

import '../../../../../../core/all.dart';
import '../../../../../../models/conversation.dart';
import '../../../../../../models/message.dart';
import '../../../../../common_controller.dart/all.dart';
import '../../../../../common_widgets/all.dart';
import '../../../../../common_widgets/reaction_chat_widget/model/menu_item.dart';
import '../../../../../common_widgets/reaction_chat_widget/utilities/hero_dialog_route.dart';
import '../../../../../resource/resource.dart';
import '../../../../../routing/routers/app_pages.dart';
import '../../../../all.dart';
import '../../../conversation_details/views/widgets/mute_widget.dart';
import 'preview_chat/preview_chat_dialog.dart';

class ConversationItem extends StatelessWidget {
  final Conversation conversation;
  final bool showChildOnly;
  final EdgeInsets? contentPadding;
  final VoidCallback? beforeGoToChat;

  const ConversationItem({
    required this.conversation,
    this.contentPadding,
    this.showChildOnly = false,
    this.beforeGoToChat,
    super.key,
  });

  void _onDeleteChat(BuildContext context) {
    ViewUtil.showAppCupertinoAlertDialog(
      title: context.l10n.delete_chat__confirm_title,
      message: context.l10n.delete_chat__confirm_message,
      negativeText: context.l10n.button__cancel,
      positiveText: context.l10n.button__confirm,
      onPositivePressed: () {
        Get.find<ChatDashboardController>().deleteConversation(conversation);
      },
    );
  }

  void _onMuteChat(BuildContext context) {
    ViewUtil.showAppCupertinoAlertDialog(
      title: context.l10n.mute_chat__confirm_title,
      message: context.l10n.mute_chat__confirm_message,
      negativeText: context.l10n.button__cancel,
      positiveText: context.l10n.button__confirm,
      onPositivePressed: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    final child = GestureDetector(
      child: ListTile(
        contentPadding: contentPadding,
        splashColor: Colors.transparent,
        leading: _buildAvatar(),
        title: MuteWidget(
          isMuted: conversation.isMuted == true,
          child: _buildTitle(context),
        ),
        subtitle: _buildSubtitle(context),
        // trailing: _buildTrailing(context),
        onTap: () {
          Get.toNamed(
            Routes.chatHub,
            arguments: ChatHubArguments(conversation: conversation),
          )?.then((_) => Get.find<ChatDashboardController>().refresh());
        },
      ),
      onLongPressStart: (details) {
        if (conversation.isBlocked && !conversation.blockedByMe) {
          return;
        }
        showPreviewChat(
          context: context,
          details: details,
        );
      },
    );

    if (showChildOnly) {
      return child;
    }

    return Slidable(
      key: ValueKey(conversation.id),
      enabled: !conversation.isGroup ||
          conversation
              .isCreatorOrAdmin(Get.find<AppController>().currentUser.id),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        extentRatio: 0.12,
        children: [_buildDeleteAction(context)],
      ),
      child: child,
    );
  }

  Widget _buildAvatar() {
    final child = AppCircleAvatar(
      url: conversation.avatarUrl ?? '',
    );

    if (conversation.isBlocked) {
      return Stack(
        children: [
          child,
          Positioned(
            bottom: 0,
            right: 0,
            child: AppIcon(
              icon: AppIcons.block,
              isCircle: true,
              padding: EdgeInsets.zero,
              backgroundColor: AppColors.negative,
              color: AppColors.white,
              size: Sizes.s20,
            ),
          ),
        ],
      );
    }

    return child;
  }

  Widget _buildTitle(BuildContext context) {
    // final lastMessage = conversation.lastMessage;

    // final partner = conversation.chatPartner();

    // bool isPartnerSeenLastMessage = false;

    // try {
    //   if (lastMessage != null &&
    //       partner != null &&
    //       conversation.lastSeenUsers != null) {
    //     final isMyMessage =
    //         lastMessage.isMine(myId: Get.find<AppController>().currentUser.id);

    //     // ignore: no-equal-then-else, prefer-conditional-expressions
    //     if (isMyMessage) {
    //       final messageCreateAt = lastMessage.createdAt;
    //       final partnerLastSeen = DateTime.fromMillisecondsSinceEpoch(
    //           conversation.lastSeenUsers![partner.id.toString()]!);
    //       isPartnerSeenLastMessage = messageCreateAt.isBefore(partnerLastSeen);
    //       if (isPartnerSeenLastMessage) {
    //         print(1);
    //       }
    //     }
    //   }
    // } catch (e) {
    //   LogUtil.e(e);
    // }

    if (!conversation.isGroup && conversation.chatPartner() != null) {
      return Row(
        children: [
          const Text('User Person'),
          const Spacer(),
          Text(
            DateTimeUtil.timeAgo(context, conversation.lastMessage!.createdAt),
            style: AppTextStyles.s12w500.subText3Color,
          ),
          // if (conversation.unreadCount != null && conversation.unreadCount! > 0)
          //   Container(
          //     margin: AppSpacing.edgeInsetsOnlyLeft4,
          //     padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
          //     decoration: BoxDecoration(
          //       color: AppColors.primary,
          //       borderRadius: BorderRadius.circular(10),
          //     ),
          //     child: Text(
          //       conversation.unreadCount.toString(),
          //       style: AppTextStyles.s12w500.copyWith(color: AppColors.white),
          //     ),
          //   )
          // else if (isPartnerSeenLastMessage)
          //   AppCircleAvatar(
          //     url: conversation.avatarUrl ?? '',
          //     size: 16,
          //   ),
        ],
      );
    }

    return Row(
      children: [
        if (conversation.isGroup) const Icon(Icons.group, size: 18),
        AppSpacing.gapW4,
        Expanded(
          child: Text(
            conversation.title(),
            style: AppTextStyles.s16w700,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        // if (conversation.isGroup)
        //   Container(
        //     margin: AppSpacing.edgeInsetsOnlyLeft4,
        //     padding: const EdgeInsets.symmetric(horizontal: Sizes.s4),
        //     decoration: BoxDecoration(
        //       color: Colors.transparent,
        //       borderRadius: const BorderRadius.all(Radius.circular(20)),
        //       border: Border.all(color: AppColors.border2),
        //     ),
        //     child: Text(
        //       context.l10n.text_group,
        //       style: AppTextStyles.s12w400.copyWith(fontSize: 10),
        //     ),
        //   ),
        Text(
          DateTimeUtil.timeAgo(context, conversation.lastMessage!.createdAt),
          style: AppTextStyles.s12w500.subText3Color,
        ),
        // if (conversation.unreadCount != null && conversation.unreadCount! > 0)
        //   Container(
        //     margin: AppSpacing.edgeInsetsOnlyLeft4,
        //     padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
        //     decoration: BoxDecoration(
        //       color: AppColors.primary,
        //       borderRadius: BorderRadius.circular(10),
        //     ),
        //     child: Text(
        //       conversation.unreadCount.toString(),
        //       style: AppTextStyles.s12w500.copyWith(color: AppColors.white),
        //     ),
        //   ),
      ],
    );
  }

  Widget? _buildSubtitle(BuildContext context) {
    final lastMessage = conversation.lastMessage;

    final sender = conversation.members.firstWhereOrNull(
      (e) => e.id == lastMessage?.senderId,
    );

    final senderText = sender == null
        ? null
        : sender.id == Get.find<AppController>().currentUser.id
            ? context.l10n.global__you
            : sender.contactName;

    String? content;

    final partner = conversation.chatPartner();

    bool isPartnerSeenLastMessage = false;

    try {
      if (lastMessage != null &&
          partner != null &&
          conversation.lastSeenUsers != null) {
        final isMyMessage =
            lastMessage.isMine(myId: Get.find<AppController>().currentUser.id);

        // ignore: no-equal-then-else, prefer-conditional-expressions
        if (isMyMessage) {
          final messageCreateAt = lastMessage.createdAt;
          final partnerLastSeen = DateTime.fromMillisecondsSinceEpoch(
              conversation.lastSeenUsers![partner.id.toString()]!);
          isPartnerSeenLastMessage = messageCreateAt.isBefore(partnerLastSeen);
          if (isPartnerSeenLastMessage) {
            print(1);
          }
        }
      }
    } catch (e) {
      LogUtil.e(e);
    }

    if (conversation.lastMessage != null) {
      final isMyMessage = conversation.lastMessage!
          .isMine(myId: Get.find<AppController>().currentUser.id);

      // ignore: no-equal-then-else, prefer-conditional-expressions
      if (!isMyMessage) {
        content = switch (conversation.lastMessage!.type) {
          MessageType.text => conversation.lastMessage!.contentWithoutFormat,
          MessageType.hyperText =>
            conversation.lastMessage!.contentWithoutFormat,
          MessageType.image => context.l10n.chat__sent_you_an_image,
          MessageType.video => context.l10n.chat__sent_you_a_video,
          MessageType.audio => context.l10n.chat__sent_you_a_voice,
          MessageType.call => context.l10n.chat__a_call,
          MessageType.file => context.l10n.chat__sent_a_document,
          MessageType.post => context.l10n.chat__sent_a_post,
          MessageType.sticker => context.l10n.chat__sent_a_sticker,
          MessageType.system => context.l10n.chat__sent_system_message,
        };
      } else {
        content = switch (conversation.lastMessage!.type) {
          MessageType.text => conversation.lastMessage!.contentWithoutFormat,
          MessageType.hyperText =>
            conversation.lastMessage!.contentWithoutFormat,
          MessageType.image => context.l10n.chat__you_sent_an_image,
          MessageType.video => context.l10n.chat__you_sent_a_video,
          MessageType.audio => context.l10n.chat__you_sent_a_voice,
          MessageType.call => context.l10n.chat__a_call,
          MessageType.file => context.l10n.chat__you_sent_a_document,
          MessageType.post => context.l10n.chat__sent_a_post,
          MessageType.sticker => context.l10n.chat__you_sent_a_sticker,
          MessageType.system => context.l10n.chat__sent_system_message,
        };
      }
    }

    if (content == null &&
        conversation.isGroup &&
        conversation.creator != null) {
      content = context.l10n
          .chat__name_created_group(conversation.creator!.contactName);
    }

    if (content == null) {
      return null;
    }

    return Padding(
      padding: AppSpacing.edgeInsetsOnlyTop4,
      child: Row(
        children: [
          Expanded(
            child: Text(
              senderText != null ? '$senderText: $content' : content,
              style: (conversation.unreadCount != null &&
                      conversation.unreadCount! > 0)
                  ? AppTextStyles.s12w700.text1Color
                  : AppTextStyles.s12w500.subText3Color,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          AppSpacing.gapW4,
          // Text(
          //   DateTimeUtil.timeAgo(context, conversation.lastMessage!.createdAt),
          //   style: AppTextStyles.s12w500.subText3Color,
          // ),
          if (!conversation.isGroup && conversation.chatPartner() != null) ...[
            if (conversation.unreadCount != null &&
                conversation.unreadCount! > 0)
              Container(
                // padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: AppColors.haveUnSeenMeesage,
                  // borderRadius: BorderRadius.circular(10),
                  shape: BoxShape.circle,
                ),
                // child: Text(
                //   conversation.unreadCount.toString(),
                //   style: AppTextStyles.s12w500.copyWith(color: AppColors.white),
                // ),
              )
            else if (isPartnerSeenLastMessage)
              AppCircleAvatar(
                url: conversation.avatarUrl ?? '',
                size: 16,
              ),
          ] else ...[
            if (conversation.unreadCount != null &&
                conversation.unreadCount! > 0)
              Container(
                // margin: AppSpacing.edgeInsetsOnlyLeft4,
                // padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                // decoration: BoxDecoration(
                //   color: AppColors.primary,
                //   borderRadius: BorderRadius.circular(10),
                // ),
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: AppColors.haveUnSeenMeesage,
                  // borderRadius: BorderRadius.circular(10),
                  shape: BoxShape.circle,
                ),
                // child: Text(
                //   conversation.unreadCount.toString(),
                //   style: AppTextStyles.s12w500.copyWith(color: AppColors.white),
                // ),
              ),
          ],
        ],
      ),
    ).marginOnly(right: 27.w);
  }

  // Widget? _buildTrailing(BuildContext context) {
  //   if (conversation.lastMessage == null) {
  //     return null;
  //   }

  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.end,
  //     children: [
  //       AppSpacing.gapH4,
  //       // if (conversation.isGroup)
  //       //   Container(
  //       //     padding: const EdgeInsets.symmetric(horizontal: Sizes.s2),
  //       //     decoration: BoxDecoration(
  //       //       color: Colors.transparent,
  //       //       borderRadius: const BorderRadius.all(
  //       //         Radius.circular(20),
  //       //       ),
  //       //       border: Border.all(color: AppColors.border2),
  //       //     ),
  //       //     child: Text(context.l10n.text_group),
  //       //   )
  //       // else
  //       if (conversation.unreadCount != null && conversation.unreadCount! > 0)
  //         Container(
  //           padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
  //           decoration: BoxDecoration(
  //             color: AppColors.primary,
  //             borderRadius: BorderRadius.circular(10),
  //           ),
  //           child: Text(
  //             conversation.unreadCount.toString(),
  //             style: AppTextStyles.s12w500.copyWith(color: AppColors.white),
  //           ),
  //         ),
  //     ],
  //   );
  // }

  Widget _buildDeleteAction(BuildContext context) {
    return Container(
      width: 0.12.sw,
      color: AppColors.negative,
      height: double.infinity,
      child: AppIcon(
        icon: AppIcons.removeChatDashboard,
        color: AppColors.white,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        onTap: () => _onDeleteChat(context),
      ),
    );
  }

  Widget _buildMuteAction(BuildContext context) {
    return Container(
      color: AppColors.button5,
      height: double.infinity,
      child: AppIcon(
        icon: AppIcons.muteChatDashboard,
        color: AppColors.white,
        padding: AppSpacing.edgeInsetsAll8,
        onTap: () => _onMuteChat(context),
      ),
    );
  }

  Future<void> showPreviewChat(
      {required BuildContext context,
      required LongPressStartDetails details}) async {
    final chatDashboardController = Get.find<ChatDashboardController>();
    final List<Message> messageList = [];
    final indexLastSeen = findIndexLastSeen(
      lastSeenUsers: conversation.lastSeenUsers!,
      messages: messageList,
      conversation: conversation,
      currentUserId: chatDashboardController.currentUser.id,
    );

    final double screenHeight = MediaQuery.of(context).size.height;
    final double yPosition = details.globalPosition.dy;
    String position = '';
    // Xác định vị trí nhấn theo chiều dọc
    if (yPosition < screenHeight / 3) {
      position = 'top';
    } else if (yPosition < 2 * screenHeight / 3) {
      position = 'center';
    } else {
      position = 'bottom';
    }
    HapticFeedback.lightImpact();
    Navigator.of(context).push(
      HeroDialogRoute(
        builder: (context) {
          final menuItems = _showMessageOptions(context);

          return PreviewChatDialogWidget(
            id: conversation.id,
            menuItems: menuItems,
            messageWidget: const SizedBox(),
            onReactionTap: (reaction) {},
            onContextMenuTap: (item) {
              item.onPressed.call();
              // handle context menu item
            },
            position: position,
            messages: messageList,
            conversation: conversation,
            currentUserId: chatDashboardController.currentUser.id,
            indexLastSeen: indexLastSeen,
          );
        },
      ),
    );
  }

  List<MenuItem> _showMessageOptions(BuildContext context) {
    final items = <MenuItem>[];

    // items.add(
    //   MenuItem(
    //     label: context.l10n.chat_dashboard__mark_seen_message,
    //     icon: const Icon(
    //       Icons.mark_chat_read_outlined,
    //       size: 20,
    //       color: AppColors.grey8,
    //     ),
    //     onPressed: () {
    //       Get.find<ChatDashboardController>()
    //           .updateLastSeenMessage(conversation.id);
    //     },
    //   ),
    // );

    items.add(
      MenuItem(
        label: conversation.isBlocked
            ? context.l10n.text_unblock
            : context.l10n.button__block_user,
        icon: Assets.icons.block,
        onPressed:
            conversation.isBlocked ? _unBlockUserPressed : _onBlockUserPressed,
      ),
    );

    items.add(
      MenuItem(
          label: context.l10n.chat_dashboard__delete_conversation,
          icon: AppIcons.trash.svg(color: AppColors.negative),
          onPressed: () {
            _onDeleteChat(context);
          }),
    );

    return items;
  }

  int findIndexLastSeen({
    required Map<String, int> lastSeenUsers,
    required List<Message> messages,
    required Conversation conversation,
    required int currentUserId,
  }) {
    var res = -1;
    try {
      if (conversation.isGroup) {
        return res;
      }

      final partner = conversation.chatPartner();
      final partnerLastSeen = DateTime.fromMillisecondsSinceEpoch(
          lastSeenUsers[partner!.id.toString()]!);

      for (int i = 0; i < messages.length; i++) {
        final message = messages[i];
        final messageCreateAt = message.createdAt;
        final isPartnerSeenLastMessage =
            messageCreateAt.isBefore(partnerLastSeen);
        if (message.isMine(myId: currentUserId)) {
          if (isPartnerSeenLastMessage) {
            res = i;
            break;
          }
        } else {
          break;
        }
      }
    } catch (e) {
      LogUtil.e(e);
    }
    return res;
  }

  void _onBlockUserPressed() {
    Get.find<ChatDashboardController>().blockConversation(conversation);
  }

  void _unBlockUserPressed() {
    Get.find<ChatDashboardController>().unblockConversation(conversation);
  }
}
