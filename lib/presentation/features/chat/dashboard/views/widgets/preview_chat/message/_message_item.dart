import 'dart:convert';

import 'package:any_link_preview/any_link_preview.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../../../../core/extensions/all.dart';

import '../../../../../../../../models/all.dart';
import '../../../../../../../../models/message_system.dart';

import '../../../../../../../common_widgets/app_blurry_container.dart';
import '../../../../../../../common_widgets/app_icon.dart';
import '../../../../../../../common_widgets/button.dart';
import '../../../../../../../common_widgets/circle_avatar.dart';
import '../../../../../../../common_widgets/network_image.dart';

import '../../../../../../../resource/styles/app_colors.dart';
import '../../../../../../../resource/styles/gaps.dart';
import '../../../../../../../resource/styles/text_styles.dart';
import '_call_message_body.dart';
import '_media_message_body.dart';
import 'reply_message_widget.dart';
import 'swipe_to_reply_wrapper.dart';
import 'text_message_widget.dart';

class PreviewMessageItem extends StatelessWidget {
  final Message message;
  final Message? previousMessage;
  final Message? nextMessage;
  final bool isMine;
  final int currentUserId;
  final Function()? onTap;
  final VoidCallback onPressedUserAvatar;
  final bool isAdmin;
  final List<User> members;
  final bool isGroup;
  final Function(String? mention, Map<String, int> mentionUserIdMap)
      onMentionPressed;
  final Conversation conversation;

  PreviewMessageItem({
    required this.message,
    required this.currentUserId,
    required this.onPressedUserAvatar,
    required this.onMentionPressed,
    required this.conversation,
    super.key,
    this.isMine = false,
    this.previousMessage,
    this.nextMessage,
    this.onTap,
    this.isAdmin = false,
    this.members = const [],
    this.isGroup = false,
  });

  final ValueNotifier<bool> _showMessageDisplayStateButton =
      ValueNotifier(false);

  void _toggleMessageDisplayState(BuildContext context) {
    if (!message.type.isTranslatable) {
      return;
    }

    _showMessageDisplayStateButton.value =
        !_showMessageDisplayStateButton.value;
  }

  @override
  Widget build(BuildContext context) {
    bool shouldPadding = true;
    if (previousMessage != null) {
      // log('--------------------------');
      // log(previousMessage!.type.toString());
      // log(previousMessage!.content.toString());
      // log(message.content);
      // log('--------------------------');
      if (previousMessage!.type == MessageType.text &&
          message.repliedFrom == null &&
          message.forwardedFrom == null &&
          message.type == MessageType.text &&
          message.createdAt.isSameDay(previousMessage!.createdAt)) {
        shouldPadding = false;
      }
    }
    final child = Column(
      children: [
        shouldPadding
            ? AppSpacing.gapH16
            : const SizedBox(
                height: 2,
              ),
        _buildDate(),
        if (message.type == MessageType.system && isGroup)
          _buildSystemMessage(context),
        if (message.type != MessageType.system)
          PreviewSwipeToReply(
            isMyMessage: isMine,
            onReply: () {},
            child: Column(
              crossAxisAlignment:
                  isMine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                if (isGroup) _buildSenderName(),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment:
                      isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
                  children: [
                    if (!isMine) _buildMessageAvatar(),
                    AppSpacing.gapW8,
                    Flexible(child: _buildMessageBody(context)),
                  ],
                ),
              ],
            ),
          ),
      ],
    );

    return GestureDetector(
      onTap: onTap,
      child: child,
    );
  }

  Widget _buildMessageAvatar() {
    // Check if next message is from the same user to avoid showing the avatar
    final bool shouldShowAvatar = nextMessage == null ||
        nextMessage!.senderId != message.senderId ||
        nextMessage!.type == MessageType.system;

    return shouldShowAvatar
        ? Padding(
            padding: const EdgeInsets.only(bottom: 24, right: 4),
            child: AppCircleAvatar(
              url: message.sender?.avatarPath ?? '',
              size: Sizes.s36,
            ).clickable(onPressedUserAvatar),
          )
        : AppSpacing.gapW40;
  }

  Widget _buildDate() {
    final bool shouldShowDate = previousMessage == null ||
        !message.createdAt.isSameDay(previousMessage!.createdAt);

    return shouldShowDate
        ? IgnorePointer(
            child: Container(
              padding: AppSpacing.edgeInsetsAll16.copyWith(top: 0),
              alignment: Alignment.center,
              child: Text(
                message.createdAt.toLocaleString(),
                style: AppTextStyles.s12w400
                    .toColor(
                      AppColors.grey8,
                    )
                    .copyWith(decoration: TextDecoration.none),
              ),
            ),
          )
        : AppSpacing.emptyBox;
  }

  Widget _buildMessageBody(BuildContext context) {
    final Widget messageBody;

    switch (message.type) {
      case MessageType.text:
        messageBody = PreviewTextMessageWidget(
            isMine: isMine,
            message: message,
            members: members,
            onMentionPressed: onMentionPressed);
      case MessageType.hyperText:
        messageBody = _buildHyperTextMessage();
      case MessageType.image:
      case MessageType.video:
      case MessageType.audio:
        messageBody = PreviewMediaMessageBody(
          key: ValueKey(message.id),
          message: message,
          isMine: isMine,
        );
      case MessageType.call:
        messageBody = PreviewCallMessageBody(
          message: message,
          isMine: isMine,
          currentUserId: message.senderId,
          conversation: conversation,
        );
      case MessageType.file:
        messageBody = _buildFileMessage();
      case MessageType.post:
        messageBody = _buildPostMessage(context);
      case MessageType.sticker:
      case MessageType.system:
        return AppSpacing.emptyBox;
    }

    bool shouldShowTime = true;
    if (nextMessage != null) {
      if (message.createdAt.isSameDay(nextMessage!.createdAt) &&
          (nextMessage!.type == MessageType.text ||
              nextMessage!.type == MessageType.sticker ||
              nextMessage!.type == MessageType.file ||
              nextMessage!.type == MessageType.call ||
              nextMessage!.type == MessageType.audio ||
              nextMessage!.type == MessageType.hyperText ||
              nextMessage!.type == MessageType.image ||
              nextMessage!.type == MessageType.video ||
              nextMessage!.type == MessageType.post) &&
          message.forwardedFrom == null &&
          (message.type == MessageType.text ||
              message.type == MessageType.sticker ||
              message.type == MessageType.file ||
              message.type == MessageType.call ||
              message.type == MessageType.audio ||
              message.type == MessageType.hyperText ||
              message.type == MessageType.image ||
              message.type == MessageType.video ||
              message.type == MessageType.post) &&
          nextMessage!.senderId == message.senderId) {
        shouldShowTime = false;
      }
    }

    return Column(
      crossAxisAlignment:
          isMine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        if (message.repliedFrom != null)
          PreviewReplyMessageWidget(
            message: message.repliedFrom!,
            isMine: isMine,
            onClick: _onJumpToRepliedMessage,
            members: members,
            onMentionPressed: onMentionPressed,
          ),
        if (message.forwardedFrom != null)
          Text(
            context.l10n.chat__forward_message,
            style: AppTextStyles.s12w600.subText1Color,
          ).paddingOnly(bottom: Sizes.s8),
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isMine)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      message.type == MessageType.text ||
                              message.type == MessageType.hyperText
                          ? SizedBox(
                              width: 0.15.sw,
                            )
                          : AppSpacing.gapW8,
                      // _buildButtonReaction(),
                    ],
                  ),
                  AppSpacing.gapW8,
                ],
              ),
            Flexible(
              child: GestureDetector(
                onTap: () => _toggleMessageDisplayState(context),
                // onLongPress: () => _showMessageOptions(context),

                onDoubleTap: () {},
                child: Hero(
                  tag: message.id,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: !isMine
                        ? CrossAxisAlignment.start
                        : CrossAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: isMine
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                        children: [
                          messageBody,
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _buildShowReaction(
                                message.reactions,
                              ),
                            ],
                          ),
                        ],
                      ),
                      _buildMessageBottomContainer(context, shouldShowTime),
                    ],
                  ),
                ),
              ),
            ),
            if (!isMine)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppSpacing.gapW8,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      message.type == MessageType.text ||
                              message.type == MessageType.hyperText
                          ? SizedBox(
                              width: 0.15.sw,
                            )
                          : AppSpacing.gapW8,
                      // _buildButtonReaction(),
                    ],
                  ),
                ],
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildMessageBottomContainer(BuildContext context, bool isShowTime) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: message.isMine(myId: currentUserId)
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      children: [
        ValueListenableBuilder(
          valueListenable: _showMessageDisplayStateButton,
          builder: (context, value, child) {
            if (!value) {
              return AppSpacing.emptyBox;
            }

            return Padding(
              padding: const EdgeInsets.only(left: Sizes.s8, right: Sizes.s16),
              child: Text(
                message.isShowingTranslatedMessage
                    ? context.l10n.chat_hub__see_original_btn
                    : context.l10n.chat_hub__see_translation_btn,
                style: AppTextStyles.s14w400.toColor(
                  AppColors.pacificBlue,
                ),
              ),
            ).clickable(() {});
          },
        ),
        if (isShowTime)
          Padding(
            padding: message.reactions != null
                ? EdgeInsets.zero
                : AppSpacing.edgeInsetsV4,
            child: Text(
              message.createdAt.toStringTimeOnly(),
              style: AppTextStyles.s12w400
                  .toColor(
                    AppColors.border2,
                  )
                  .copyWith(decoration: TextDecoration.none),
            ),
          ),
      ],
    );
  }

  Widget _buildSenderName() {
    if (isMine ||
        message.sender == null ||
        (previousMessage != null &&
            previousMessage!.senderId == message.senderId)) {
      return AppSpacing.emptyBox;
    }

    return const Padding(
      padding: EdgeInsets.only(
        left: Sizes.s48,
        bottom: Sizes.s8,
      ),
    );
  }

  Widget _buildFileMessage() {
    return AppBlurryContainer(
      blur: isMine ? 5 : 0,
      borderRadius: Sizes.s12,
      color: isMine
          ? AppColors.popup.withOpacity(0.22)
          : AppColors.label1Color.withOpacity(0.58),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.insert_drive_file,
            color: isMine ? AppColors.button5 : AppColors.text1,
          ),
          AppSpacing.gapW4,
          Flexible(
            child: Text(
              message.content.split('/').last,
              style: AppTextStyles.s16w400.toColor(
                isMine ? AppColors.button5 : AppColors.text1,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    ).clickable(() {});
  }

  Widget _buildPostMessage(BuildContext context) {
    final Post post = Post.fromJson(jsonDecode(message.content));

    return AppBlurryContainer(
      blur: isMine ? 5 : 0,
      color: isMine
          ? AppColors.popup.withOpacity(0.22)
          : AppColors.label1Color.withOpacity(0.58),
      padding: EdgeInsets.zero,
      child: SizedBox(
        width: 0.6.sw,
        child: Column(
          children: [
            if (post.attachments.isNotEmpty)
              AppNetworkImage(
                post.attachments.first.thumb ?? '',
                width: 0.6.sw,
                height: 0.6.sw,
                fit: BoxFit.fitWidth,
              ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if ((post.content ?? '').isNotEmpty)
                  ExpandableText(
                    (post.content ?? '').trim(),
                    expandText: context.l10n.global__show_more_label,
                    collapseText: context.l10n.global__show_less_label,
                    textAlign: TextAlign.left,
                    style: AppTextStyles.s14w600,
                    linkColor: AppColors.subText1,
                    onUrlTap: (url) {},
                    urlStyle: AppTextStyles.s12w500.text4Color,
                  ),
                AppSpacing.gapH8,
                AppButton.secondary(
                  color: AppColors.button5,
                  label: context.l10n.newsfeed__view_post,
                  textStyleLabel: AppTextStyles.s14w400,
                  width: double.infinity,
                  padding: EdgeInsets.zero,
                  height: Sizes.s40,
                  onPressed: () {},
                ),
              ],
            ).marginSymmetric(horizontal: Sizes.s16, vertical: Sizes.s12),
          ],
        ),
      ),
    );
  }

  Widget _buildHyperTextMessage() {
    return Column(
      crossAxisAlignment:
          isMine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        PreviewTextMessageWidget(
            isMine: isMine,
            message: message,
            members: members,
            onMentionPressed: onMentionPressed),
        ...message.linksInContent.map((link) {
          return Container(
            decoration: BoxDecoration(
              color: isMine
                  ? AppColors.popup.withOpacity(0.22)
                  : AppColors.label1Color.withOpacity(0.58),
              borderRadius: AppRadius.borderRadius12,
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: isMine
                    ? [AppColors.button5, AppColors.button5]
                    : AppColors.background13,
              ),
            ),
            margin: AppSpacing.edgeInsetsOnlyTop4,
            child: Material(
              child: AnyLinkPreview(
                link: link,
                bodyMaxLines: 5,
                borderRadius: 12,
                cache: const Duration(days: 5),
                backgroundColor: Colors.white,
                titleStyle: AppTextStyles.s16w600.text2Color
                    .copyWith(decoration: TextDecoration.none),
                bodyStyle: AppTextStyles.s12w400.subText2Color
                    .copyWith(decoration: TextDecoration.none),
              ),
            ),
          );
        }).toList(),
      ],
    );
  }

  void _onReplyMessagePressed() {}

  void _onJumpToRepliedMessage(Message message) {}

  Widget _buildShowReaction(Map<String, dynamic>? reactions) {
    if (reactions == null || reactions.isEmpty) {
      return const SizedBox();
    }

    final List<String> like = [];
    final List<String> love = [];
    final List<String> haha = [];
    final List<String> wow = [];
    final List<String> angry = [];
    final List<String> sad = [];

    reactions.forEach((key, value) {
      if (key == ReactionMessageEnum.like.name) {
        for (var item in value) {
          like.add(item.toString());
        }
      }

      if (key == ReactionMessageEnum.love.name) {
        for (var item in value) {
          love.add(item.toString());
        }
      }

      if (key == ReactionMessageEnum.haha.name) {
        for (var item in value) {
          haha.add(item.toString());
        }
      }

      if (key == ReactionMessageEnum.wow.name) {
        for (var item in value) {
          wow.add(item.toString());
        }
      }

      if (key == ReactionMessageEnum.angry.name) {
        for (var item in value) {
          angry.add(item.toString());
        }
      }

      if (key == ReactionMessageEnum.sad.name) {
        for (var item in value) {
          sad.add(item.toString());
        }
      }
    });

    return Transform.translate(
      offset: const Offset(0, -Sizes.s8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!isMine) AppSpacing.gapW8,
          if (love.isNotEmpty)
            _buildItemReaction(
              icon: '❤️',
              reactListUser: love,
              onTap: () {
                _buildShowBottomSheetUserReaction(reactions);
              },
            ),
          if (haha.isNotEmpty)
            _buildItemReaction(
              icon: '😆',
              reactListUser: haha,
              onTap: () {
                _buildShowBottomSheetUserReaction(reactions);
              },
            ),
          if (sad.isNotEmpty)
            _buildItemReaction(
              icon: '😢',
              reactListUser: sad,
              onTap: () {
                _buildShowBottomSheetUserReaction(reactions);
              },
            ),
          if (like.isNotEmpty)
            _buildItemReaction(
              icon: '👍',
              reactListUser: like,
              onTap: () {
                _buildShowBottomSheetUserReaction(reactions);
              },
            ),
          if (angry.isNotEmpty)
            _buildItemReaction(
              icon: '😡',
              reactListUser: angry,
              onTap: () {
                _buildShowBottomSheetUserReaction(reactions);
              },
            ),
          if (wow.isNotEmpty)
            _buildItemReaction(
              icon: '😮',
              reactListUser: wow,
              onTap: () {
                _buildShowBottomSheetUserReaction(reactions);
              },
            ),
          if (isMine) AppSpacing.gapW8,
        ],
      ),
    );
  }

  Widget _buildItemReaction({
    required String icon,
    List<String> reactListUser = const [],
    Function()? onTap,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Text(
            icon,
            style:
                const TextStyle(fontSize: 16, decoration: TextDecoration.none),
            textAlign: TextAlign.center,
          ),
        ),
        if (reactListUser.length > 1)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppSpacing.gapW2,
              Text(
                reactListUser.length.toString(),
                style: AppTextStyles.s12w400
                    .toColor(AppColors.pacificBlue)
                    .copyWith(decoration: TextDecoration.none),
              ),
            ],
          ),
      ],
    );
  }

  Future _buildShowBottomSheetUserReaction(Map<String, dynamic> reactions) {
    final List<String> like = [];
    final List<String> love = [];
    final List<String> haha = [];
    final List<String> wow = [];
    final List<String> angry = [];
    final List<String> sad = [];

    message.reactions?.forEach((key, value) {
      if (key == ReactionMessageEnum.like.name) {
        for (var item in value) {
          like.add(item.toString());
        }
      }

      if (key == ReactionMessageEnum.love.name) {
        for (var item in value) {
          love.add(item.toString());
        }
      }

      if (key == ReactionMessageEnum.haha.name) {
        for (var item in value) {
          haha.add(item.toString());
        }
      }

      if (key == ReactionMessageEnum.wow.name) {
        for (var item in value) {
          wow.add(item.toString());
        }
      }

      if (key == ReactionMessageEnum.angry.name) {
        for (var item in value) {
          angry.add(item.toString());
        }
      }

      if (key == ReactionMessageEnum.sad.name) {
        for (var item in value) {
          sad.add(item.toString());
        }
      }
    });

    final int tabLength = (like.isNotEmpty ? 1 : 0) +
        (love.isNotEmpty ? 1 : 0) +
        (haha.isNotEmpty ? 1 : 0) +
        (wow.isNotEmpty ? 1 : 0) +
        (angry.isNotEmpty ? 1 : 0) +
        (sad.isNotEmpty ? 1 : 0);

    return Get.bottomSheet(
      SizedBox(
        height: 0.4.sh,
        child: AppBlurryContainer(
          child: DefaultTabController(
            length: tabLength,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TabBar(
                  isScrollable: true,
                  tabAlignment: TabAlignment.start,
                  tabs: [
                    if (love.isNotEmpty)
                      Tab(
                        icon: AppIcon(
                          icon: AppIcons.love,
                          size: Sizes.s32,
                        ),
                      ),
                    if (haha.isNotEmpty)
                      Tab(
                        icon: AppIcon(
                          icon: AppIcons.haha,
                          size: Sizes.s32,
                        ),
                      ),
                    if (sad.isNotEmpty)
                      Tab(
                        icon: AppIcon(
                          icon: AppIcons.sad,
                          size: Sizes.s32,
                        ),
                      ),
                    if (like.isNotEmpty)
                      Tab(
                        icon: AppIcon(
                          icon: AppIcons.like,
                          size: Sizes.s32,
                        ),
                      ),
                    if (angry.isNotEmpty)
                      Tab(
                        icon: AppIcon(
                          icon: AppIcons.angry,
                          size: Sizes.s32,
                        ),
                      ),
                    if (wow.isNotEmpty)
                      Tab(
                        icon: AppIcon(
                          icon: AppIcons.wow,
                          size: Sizes.s32,
                        ),
                      ),
                  ],
                ),
                AppSpacing.gapH12,
                Expanded(
                  child: TabBarView(
                    children: [
                      if (love.isNotEmpty) _buildItemBottomSheet(love),
                      if (haha.isNotEmpty) _buildItemBottomSheet(haha),
                      if (like.isNotEmpty) _buildItemBottomSheet(like),
                      if (sad.isNotEmpty) _buildItemBottomSheet(sad),
                      if (angry.isNotEmpty) _buildItemBottomSheet(angry),
                      if (wow.isNotEmpty) _buildItemBottomSheet(wow),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<List<User>> getUsersByIds(List<String> reactListUser) async {
    final userIds = reactListUser.map((str) => int.parse(str)).toList();

    return members;
  }

  Widget _buildItemBottomSheet(List<String> reactListUser) {
    final members = getUsersByIds(reactListUser);

    return FutureBuilder<List<User>>(
      future: members,
      builder: (context, snapshot) {
        final members = snapshot.data ?? [];

        return Center(
          child: ListView.separated(
            itemCount: reactListUser.length,
            itemBuilder: (context, index) {
              final user = members.firstWhereOrNull(
                (element) => element.id.toString() == reactListUser[index],
              );

              return ListTile(
                leading: AppCircleAvatar(
                  url: user?.avatarPath ?? '',
                  size: Sizes.s40,
                ),
                title: Text(
                  (user?.contact?.fullName ?? '').isNotEmpty
                      ? user?.contact?.fullName ?? ''
                      : user?.fullName ?? '',
                  overflow: TextOverflow.ellipsis,
                ),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(height: 8),
          ),
        );
      },
    );
  }

  Widget _buildSystemMessage(BuildContext context) {
    try {
      final Widget messageSystemWidget;

      final messageSystem = MessageSystem.fromJson(jsonDecode(message.content));

      switch (messageSystem.type) {
        case MessageSystemType.addMember:
          messageSystemWidget = _buildTextMessageSystemAddMember(
            context,
            memberIds: messageSystem.memberIds,
          );
        case MessageSystemType.removeMember:
          messageSystemWidget = _buildTextMessageSystemRemoveMember(
            context,
            memberIds: messageSystem.memberIds,
          );
      }

      return messageSystemWidget;
    } catch (_) {
      return AppSpacing.emptyBox;
    }
  }

  Widget _buildTextMessageSystemAddMember(
    BuildContext context, {
    List<String> memberIds = const [],
  }) {
    final members = getUsersByIds(memberIds);

    return FutureBuilder<List<User>>(
      future: members,
      builder: (context, snapshot) {
        final members = snapshot.data ?? [];

        final user = members.firstWhereOrNull(
          (element) => memberIds.contains(element.id.toString()),
        );

        final name = user?.contactName ?? user?.fullName ?? '';

        return Text(
          context.l10n.conversation_details__add_member(name),
          style: AppTextStyles.s14w400
              .toColor(
                AppColors.button5,
              )
              .copyWith(decoration: TextDecoration.none),
        );
      },
    );
  }

  Widget _buildTextMessageSystemRemoveMember(
    BuildContext context, {
    List<String> memberIds = const [],
  }) {
    final members = getUsersByIds(memberIds);

    return FutureBuilder<List<User>>(
      future: members,
      builder: (context, snapshot) {
        final members = snapshot.data ?? [];

        final user = members.firstWhereOrNull(
          (element) => memberIds.contains(element.id.toString()),
        );

        final name = user?.contactName ?? user?.fullName ?? '';

        return Text(
          context.l10n.conversation_details__remove_member(name),
          style: AppTextStyles.s14w400
              .toColor(
                AppColors.button5,
              )
              .copyWith(decoration: TextDecoration.none),
        );
      },
    );
  }
}
