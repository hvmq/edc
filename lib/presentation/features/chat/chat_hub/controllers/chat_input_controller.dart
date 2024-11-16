import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/all.dart';
import '../../../../../models/message.dart';
import '../../../../../models/user.dart';
import '../../../../common_controller.dart/app_controller.dart';
import '../controllers/chat_hub_controller.dart';
import 'auto_completion_controller.dart';

class ChatInputController extends GetxController
    with TextWithCompletionController, LogMixin {
  final chatHubController = Get.find<ChatHubController>();

  final FocusNode focusNode = FocusNode();

  final _isInputEmpty = true.obs;
  bool get isInputEmpty => _isInputEmpty.value && toSendMedia == null;

  final Rx<PickedMedia?> _toSendMedia = Rx(null);
  PickedMedia? get toSendMedia => _toSendMedia.value;

  final RxList<PickedMedia> _toSendImages = <PickedMedia>[].obs;
  List<PickedMedia> get toSendImages => _toSendImages.toList();

  final RxList<User> _mentionedUsersInSearch = <User>[].obs;
  List<User> get mentionedUsersInSearch => _mentionedUsersInSearch;

  RxBool isLoadingMedia = false.obs;
  RxInt loadMediaPersent = 0.obs;

  String pathLocal = '';

  void setIsLoadingMedia(bool value) {
    if (value) {
      loadMediaPersent.value = 0;
    }
    isLoadingMedia.value = value;
    update();
  }

  late Timer _timer;

  int getRandomIntInRange(int min, int max) {
    final random = Random();
    return min + random.nextInt(max - min);
  }

  void startTimer() {
    const oneSec = Duration(milliseconds: 1000);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        final value = getRandomIntInRange(20, 25);
        if (loadMediaPersent.value + value < 100) {
          loadMediaPersent.value += value;
          update();
        } else {
          loadMediaPersent.value = 99;
        }
      },
    );
  }

  @override
  void onInit() {
    super.onInit();
    textEditingController.addListener(() {
      _isInputEmpty.value = textEditingController.text.isEmpty;
    });

    if (chatHubController.isConversationInitiated) {
      enableAutoCompletion = chatHubController.conversation.isGroup;
    }

    _initStipop();
    startTimer();
  }

  @override
  void onClose() {
    focusNode.dispose();
    textEditingController.dispose();

    super.onClose();
  }

  void _initStipop() {}

  void sendMessage() {
    if (textEditingController.text.isNotEmpty) {
      chatHubController.sendTextMessage(textEditingController.text);
      textEditingController.clear();
    }

    if (toSendMedia != null) {
      _sendMediaMessage(toSendMedia!);
    }

    if (toSendImages.isNotEmpty) {
      final medias = _toSendImages.value;
      final List<File> images = [];
      final List<PickedMedia> orther = [];

      for (var media in medias) {
        final type = media.type;
        if (type == MediaAttachmentType.image) {
          images.add(media.file);
        } else {
          orther.add(media);
        }
      }
      if (images.isNotEmpty) {
        chatHubController.sendImagesMessage(files: images);
      }
      if (orther.isNotEmpty) {
        for (var item in orther) {
          _sendMediaMessage(item);
        }
      }

      _toSendImages.value = [];
    }
  }

  void _sendMediaMessage(PickedMedia media) {
    final messageType = switch (media.type) {
      MediaAttachmentType.image => MessageType.image,
      MediaAttachmentType.video => MessageType.video,
      MediaAttachmentType.audio => MessageType.audio,
      MediaAttachmentType.document => MessageType.file,
    };

    chatHubController.sendMediaMessage(
      file: media.file,
      type: messageType,
    );
    _toSendMedia.value = null;
  }

  void attachMedia(PickedMedia media) {
    isLoadingMedia.value = false;
    _toSendMedia.value = media;
    focusNode.requestFocus();
    // _sendMediaMessage(media);
  }

  void attachImages(List<PickedMedia> medias) {
    isLoadingMedia.value = false;
    _toSendImages.value = medias;
    update();
    focusNode.requestFocus();
    // final List<File> images = [];
    // final List<PickedMedia> orther = [];

    // for (var media in medias) {
    //   final type = media.type;
    //   if (type == MediaAttachmentType.image) {
    //     images.add(media.file);
    //   } else {
    //     orther.add(media);
    //   }
    // }
    // if (images.isNotEmpty) {
    //   chatHubController.sendImagesMessage(files: images);
    // }
    // if (orther.isNotEmpty) {
    //   for (var item in orther) {
    //     _sendMediaMessage(item);
    //   }
    // }
  }

  void removeToSendMedia() {
    _toSendMedia.value = null;
  }

  void removeItemInMedias(PickedMedia item) {
    final tempList = [..._toSendImages.toList()];
    _toSendImages.value = tempList.where((e) {
      return e != item;
    }).toList();
  }

  @override
  void search(String query) {
    final members = chatHubController.conversation.members;

    List<User> searchResults = [];

    searchResults = query.isEmpty
        ? members
        : List<User>.from(members).where((member) {
            final words = member.fullName.split(' ');

            return words.any((word) => word.containsIgnoreCase(query));
          }).toList();

    _mentionedUsersInSearch.assignAll(searchResults);
  }

  @override
  void turnOffAutoCompleting() {
    _mentionedUsersInSearch.clear();
  }

  void onMentionedUserSelected(User user) {
    autocompleteTextWithUsername(
      textEditingController,
      user.fullName,
    );

    _mentionedUsersInSearch.clear();
  }
}

class ToSendMediaModel extends Equatable {
  final File file;
  final MediaAttachmentType type;

  const ToSendMediaModel({
    required this.file,
    required this.type,
  });

  @override
  List<Object?> get props => [file, type];
}
