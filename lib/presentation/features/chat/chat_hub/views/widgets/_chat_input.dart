import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../../core/all.dart';
import '../../../../../common_widgets/all.dart';
import '../../../../../common_widgets/app_blurry_container.dart';
import '../../../../../common_widgets/shimmer.dart';
import '../../../../../resource/resource.dart';
import '../../controllers/chat_input_controller.dart';
import '../../controllers/record_controller.dart';
import 'reply_message_preview_widget.dart';

class ChatInput extends GetView<ChatInputController> {
  const ChatInput({super.key});

  void _onTyping(String value) {}

  void _onAttachmentButtonPressed() {
    // Future.delayed(const Duration(seconds: 1), () async {
    //   controller.setIsLoadingMedia(true);
    // });

    MediaHelper.pickMultipleMediaFromGallery().then((media) {
      controller.setIsLoadingMedia(false);
      if (media.isNotEmpty) {
        controller.attachImages(media);
        controller.pathLocal = media.first.file.path.substring(0, 24);
      }
    }).catchError(
      (error) {
        if (error is ValidationException) {
          // ViewUtil.showToast(
          //   title: Get.context!.l10n.error__file_is_too_large_title,
          //   message: Get.context!.l10n.error__file_is_too_large_message,
          // );
        }
        controller.setIsLoadingMedia(false);
      },
    ).whenComplete(() {
      controller.setIsLoadingMedia(false);
    });
  }

  void _onDocumentButtonPressed() {
    MediaHelper.pickDocument().then(
      (media) {
        controller.setIsLoadingMedia(false);
        if (media != null) {
          controller.attachMedia(media);
        }
      },
    ).catchError(
      (error) {
        if (error is ValidationException) {
          ViewUtil.showToast(
            title: Get.context!.l10n.error__file_is_too_large_title,
            message: Get.context!.l10n.error__file_is_too_large_message,
          );
        }
        controller.setIsLoadingMedia(false);
      },
    ).whenComplete(() {
      controller.setIsLoadingMedia(false);
    });
  }

  void _onCameraButtonPressed() {
    MediaHelper.takeImageFromCamera().then((media) {
      controller.setIsLoadingMedia(false);
      if (media != null) {
        controller.attachMedia(media);
      }
    }).catchError((error) {
      LogUtil.e(error);
      controller.setIsLoadingMedia(false);
    }).whenComplete(() {
      controller.setIsLoadingMedia(false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final child = Padding(
      padding: AppSpacing.edgeInsetsH8.copyWith(
        bottom: AppSpacing.bottomPaddingValue(context, additional: 0),
        left: 0,
        right: 0,
      ),
      child: GetBuilder<RecordController>(
        init: RecordController(),
        builder: (controller) {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: controller.isRecording.value
                ? _buildRecordingAudio()
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildToReplyMessagePreview(),
                      _buildToSendMediasPreview(),
                      _buildToSendMediaPreview(),
                      _buildToSendMediaPreviewLoading(),
                      Row(
                        children: [
                          AppSpacing.gapW8,
                          _buildStickerButton(),
                          Expanded(child: _buildTextField(context)),
                          // _buildShowMoreButton(),
                          // _buildRecordButton(),

                          _buildSendOrRecordButton(),
                          // AppSpacing.gapW4,
                          // _buildSendButton(context),
                        ],
                      ),
                    ],
                  ),
          );
        },
      ),
    );

    return Container(
      color: AppColors.grey11,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          _buildSearchMentionedUsers(),
          child,
        ],
      ),
    );
  }

  Widget _buildTextField(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextField(
          fillColor: Colors.transparent,
          // border: const OutlineInputBorder(
          //   borderSide: BorderSide.none,
          //   borderRadius: BorderRadius.all(Radius.circular(39)),
          // ),
          border: InputBorder.none,
          hintStyle: AppTextStyles.s16w400.copyWith(color: AppColors.grey8),
          controller: controller.textEditingController,
          focusNode: controller.focusNode,
          borderRadius: Sizes.s32,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: Sizes.s12,
            vertical: Sizes.s8,
          ),
          maxLines: 5,
          minLines: 1,
          hintText: context.l10n.chat_hub__input_hint,
          // hintText: context.l10n.text_type_message,

          onChanged: _onTyping,
          // onFieldSubmitted: (_) => controller.sendMessage(),
          // suffixIcon: _buildStickerButton(),
          // border: const OutlineInputBorder(
          //   borderSide: BorderSide(color: AppColors.border2),
          //   borderRadius: BorderRadius.all(Radius.circular(Sizes.s32)),
          // ),
          textCapitalization: TextCapitalization.sentences,
        ),
      ],
    );
  }

  Widget _buildToSendMediaPreview() {
    return Obx(
      () => controller.toSendMedia != null
          ? Padding(
              padding: AppSpacing.edgeInsetsV8,
              child: AppMediaPreview(
                media: controller.toSendMedia!,
                onRemove: controller.removeToSendMedia,
              ),
            ).marginOnly(left: 8)
          : AppSpacing.emptyBox,
    );
  }

  Widget _buildToSendMediasPreview() {
    return Obx(
      () => Column(
        children: [
          if (controller.toSendImages.isNotEmpty)
            SizedBox(
              height: 60,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: controller.toSendImages.length,
                  itemBuilder: (BuildContext context, int index) {
                    final item = controller.toSendImages[index];
                    return AppMediaPreview(
                      media: item,
                      onRemove: () {
                        controller.removeItemInMedias(item);
                      },
                    ).marginOnly(left: 8);
                  }),
            ),
        ],
      ),
    );
  }

  Widget _buildToSendMediaPreviewLoading() {
    return Obx(
      () => controller.isLoadingMedia.value
          ? SizedBox(
              height: 60,
              child: Row(
                children: [
                  const SizedBox(
                    width: 30,
                    height: 30,
                    child: CircularProgressIndicator(
                      color: AppColors.button5,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text('${controller.loadMediaPersent.value}%',
                      style: AppTextStyles.s12Base),
                ],
              ).marginOnly(left: 8),
            )
          : const SizedBox(),
    );
  }

  Widget loadingWidget(Widget child) {
    return Shimmer.fromColors(
      baseColor: AppColors.grey1.withOpacity(0.8),
      highlightColor: AppColors.grey1.withOpacity(0.4),
      child: child,
    );
  }

  Widget _buildToReplyMessagePreview() {
    return Obx(
      () => controller.chatHubController.replyFromMessage != null
          ? Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: ReplyMessagePreviewWidget(
                message: controller.chatHubController.replyFromMessage!,
                onCloseMessage: controller.chatHubController.removeReplyMessage,
                isMine: controller.chatHubController.replyFromMessage?.isMine(
                      myId: controller.chatHubController.currentUser.id,
                    ) ??
                    true,
                members: controller.chatHubController.conversation.members,
                onMentionPressed: controller.chatHubController.onMentionPressed,
              ),
            )
          : AppSpacing.emptyBox,
    );
  }

  Widget _buildSendOrRecordButton() {
    return Obx(() {
      if (controller.isInputEmpty && controller.toSendImages.isEmpty) {
        return Row(
          children: [
            _buildShowMoreButton(),
            _buildRecordButton(),
            _buildGallery()
          ],
        );
      }

      return AppIcon(
        icon: AppIcons.send,
        color: AppColors.button5,
        padding: AppSpacing.edgeInsetsAll12.copyWith(left: 8),
        onTap: controller.sendMessage,
      );
    });
  }

  // Widget _buildAttachButtons() {
  //   return Obx(
  //     () => controller.isInputEmpty
  //         ? AppSpacing.emptyBox
  //         : Row(
  //             children: [
  //               _buildCameraButton(),
  //               _buildGalleryButton(),
  //               _buildSendDocumentButton(),
  //               _buildRecordButton(),
  //             ],
  //           ),
  //   );
  // }

  Widget _buildStickerButton() {
    return AppIcon(
      icon: AppIcons.sticker,
      color: AppColors.text1,
      // padding: AppSpacing.edgeInsetsAll8,
    );
  }

  Widget _buildRecordButton() {
    return GetBuilder<RecordController>(
      init: RecordController(), // INIT IT ONLY THE FIRST TIME
      builder: (controller) {
        return AppIcon(
          icon: Assets.icons.voice,
          padding: AppSpacing.edgeInsetsAll8,
          color: AppColors.text1,
        ).clickable(() {
          controller.startRecording();
        });
      },
    );
  }

  Widget _buildGallery() => AppIcon(
        icon: AppIcons.gallery,
        padding: AppSpacing.edgeInsetsAll8.copyWith(left: 6),
        color: AppColors.text1,
      ).clickable(() {
        _onAttachmentButtonPressed();
      });

  Widget _buildRecordingAudio() {
    return GetBuilder<RecordController>(
      init: RecordController(),
      builder: (controller) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppSpacing.gapW8,
            _buildDeleteAudioButton(controller),
            Container(
              padding: EdgeInsets.all(6.w),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 193, 231, 250),
                borderRadius: BorderRadius.circular(40),
              ),
              child: Obx(
                () => controller.isRecordingCompleted.value
                    ? Row(
                        children: [
                          _buildPlayAudio(controller),
                          AudioFileWaveforms(
                            size: Size(0.55.sw, 30),
                            playerController: controller.playController,
                            padding: EdgeInsets.only(left: 6.w, right: 6.w),
                            decoration: const BoxDecoration(),
                            playerWaveStyle: const PlayerWaveStyle(
                              fixedWaveColor: AppColors.deepSkyBlue,
                              liveWaveColor: AppColors.deepSkyBlue,
                              seekLineColor: AppColors.deepSkyBlue,
                            ),
                          ),
                          // controller.isPlaying.value
                          //     ?
                          StreamBuilder<Duration>(
                            stream: controller.onPlayingCurrentDurationChanged,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Text(
                                  '${snapshot.data!.inMinutes.toString().padLeft(2, '0')}:${(snapshot.data!.inSeconds % 60).toString().padLeft(2, '0')}',
                                  style: AppTextStyles.s12w400
                                      .copyWith(color: AppColors.text1),
                                );
                              }

                              return const SizedBox.shrink();
                            },
                          ),
                          // : Text(
                          //     controller.maxDuration.value,
                          //     style: AppTextStyles.s12w400,
                          //   ),
                        ],
                      )
                    : Row(
                        children: [
                          _buildPauseRecording(controller),
                          AudioWaveforms(
                            enableGesture: true,
                            size: Size(0.55.sw, 30),
                            recorderController: controller.recorderController,
                            waveStyle: const WaveStyle(
                              waveColor: AppColors.deepSkyBlue,
                              extendWaveform: true,
                              showMiddleLine: false,
                              spacing: 5,
                            ),
                            padding: EdgeInsets.only(
                              left: 8.w,
                              right: 8.w,
                            ),
                          ),
                          StreamBuilder<Duration>(
                            stream:
                                controller.recorderController.onCurrentDuration,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Text(
                                  controller.formatDuration(snapshot.data!),
                                  style: AppTextStyles.s12w400
                                      .copyWith(color: AppColors.text1),
                                );
                              }

                              return const SizedBox.shrink();
                            },
                          ),
                        ],
                      ),
              ),
            ),
            _buildSendAudioButton(controller),
          ],
        );
      },
    );
  }

  Widget _buildSendAudioButton(RecordController controller) {
    return AppIcon(
      icon: AppIcons.send,
      color: AppColors.button5,
      padding: AppSpacing.edgeInsetsAll12,
      onTap: () {
        controller.onSendAudio();
      },
    );
  }

  Widget _buildDeleteAudioButton(RecordController controller) {
    return AppIcon(
      icon: AppIcons.deleteAudio,
      color: AppColors.zambezi,
      onTap: () {
        controller.deleteRecord();
      },
    );
  }

  Widget _buildPauseRecording(RecordController controller) {
    return Container(
      width: Sizes.s28,
      height: Sizes.s28,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.pacificBlue,
        // gradient: LinearGradient(
        //   colors: AppColors.button2,
        // ),
      ),
      child: GetBuilder<RecordController>(
        init: RecordController(),
        builder: (controller) {
          return AppIcon(
            color: AppColors.white,
            icon: AppIcons.pauseAudio,
            padding: const EdgeInsets.all(4),
            onTap: () {
              controller.stopRecording();
            },
          );
        },
      ),
    );
  }

  Widget _buildPlayAudio(RecordController controller) {
    return Container(
      width: Sizes.s28,
      height: Sizes.s28,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.pacificBlue,
        // gradient: LinearGradient(
        //   colors: AppColors.button2,
        // ),
      ),
      child: GetBuilder<RecordController>(
        init: RecordController(),
        builder: (controller) {
          return AppIcon(
            icon: AppIcons.playAudio,
            color: AppColors.text2,
            padding: const EdgeInsets.all(4),
            onTap: () {
              controller.playAudio();
            },
          );
        },
      ),
    );
  }

  Widget _buildSearchMentionedUsers() {
    return Obx(
      () {
        if (controller.mentionedUsersInSearch.isEmpty) {
          return AppSpacing.emptyBox;
        }

        return ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: 320.h,
          ),
          child: AppBlurryContainer(
            child: Padding(
              padding: EdgeInsets.only(bottom: 72.h),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: controller.mentionedUsersInSearch.length,
                itemBuilder: (context, index) {
                  final user = controller.mentionedUsersInSearch[index];

                  return ListTile(
                    leading: AppCircleAvatar(
                      url: user.avatarPath ?? '',
                      size: Sizes.s40,
                    ),
                    title: Text(user.fullName),
                    onTap: () => controller.onMentionedUserSelected(user),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildShowMoreButton() {
    return AppIcon(
      icon: Assets.icons.postOption,
      size: 6,
      color: AppColors.text1,
      padding: AppSpacing.edgeInsetsAll12.copyWith(right: 6, left: 0),
      onTap: () {
        ViewUtil.showBottomSheet(
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: GridView(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: Sizes.s16,
              ),
              children: [
                _buildCameraButton(),
                _buildGalleryButton(),
                _buildSendDocumentButton(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCameraButton() {
    return _buildOptionItem(
      context: Get.context!,
      icon: AppIcon(
        icon: AppIcons.camera,
        isCircle: true,
        backgroundColor: AppColors.button5,
        color: Colors.white,
        padding: AppSpacing.edgeInsetsAll8,
      ),
      title: Get.context!.l10n.chat_hub__camera_label,
      onTap: _onCameraButtonPressed,
    );
  }

  Widget _buildGalleryButton() {
    return _buildOptionItem(
      context: Get.context!,
      icon: AppIcon(
        icon: AppIcons.gallery,
        isCircle: true,
        backgroundColor: AppColors.button5,
        color: Colors.white,
        padding: AppSpacing.edgeInsetsAll8,
      ),
      title: Get.context!.l10n.chat_hub__gallery_label,
      onTap: _onAttachmentButtonPressed,
    );
  }

  Widget _buildSendDocumentButton() {
    return _buildOptionItem(
      context: Get.context!,
      icon: AppIcon(
        icon: AppIcons.document,
        isCircle: true,
        backgroundColor: AppColors.button5,
        padding: AppSpacing.edgeInsetsAll8,
        color: Colors.white,
      ),
      title: Get.context!.l10n.chat_hub__document_label,
      onTap: _onDocumentButtonPressed,
    );
  }

  Widget _buildOptionItem({
    required BuildContext context,
    required Widget icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        icon,
        AppSpacing.gapH4,
        Text(
          title,
          style: AppTextStyles.s12w600.copyWith(
            color: AppColors.text1,
          ),
        ),
      ],
    ).clickable(() {
      Get.back();
      onTap();
    });
  }
}
