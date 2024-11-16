import 'package:flutter/material.dart';

import '../../../../../../core/all.dart';
import '../../../../../../models/all.dart';
import '../../../../../resource/resource.dart';
import 'hyper_text_message_widget.dart';
import 'text_message_widget.dart';

class ReplyMessageWidget extends StatelessWidget {
  final Message message;
  final bool isMine;
  final Function(Message) onClick;
  final List<User> members;
  final Function(String? mention, Map<String, int> mentionUserIdMap)
      onMentionPressed;

  const ReplyMessageWidget({
    required this.message,
    required this.isMine,
    required this.onClick,
    required this.members,
    required this.onMentionPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onClick(message),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border(
            left: isMine
                ? BorderSide.none
                : const BorderSide(
                    color: AppColors.button5,
                    width: Sizes.s4,
                  ),
            right: isMine
                ? const BorderSide(
                    color: AppColors.button5,
                    width: Sizes.s4,
                  )
                : BorderSide.none,
          ),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: Sizes.s4,
          horizontal: Sizes.s8,
        ),
        child: Column(
          crossAxisAlignment:
              isMine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            if (message.sender != null)
              contentMessage(
                context,
                message,
              ),
          ],
        ),
      ),
    );
  }

  Widget contentMessage(BuildContext context, Message message) {
    final l10n = context.l10n;

    return switch (message.type) {
      MessageType.text => TextMessageWidget(
          isMine: isMine,
          message: message,
          members: members,
          onMentionPressed: onMentionPressed,
          padding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          isPreviewReply: true,
        ),
      MessageType.hyperText => HyperTextMessageWidget(
          isMine: isMine,
          message: message,
          members: members,
          onMentionPressed: onMentionPressed,
          padding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          isTextEllipsis: true,
          isShowLinkPreview: false,
          maxLines: 2,
          isPreviewReply: true,
        ),
      MessageType.image => textWidget(l10n.conversation__pinned_image),
      MessageType.video => textWidget(l10n.conversation__pinned_video),
      MessageType.audio => textWidget(l10n.conversation__pinned_audio),
      MessageType.call => textWidget(l10n.conversation__pinned_call),
      MessageType.file => textWidget(l10n.conversation__pinned_file),
      MessageType.post => textWidget(l10n.conversation__pinned_post),
      MessageType.sticker => textWidget(l10n.conversation__pinned_sticker),
      MessageType.system => textWidget(context.l10n.chat__sent_system_message),
    };
  }

  Widget textWidget(String message) {
    return Text(
      message,
      style: AppTextStyles.s14w600,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
