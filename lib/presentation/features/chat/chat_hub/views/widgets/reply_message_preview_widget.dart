import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/all.dart';
import '../../../../../../models/all.dart';
import '../../../../../common_widgets/all.dart';
import '../../../../../resource/resource.dart';
import 'hyper_text_message_widget.dart';
import 'text_message_widget.dart';

class ReplyMessagePreviewWidget extends StatelessWidget {
  final Message message;
  final Function() onCloseMessage;
  final bool isMine;
  final List<User> members;
  final Function(String? mention, Map<String, int> mentionUserIdMap)
      onMentionPressed;

  const ReplyMessagePreviewWidget({
    required this.message,
    required this.onCloseMessage,
    required this.isMine,
    required this.members,
    required this.onMentionPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: Sizes.s8,
        bottom: Sizes.s8,
        right: Sizes.s20,
      ),
      decoration: BoxDecoration(
        color: AppColors.grey11,
        // borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color:
                Colors.black.withOpacity(0.25), // #000000 với 25% độ trong suốt
            offset: const Offset(0, 2), // X: 0, Y: 2
            blurRadius: 4, // Độ mờ của bóng
          ),
        ],
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            const SizedBox(width: 20),
            AppIcon(
              icon: Assets.icons.replyMessage,
              color: AppColors.chat_hub__icon_reply,
              size: 20,
            ),
            const SizedBox(width: 20),
            Container(
              width: 2,
              color: AppColors.chat_hub__icon_reply,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // if (message.sender != null)
                  //   ContactDisplayNameText(
                  //     user: message.sender!,
                  //     style: AppTextStyles.s16w700.text1Color,
                  //   ),
                  Text(
                    context.l10n.chat_hub__reply_message,
                    style: AppTextStyles.s14w500.subText3Color,
                  ),
                  contentMessage(context, message),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20.h),
              child: InkWell(
                onTap: onCloseMessage,
                child: const AppIcon(
                  icon: Icons.close,
                  color: AppColors.subText3,
                  size: 20,
                ),
              ),
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

  Widget textWidget(String text) {
    return Text(
      text,
      style: AppTextStyles.s14w600,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
