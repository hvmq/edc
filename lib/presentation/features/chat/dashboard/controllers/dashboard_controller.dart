import 'dart:async';
import 'dart:convert';

import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/all.dart';
import '../../../../../models/all.dart';
import '../../../../../models/unread_message.dart';
import '../../../../base/all.dart';
import '../../../../routing/routers/app_pages.dart';
import '../../chat_hub/controllers/chat_hub_controller.dart';

const _boxName = 'chat_conversations';
const _conversationKey = 'conversations';

class ChatDashboardController extends BaseController
    with WidgetsBindingObserver {
  @override
  String get boxName => _boxName;

  final _eventBus = Get.find<EventBus>();

  final RxList<Conversation> _conversations = <Conversation>[].obs;

  List<Conversation> get allConversations => _conversations.toList();

  final RxList<Conversation> _filteredConversations = <Conversation>[].obs;
  final RxList<int> selects = <int>[].obs;
  final RxBool _hasUnreadMessage = false.obs;
  final RxBool isSelect = false.obs;

  List<Conversation> get conversations => _filteredConversations.toList();

  late StreamSubscription _newMessageSubscription;
  late StreamSubscription _conversationDeletedSubscription;
  late StreamSubscription _unreadMessageSubscription;
  late StreamSubscription _messageDeletedSubscription;
  late StreamSubscription _messageSeenSubscription;

  final showGroupConversations = false.obs;
  final isSearching = false.obs;
  Worker? worker;

  @override
  Future<void> onInit() async {
    super.onInit();
    await ensureInitStorage();

    WidgetsBinding.instance.addObserver(this);

    _getConversations();
    _listenChatSocket();

    _conversations.listen((conversations) {
      _filteredConversations.value = conversations;
      // _filteredConversations.value = conversations.where((conversation) {
      //   // check if the conversation has unread messages
      //   hasUnreadMessage = (conversation.unreadCount ?? -1) > 0;

      //   return conversation.isGroup == showGroupConversations.value;
      // }).toList();
    });

    /// Sets up a worker that listens for changes in the [_hasUnreadMessage] observable.
    ///
    /// This worker is triggered every time the value of [_hasUnreadMessage] changes.
    /// If the new value is false, it fires a [HiddenUnreadMessageEvent] on the [_eventBus].
    /// This event is used to show a hidden message badge in the message navigation item.
    ///
    /// The worker does not return any value, so it returns null.
    worker = ever(_hasUnreadMessage, (value) {
      return null;
    });

    unawaited(_setUpPersistedData());
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    _newMessageSubscription.cancel();
    _conversationDeletedSubscription.cancel();
    _unreadMessageSubscription.cancel();
    _messageDeletedSubscription.cancel();
    _messageSeenSubscription.cancel();
    worker?.dispose();
    super.onClose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.resumed) {
      _getConversations();
    }
  }

  @override
  Future<void> refresh() async {
    isSearching.value = false;
    _getConversations();
    await Future.delayed(DurationConstants.defaultIndicatorRefreshDuration);
  }

  Future<void> _setUpPersistedData() async {
    await hydrate<List<Conversation>, String>(
      _conversations,
      key: _conversationKey,
      encoder: (value) => jsonEncode(value?.map((e) => e.toJson()).toList()),
      decoder: (value) => jsonDecode(value ?? '[]')
          .map<Conversation>((e) => Conversation.fromJson(e))
          .toList(),
    ).then((cachedConversations) {
      if (cachedConversations != null) {
        _conversations.value = cachedConversations;
      }
    });
  }

  void _listenChatSocket() {}

  void setIsSelect(bool isselect) {
    isSelect.value = !isselect;
  }

  void _getConversations() {}

  Future<void> _updateConversationMembers(Conversation conversation) async {
    // Only update get conversation members if the conversation is private chat
    if (conversation.isGroup) {
      return;
    }

    final index = _conversations.indexOf(conversation);

    for (final memberId in conversation.memberIds) {
      try {
        await _updateConversationMember(
          memberId: memberId,
          conversationIndex: index,
        );
      } catch (e) {
        continue;
      }
    }

    await _updateConversationMember(
      memberId: conversation.creatorId,
      conversationIndex: index,
    );
  }

  Future<void> _updateConversationMember({
    required int memberId,
    required int conversationIndex,
  }) async {}

  Future<void> createConversationAndGotoChatHub(List<User> users) async {}

  Future<void> _onNewMessage(Message newMessage) async {
    final conversation = _conversations.firstWhereOrNull(
      (conversation) => conversation.id == newMessage.conversationId,
    );

    // TODO: Check chat members

    // if not null => re-oder conversation to top of list
    if (conversation != null) {
      _conversations.remove(conversation);
      _conversations.insert(
        0,
        conversation.copyWith(
          messages: [
            newMessage,
            ...conversation.messages,
          ],
          unreadCount: (conversation.unreadCount ?? 0) + 1,
        ),
      );
      update();
      return;
    }
  }

  Future<void> _onSeenMessage(Map<String, dynamic> data) async {
    final String roomId = data['roomId'];
    final String userId = data['userId'];
    final int lastSeen = data['lastSeen'];

    final conversation = _conversations.firstWhereOrNull(
      (conversation) => conversation.id == roomId,
    );

    if (conversation != null) {
      final index = _conversations.indexOf(conversation);

      final updatedLastSeenUsers =
          Map<String, int>.from(conversation.lastSeenUsers ?? {});
      updatedLastSeenUsers[userId] = lastSeen;

      final newConversation = conversation.copyWith(
        lastSeenUsers: updatedLastSeenUsers,
      );
      _conversations[index] = newConversation;
      update();

      return;
    }
  }

  void _onConversationDeleted(String conversationId) {
    _conversations
        .removeWhere((conversation) => conversation.id == conversationId);
  }

  void deleteConversation(Conversation conversation) {}

  void blockConversation(Conversation conversation) {}

  void unblockConversation(Conversation conversation) {
    if (conversation.isGroup ||
        !conversation.isBlocked ||
        !conversation.blockedByMe) {
      return;
    }
  }

  void filterConversations(String query) {
    if (query.isEmpty) {
      _filteredConversations.value = _conversations;

      return;
    }

    _filteredConversations.value = _conversations
        .where((conversation) =>
            conversation.title().toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  void updateShowGroupConversations(bool isShowGroup) {
    showGroupConversations.value = isShowGroup;
    _filteredConversations.value = _conversations
        .where((conversation) => conversation.isGroup == isShowGroup)
        .toList();
  }

  void clearSearch() {
    isSearching.value = false;

    _filteredConversations.value = _conversations.where((conversation) {
      return conversation.isGroup == showGroupConversations.value;
    }).toList();
  }

  Future<void> goToPrivateChat(
    User user, {
    Completer<void>? completer,
  }) async {
    final Conversation? conversation = _conversations.firstWhereOrNull(
      (conversation) =>
          !conversation.isGroup && conversation.memberIds.contains(user.id),
    );

    completer?.complete();

    if (Get.currentRoute == Routes.chatHub) {
      Get.back();
    }

    await Future.delayed(const Duration(milliseconds: 500));

    unawaited(
      Get.toNamed(
        Routes.chatHub,
        arguments: ChatHubArguments(conversation: conversation),
      ),
    );
  }

  /// Handles the event of receiving an unread message.
  ///
  /// This method is triggered when a new unread message event is received.
  /// It updates the unread count of the corresponding conversation in the
  /// [_conversations] list and refreshes the list to reflect the changes in the UI.
  ///
  /// The [event] parameter is an instance of [UnreadMessage] which contains
  /// the ID of the conversation room and the count of unread messages.
  void _onUnreadMessage(UnreadMessage event) {
    // Find the index of the conversation in the _conversations list
    // that matches the roomId in the event
    final conversationIndex = _conversations.indexWhere(
      (conversation) => conversation.id == event.roomId,
    );

    // If no matching conversation is found, exit the function
    if (conversationIndex == -1) return;

    // Update the unreadCount of the found conversation with the unreadCount from the event
    _conversations[conversationIndex] =
        _conversations[conversationIndex].copyWith(
      unreadCount: event.unreadCount,
    );

    // Refresh the _conversations list to reflect the changes in the UI
    _conversations.refresh();
  }

  bool get hasUnreadMessage => _hasUnreadMessage.value;

  set hasUnreadMessage(bool value) {
    _hasUnreadMessage.value = value;
  }

  void updateLastSeenMessage(String conversationId) {}
}
