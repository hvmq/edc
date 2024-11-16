import 'dart:async';
import 'dart:collection';

import 'package:get/get.dart';

import '../../../../../core/all.dart';
import '../../../../../models/all.dart';

import '../../../../base/all.dart';
import '../../../all.dart';
import '../views/widgets/pin_messages_widget.dart';

class PinMessageController extends BaseController {
  final Conversation conversation;

  final RxList<Message> _pinnedMessages = <Message>[].obs;
  final LinkedHashMap<String, Message> _pinnedMessagesMap = LinkedHashMap();

  PinMessageController(this.conversation);

  @override
  void onInit() {
    getPinMessages(conversation.id);
    super.onInit();
  }

  Future getPinMessages(String conversationId) async {}

  Future pinMessage(Message message) async {
    if (isMessagePinned(message.id)) {
      ViewUtil.showAppSnackBar(
        Get.context!,
        Get.context!.l10n.conversation__pinned_message,
      );

      return;
    }
    _addMessage(message);
    await _updateMessage(message);
  }

  Future unPinMessage(Message message) async {
    if (!isMessagePinned(message.id)) {
      return;
    }
    _removeMessage(message);
    await _updateMessage(message);
  }

  Future _updateMessage(Message message) async {}

  Future _unPinAllMessage() async {
    if (pinnedMessages.isEmpty) {
      return;
    }
  }

  void _addMessage(Message message) {
    _pinnedMessagesMap[message.id] = message;
  }

  void _removeMessage(Message message) {
    _pinnedMessagesMap.remove(message.id);
  }

  bool isMessagePinned(String messageId) =>
      _pinnedMessagesMap.containsKey(messageId);

  List<Message> get pinnedMessages => _pinnedMessages;

  RxList<Message> get rxPinnedMessages => _pinnedMessages;

  set pinnedMessages(List<Message> value) => _pinnedMessages.assignAll(value);

  void showListPinnedMessages() {
    ViewUtil.showBottomSheet(
      child: const PinMessagesWidget(),
      heightFactor: 0.9,
      enableDrag: false,
    );
  }

  void onMessageClick(Message message) {
    if (Get.isRegistered<ChatHubController>()) {
      Get.find<ChatHubController>().jumpToMessage(message);
    }
  }

  Future unPinAllMessage() async {
    _pinnedMessagesMap.clear();
    await _unPinAllMessage();
    _pinnedMessages.clear();
  }
}
