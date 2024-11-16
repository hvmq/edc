import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../core/all.dart';
import '../../../../../../models/all.dart';
import '../../../../../common_controller.dart/all.dart';
import '../../../../../common_widgets/all.dart';
import '../../../../../resource/resource.dart';
import '../../../../all.dart';
import '../../controllers/pin_message_controller.dart';
import '_message_item.dart';

class PinMessagesWidget extends StatefulWidget {
  const PinMessagesWidget({super.key});

  @override
  State<PinMessagesWidget> createState() => _PinMessagesWidgetState();
}

class _PinMessagesWidgetState extends State<PinMessagesWidget> {
  final scrollController = ScrollController();
  late CommonPagingController<Message> pagingController;

  User get currentUser => Get.find<AppController>().lastLoggedUser!;
  PinMessageController pinMessageController = Get.find<PinMessageController>();
  late Worker worker;

  @override
  void initState() {
    pagingController = CommonPagingController<Message>();
    pagingController.pagingController.addPageRequestListener(getPinMessages);
    worker = ever(
      pinMessageController.rxPinnedMessages,
      (callback) => pagingController.pagingController.refresh(),
    );
    super.initState();
  }

  Future getPinMessages(int pageKey) async {
    pagingController.pagingController
        .appendLastPage(pinMessageController.pinnedMessages);

    return;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppSpacing.gapH4,
        Obx(
          () => Text(
            '${pinMessageController.pinnedMessages.length} '
            '${context.l10n.conversation__pinned_message}',
            style: AppTextStyles.s16w600.copyWith(
              color: AppColors.text1,
            ),
          ),
        ),
        AppSpacing.gapH4,
        Expanded(
          child: CommonPagedListView<Message>(
            scrollController: scrollController,
            pagingController: pagingController,
            padding: AppSpacing.edgeInsetsH20,
            separatorBuilder: (context, index) => AppSpacing.gapH16,
            itemBuilder: (context, message, index) {
              final previousMessage =
                  index + 1 < pagingController.itemList!.length
                      ? pagingController.itemList![index + 1]
                      : null;

              return MessageItem(
                key: ValueKey(message.id),
                isMine: message.isMine(myId: currentUser.id),
                message: message,
                previousMessage: previousMessage,
                currentUserId: currentUser.id,
                stateMessage: StateMessage.sent,
                onTap: () {
                  if (Get.isBottomSheetOpen == true) {
                    Get.back();
                  }
                  Get.find<ChatHubController>().jumpToMessage(message);
                },
                onPressedUserAvatar: () {
                  if (Get.isBottomSheetOpen == true) {
                    Get.back();
                  }
                  Get.find<ChatHubController>().onUserAvatarTap(message);
                },
                onMentionPressed:
                    Get.find<ChatHubController>().onMentionPressed,
              );
            },
          ),
        ),
        InkWell(
          onTap: unPinAllMessage,
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: Sizes.s12,
              horizontal: Sizes.s12,
            ),
            color: AppColors.fieldBackground,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  context.l10n.button__unpin_all_message,
                  style:
                      AppTextStyles.s16w700.copyWith(color: AppColors.button5),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    pagingController.dispose();
    worker.dispose();
    super.dispose();
  }

  Future unPinAllMessage() async {
    await Get.find<PinMessageController>().unPinAllMessage();
    if (Get.isBottomSheetOpen == true) {
      Get.back();
    }
  }
}
