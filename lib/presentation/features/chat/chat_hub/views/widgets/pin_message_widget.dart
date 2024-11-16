import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../../core/all.dart';
import '../../../../../../models/all.dart';
import '../../../../../common_widgets/all.dart';
import '../../../../../resource/resource.dart';
import '../../controllers/pin_message_controller.dart';

class PinMessageWidget extends StatefulWidget {
  final Conversation conversation;

  const PinMessageWidget({
    required this.conversation,
    super.key,
  });

  @override
  State<PinMessageWidget> createState() => _PinMessageWidgetState();
}

class _PinMessageWidgetState extends State<PinMessageWidget> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: PinMessageController(widget.conversation),
      builder: (controller) => Obx(
        () {
          if (controller.pinnedMessages.isEmpty) {
            return AppSpacing.emptyBox;
          } else {
            final lastMessage = controller.pinnedMessages.last;

            return Column(
              children: [
                Container(
                  height: 60.h,
                  decoration: BoxDecoration(
                    color: AppColors.backgroundPinMessage,
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: Sizes.s4.h,
                    horizontal: Sizes.s20.w,
                  ),
                  child: GestureDetector(
                    onTap: () => controller.onMessageClick(lastMessage),
                    behavior: HitTestBehavior.translucent,
                    child: Row(
                      children: [
                        Container(
                          width: 2,
                          decoration: const BoxDecoration(
                            color: AppColors.chat_hub__icon_reply,
                            borderRadius: BorderRadius.all(
                              Radius.circular(4.0),
                            ),
                          ),
                        ),
                        AppSpacing.gapW8,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                context.l10n.conversation__pinned_message,
                                style: AppTextStyles.s16w600
                                    .copyWith(color: AppColors.titlePinMessage),
                              ),
                              Text(
                                message(
                                  context,
                                  lastMessage,
                                ),
                                style: AppTextStyles.s14w600,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        // InkWell(
                        //   onTap: controller.showListPinnedMessages,
                        //   child: Container(
                        //     padding: EdgeInsets.all(10.r),
                        //     decoration: BoxDecoration(
                        //       color: AppColors.button5.withOpacity(0.5),
                        //       borderRadius: BorderRadius.circular(10.r),
                        //     ),
                        //     child: const AppIcon(
                        //       icon: Icons.arrow_drop_down_circle_outlined,
                        //       color: AppColors.white,
                        //     ),
                        //   ),
                        // ),
                        // const AppIcon(
                        //   icon: Icon(
                        //     Icons.clear,
                        //     size: 16,
                        //   ),
                        //   size: 16,
                        //   color: AppColors.subText3,
                        // ).paddingOnly(bottom: 10.h).clickable(() {
                        //   controller.showListPinnedMessages();
                        // }),
                        Padding(
                          padding: EdgeInsets.only(bottom: 20.h),
                          child: InkWell(
                            onTap: () {
                              controller.showListPinnedMessages();
                            },
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
                ),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.backgroundPinMessage,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        offset: const Offset(0, 1),
                        spreadRadius: 1,
                        blurRadius: 5,
                        blurStyle: BlurStyle.solid,
                      ),
                    ],
                  ),
                ),
              ],
            ).clickable(() {});
          }
        },
      ),
    );
  }

  String message(BuildContext context, Message message) {
    final l10n = context.l10n;

    return switch (message.type) {
      MessageType.text => message.content,
      MessageType.hyperText => message.contentWithoutFormat,
      MessageType.image => l10n.conversation__pinned_image,
      MessageType.video => l10n.conversation__pinned_video,
      MessageType.audio => l10n.conversation__pinned_audio,
      MessageType.call => l10n.conversation__pinned_call,
      MessageType.file => l10n.conversation__pinned_file,
      MessageType.post => l10n.conversation__pinned_post,
      MessageType.sticker => l10n.conversation__pinned_sticker,
      MessageType.system => l10n.conversation__system_message,
    };
  }
}
