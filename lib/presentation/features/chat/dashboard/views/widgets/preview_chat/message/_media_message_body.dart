import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:voice_message_package/voice_message_package.dart';

import '../../../../../../../../models/message.dart';
import '../../../../../../../common_widgets/all.dart';
import '../../../../../../../resource/resource.dart';

const _kDefaultMediaWidthPercentage = 0.6;

class PreviewMediaMessageBody extends StatefulWidget {
  final Message message;
  final bool isMine;
  final bool isReaction;

  const PreviewMediaMessageBody({
    required this.message,
    required this.isMine,
    this.isReaction = false,
    super.key,
  });

  @override
  State<PreviewMediaMessageBody> createState() =>
      _PreviewMediaMessageBodyState();
}

class _PreviewMediaMessageBodyState extends State<PreviewMediaMessageBody>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => widget.message.type != MessageType.text;

  late Message _message;

  @override
  void initState() {
    _message = widget.message;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    Widget child;

    switch (_message.type) {
      case MessageType.image:
        child = _buildImageMessage();
      case MessageType.video:
        child = _buildVideoMessage();
      case MessageType.audio:
        child = widget.isReaction
            ? Material(
                color: Colors.transparent,
                child: _buildAudioMessage(),
              )
            : _buildAudioMessage();
      default:
        child = AppSpacing.emptyBox;
    }

    return child;
  }

  Widget _buildImageMessage() {
    List<String> images = [];

    images = _message.isLocal
        ? _message.content
            .split('/data/user/0/social.educhain.pitech')
            .where((element) => element.isNotEmpty)
            .map((element) =>
                '/data/user/0/social.educhain.pitech${element.trim()}')
            .toList()
        : _message.content
            .split('https://media.educhain.tech')
            .where((element) => element.isNotEmpty)
            .map((element) => 'https://media.educhain.tech${element.trim()}')
            .toList();

    Widget decorateImage(ImageProvider imageProvider) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: widget.isReaction
            ? Image(
                height: 0.6.sw,
                image: ResizeImage(
                  imageProvider,
                  height: 0.6.sw.toInt().cacheSize(context),
                ),
                fit: BoxFit.cover,
              )
            : Image(
                // width: _kDefaultMediaWidthPercentage.sw,
                fit: BoxFit.cover,
                image: ResizeImage(
                  imageProvider,
                  width: _kDefaultMediaWidthPercentage.sw
                      .toInt()
                      .cacheSize(context),
                ),
              ),
      );
    }

    if (_message.isLocal) {
      return images.length == 1
          ? Opacity(
              opacity: 0.5,
              child: decorateImage(
                FileImage(File(_message.content)),
              ),
            )
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 3,
                mainAxisSpacing: 8,
              ),
              shrinkWrap: true,
              itemCount: images.length == 2 ? 3 : images.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => images.length == 2
                  ? index == 0
                      ? const SizedBox()
                      : Opacity(
                          opacity: 0.5,
                          child: decorateImage(
                            FileImage(File(images[index - 1])),
                          ),
                        )
                  : Opacity(
                      opacity: 0.5,
                      child: decorateImage(
                        FileImage(File(images[index])),
                      ),
                    ),
            );
    }

    return images.length == 1
        ? AppNetworkImage(
            _message.content,
            width: _kDefaultMediaWidthPercentage.sw,
            imageBuilder: (context, imageProvider) =>
                decorateImage(imageProvider),
            placeholder: _buildImagePlaceholder(),
            clickToSeeFullImage: true,
          )
        : GridView.builder(
            padding: EdgeInsets.zero,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 3,
              mainAxisSpacing: 8,
            ),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.isMine
                ? (images.length == 2 ? 3 : images.length)
                : images.length,
            itemBuilder: (context, index) {
              if (widget.isMine && images.length == 2 && index == 0) {
                return const SizedBox();
              }

              final imageIndex =
                  widget.isMine && images.length == 2 ? index - 1 : index;

              return AppNetworkImage(
                images[imageIndex],
                fit: BoxFit.cover,
                imageBuilder: (context, imageProvider) =>
                    decorateImage(imageProvider),
                placeholder: _buildImagePlaceholder(),
                clickToSeeFullImage: true,
              );
            },
          );
  }

  Widget _buildVideoMessage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.r),
      child: AppVideoPlayer(
        _message.content,
        key: ValueKey(_message.content),
        width: _kDefaultMediaWidthPercentage.sw,
        fit: BoxFit.contain,
        isFile: _message.isLocal,
        isThumbnailMode: true,
        isClickToShowFullScreen: true,
      ),
    );
  }

  Widget _buildAudioMessage() {
    return VoiceMessageView(
      backgroundColor: AppColors.popup.withOpacity(0.22),
      activeSliderColor: AppColors.button5,
      circlesColor: AppColors.button5,
      controller: VoiceController(
        width: 0.34.sw,
        audioSrc: _message.content,
        isFile: _message.isLocal,
        maxDuration: const Duration(seconds: 10),
        onComplete: () {},
        onPause: () {},
        onPlaying: () {},
        onError: (err) {},
      ),
    );
  }

  Widget _buildImagePlaceholder() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.label1Color.withOpacity(0.58),
        borderRadius: BorderRadius.circular(12.r),
      ),
      width: _kDefaultMediaWidthPercentage.sw,
      height: _kDefaultMediaWidthPercentage.sw,
      child: const AppDefaultLoading(),
    );
  }
}
