import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:styled_text/styled_text.dart';

import '../../../../../../core/all.dart';
import '../../../../../../models/all.dart';
import '../../../../../resource/resource.dart';
import '../../all.dart';

class TextMessageWidget extends StatelessWidget {
  final bool isMine;
  final Message message;
  final List<User> members;
  final Function(String? mention, Map<String, int> mentionUserIdMap)
      onMentionPressed;
  final EdgeInsets? padding;
  final Color? backgroundColor;
  final int? maxLines;
  final bool isPreviewReply;

  const TextMessageWidget({
    required this.isMine,
    required this.message,
    required this.members,
    required this.onMentionPressed,
    super.key,
    this.padding,
    this.backgroundColor,
    this.maxLines,
    this.isPreviewReply = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(Sizes.s12),
          topRight: const Radius.circular(Sizes.s12),
          bottomRight: isMine
              ? const Radius.circular(0)
              : const Radius.circular(Sizes.s12),
          bottomLeft: isMine
              ? const Radius.circular(Sizes.s12)
              : const Radius.circular(0),
        ),
        color:
            backgroundColor ?? (isMine ? AppColors.button5 : AppColors.grey7),
      ),
      padding: isPreviewReply
          ? const EdgeInsets.fromLTRB(0, Sizes.s8, Sizes.s24, Sizes.s8)
          : const EdgeInsets.symmetric(
              horizontal: Sizes.s24,
              vertical: Sizes.s8,
            ),
      child: Builder(
        builder: (context) {
          if (message.isMentionedMessage ||
              message.type == MessageType.hyperText) {
            String content = message.getDisplayContent;

            final mentionedUserIds = message.mentionedUserIds;

            final mentionUserIdMap = <String, int>{};

            for (final userId in mentionedUserIds) {
              final user = members.firstWhereOrNull(
                (element) => element.id == userId,
              );

              final mentionKey = userIdMentionWrapper.replaceAll(
                'userId',
                userId.toString(),
              );

              String? userFullName = user?.contact?.fullName ?? user?.fullName;

              if (userFullName == null) {
                final originMentionUserName =
                    message.mentions?.keys.toList().firstWhereOrNull(
                          (element) => element.contains(mentionKey),
                        );

                userFullName = originMentionUserName;
              }

              if (userFullName != null) {
                final toReplace =
                    '<${AppConstants.mentionTag}>@${userFullName.trim()}</${AppConstants.mentionTag}>';

                mentionUserIdMap[toReplace] = userId;
                content = content.replaceAll(
                  mentionKey,
                  toReplace,
                );
              }
            }

            return StyledText(
              text: content,
              style: AppTextStyles.s16w500.toColor(
                isPreviewReply
                    ? AppColors.text1
                    : isMine
                        ? AppColors.white
                        : AppColors.text1,
              ),
              maxLines: isPreviewReply ? 2 : null,
              overflow: isPreviewReply ? TextOverflow.ellipsis : null,
              tags: {
                AppConstants.mentionTag: StyledTextActionTag(
                  (mention, _) => onMentionPressed(mention, mentionUserIdMap),
                  style: AppTextStyles.s16w500.copyWith(
                    color: Colors.white,
                    decoration: TextDecoration.underline,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                AppConstants.hyperTextTag: StyledTextActionTag(
                  (hyper, _) {
                    if (hyper == null) {
                      return;
                    }
                    if (hyper.contains(Get.find<EnvConfig>().jitsiUrl)) {
                      final List<String> parts = hyper.split('/');

                      final String idMeeting = parts[3];

                      Get.find<ChatHubController>()
                          .createOrJoinCallJitsi(idMeeting, 'EDC Meet');
                    } else {}
                  },
                  style: AppTextStyles.s16w500.copyWith(
                    color: isPreviewReply
                        ? AppColors.text1
                        : isMine
                            ? Colors.white
                            : AppColors.text1,
                    decoration: TextDecoration.underline,
                    decorationColor: isPreviewReply
                        ? AppColors.text1
                        : isMine
                            ? Colors.white
                            : AppColors.text1,
                  ),
                ),
              },
            );
          }

          return Text(
            message.getDisplayContent,
            style: AppTextStyles.s16w500
                .toColor(
                  isPreviewReply
                      ? AppColors.text1
                      : isMine
                          ? AppColors.white
                          : AppColors.text1,
                )
                .copyWith(
                  decoration: TextDecoration.none,
                ),
            maxLines: isPreviewReply ? 2 : null,
            overflow: isPreviewReply ? TextOverflow.ellipsis : null,
          );
        },
      ),
    );
  }
}
