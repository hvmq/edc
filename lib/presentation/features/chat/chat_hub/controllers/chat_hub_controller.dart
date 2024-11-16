import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jitsi_meet_flutter_sdk/jitsi_meet_flutter_sdk.dart';

import '../../../../../core/all.dart';
import '../../../../../models/all.dart';
import '../../../../base/all.dart';
import '../../../../resource/styles/app_colors.dart';
import '../../../../routing/routers/app_pages.dart';
import '../../../report/report_controller.dart';
import '../../dashboard/controllers/dashboard_controller.dart';
import 'pin_message_controller.dart';

const _boxName = 'chat_hub';

class ChatHubArguments {
  final Conversation? conversation;
  final String? conversationId;
  final Function()? leadingIconOnTap;

  const ChatHubArguments({
    this.conversation,
    this.conversationId,
    this.leadingIconOnTap,
  }) : assert(conversation != null || conversationId != null);
}

enum StateMessage {
  loading,
  sending,
  sent,
  none,
}

class ChatHubController extends BaseLoadMoreController<Message>
    with WidgetsBindingObserver {
  @override
  String get boxName => _boxName;

  final _conversation = Rxn<Conversation?>();
  final Rxn<Message> _replyFromMessage = Rxn<Message>();

  Message? get replyFromMessage => _replyFromMessage.value;

  set replyFromMessage(Message? value) => _replyFromMessage.value = value;

  Conversation get conversation => _conversation.value!;

  bool get isConversationInitiated => _conversation.value != null;

  late StreamSubscription _newMessageSubscription;
  late StreamSubscription _conversationDeletedSubscription;
  late StreamSubscription _messageDeletedSubscription;
  late StreamSubscription _leaveConversationSubscription;
  late StreamSubscription _reactionToMessageSubscription;
  late StreamSubscription _unReactionToMessageSubscription;
  late StreamSubscription _messageSeenSubscription;

  final _isOnline = false.obs;

  bool get isOnline => _isOnline.value;

  // for pip view
  Function()? leadingIconOnTap;

  @override
  bool get getListWhenInit => false;

  bool get isCreatorOrAdmin => conversation.isCreatorOrAdmin(currentUser.id);

  Rx<StateMessage> stateMessage = StateMessage.none.obs;

  void reloadWithNewConversationId(String conversationId) {
    _initConversation(ChatHubArguments(conversationId: conversationId));
  }

  void reloadWithNewConversation(Conversation conversation) {
    _initConversation(ChatHubArguments(conversation: conversation));
  }

  var translateLanguageMessageIndex = 1.obs;
  var isTranslateMessage = false.obs;
  var translateMessageMap = <String, String>{}.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await ensureInitStorage();

    ChatHubArguments arguments;
    try {
      arguments = Get.arguments as ChatHubArguments;
    } catch (e) {
      Get.back();

      return;
    }
    leadingIconOnTap = arguments.leadingIconOnTap;
    WidgetsBinding.instance.addObserver(this);
    _setupSocketListener();

    unawaited(_initConversation(arguments));
  }

  void updateTranslateLanguageMessage(int index) {
    translateLanguageMessageIndex.value = index;
    update();
  }

  Future<void> handleTranslateMessage(bool isTranslateValue) async {
    runAction(action: () async {
      if (isTranslateValue) {
        isTranslateMessage.value = true;
      } else {
        isTranslateMessage.value = false;
      }
      update();
    });
  }

  @override
  void onClose() {
    // Store the first page of messages to cache
    _storeMessages(
      conversationId: conversation.id,
      messages: (pagingController.itemList ?? []).sublist(
        0,
        min(pagingController.itemList!.length, pageSize),
      ),
    );

    updateLastSeenMessage();
    WidgetsBinding.instance.removeObserver(this);
    _newMessageSubscription.cancel();
    _conversationDeletedSubscription.cancel();
    _messageDeletedSubscription.cancel();
    _leaveConversationSubscription.cancel();
    _reactionToMessageSubscription.cancel();
    _unReactionToMessageSubscription.cancel();
    _messageSeenSubscription.cancel();
    super.onClose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.resumed) {
      // refreshData();
    }
  }

  void _storeMessages({
    required String conversationId,
    required List<Message> messages,
  }) {
    write(
      conversationId,
      jsonEncode(messages.map((message) => message.toJson()).toList()),
    );
    try {
      findIndexLastSeen(
        lastSeenUsers: lastSeenUser,
        messages: messages,
      );
    } catch (e) {
      LogUtil.e(e);
    }
  }

  void _loadCachedMessages(
      {required String conversationId, required Conversation conversation}) {
    final cachedMessages = readSync(conversationId);

    if (cachedMessages == null) {
      return;
    }

    final messages = (jsonDecode(cachedMessages) as List)
        .map((message) => Message.fromJson(message as Map<String, dynamic>))
        .toList();

    final firstPage = PaginatedList(
      items: messages,
      currentPage: initialPage,
      pageSize: pageSize,
    );

    pagingController.appendPaginatedList(firstPage);

    try {
      if (firstPage.items.isNotEmpty) {
        findIndexLastSeen(
          lastSeenUsers: lastSeenUser,
          messages: firstPage.items,
        );
      }
    } catch (e) {
      LogUtil.e(e);
    }
  }

  void _setupSocketListener() {}

  void _listenToActiveUsers() {
    if (conversation.isGroup) {
      return;
    }

    final partnerId = conversation.members
        .whereNot((member) => member.id == currentUser.id)
        .firstOrNull
        ?.id;

    if (partnerId == null) {
      return;
    }
  }

  void conversationUpdated(Conversation newConversation) {
    _conversation.value = newConversation;
  }

  Future<void> _initConversation(ChatHubArguments arguments) async {}

  Future<void> loadConversationMembers() async {}

  Future<void> sendTextMessage(
    String content,
  ) async {
    if (content.trim().isEmpty) {
      return;
    }

    // detect if the message contains link and send it as hyperlink with <hyper> tag

    MessageType type = MessageType.text;

    if (content.contains(RegExp(r'http[s]?://'))) {
      type = MessageType.hyperText;

      final hyperLinks = content.split(RegExp(r'(?=http[s]?://)'));
      final hyperTexts = hyperLinks.map((link) {
        if (link.contains(RegExp(r'\n'))) {
          final linkParts = link.split(RegExp(r'\n'));

          return linkParts.map((part) {
            if (part.contains(RegExp(r'http[s]?://'))) {
              return '<${AppConstants.hyperTextTag}>$part</${AppConstants.hyperTextTag}>';
            }

            return part;
          }).join('\n');
        }
        if (link.contains(RegExp(r'\s'))) {
          final linkParts = link.split(RegExp(r'\s'));

          return linkParts.map((part) {
            if (part.contains(RegExp(r'http[s]?://'))) {
              return '<${AppConstants.hyperTextTag}>$part</${AppConstants.hyperTextTag}>';
            }

            return part;
          }).join(' ');
        }

        return '<${AppConstants.hyperTextTag}>$link</${AppConstants.hyperTextTag}>';
      }).join();

      content = hyperTexts;
    }

    final mentionedUsers = _extractMentionedUsers(content);
    final mentionsData = <String, String>{};

    if (mentionedUsers.isNotEmpty) {
      // eg: @'user full name' => @${id}
      for (final user in mentionedUsers) {
        final mentionText =
            userIdMentionWrapper.replaceAll('userId', user.id.toString());
        mentionsData[mentionText] = user.fullName;
        content = content.replaceAll('@${user.fullName}', mentionText);
      }
    }

    final toSendMessage = Message(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      conversationId: conversation.id,
      content: content.trim(),
      type: type,
      createdAt: DateTime.now(),
      senderId: currentUser.id,
      sender: currentUser,
      repliedFrom: replyFromMessage,
      mentions: mentionsData,
    );

    _insertMessage(toSendMessage);
    setStateMessage(StateMessage.sending);
    _scrollToBottom();

    return runAction(
      handleLoading: false,
      action: () async {
        final replyMessageId = replyFromMessage?.id;
        clearReplyMessage();

        setStateMessage(StateMessage.sent);
      },
    );
  }

  Future<Message?> sendCallGroupMessage(Call call) async {
    final toSendMessage = Message(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      conversationId: conversation.id,
      content: jsonEncode(call.toJson()),
      description: 'jitsi',
      type: MessageType.call,
      createdAt: DateTime.now(),
      senderId: currentUser.id,
      sender: currentUser,
      repliedFrom: replyFromMessage,
    );

    _insertMessage(toSendMessage);
    _scrollToBottom();
    Message? message;
    await runAction(
      handleLoading: false,
      action: () async {},
      onSuccess: () async {
        clearReplyMessage();
      },
    );

    return message;
  }

  List<User> _extractMentionedUsers(String message) {
    // Currently, the format of mention is @full name (can include space)

    if (!message.contains('@')) {
      return [];
    }

    final mentionUsers = <User>[];

    final mentionPattern = RegExp(r'@([a-zA-Z0-9\s]+)');

    final matches = mentionPattern.allMatches(message);

    for (final match in matches) {
      final mentionedUserText = match.group(1);

      if (mentionedUserText == null) {
        continue;
      }

      final mentionUser = conversation.members.firstWhereOrNull(
        (member) => mentionedUserText.startsWith(member.fullName),
      );

      if (mentionUser != null) {
        mentionUsers.add(mentionUser);
      }
    }

    return mentionUsers;
  }

  void sendMediaMessage({
    required MessageType type,
    required File file,
  }) {
    assert(type != MessageType.text);

    final localMessage = Message(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      conversationId: conversation.id,
      content: file.path,
      type: type,
      createdAt: DateTime.now(),
      senderId: currentUser.id,
      sender: currentUser,
      isLocal: true,
      repliedFrom: replyFromMessage,
    );

    _insertMessage(localMessage);
    _scrollToBottom();
    setStateMessage(StateMessage.sending);
  }

  void sendImagesMessage({
    required List<File> files,
  }) {
    String path = '';
    setStateMessage(StateMessage.loading);
    for (var file in files) {
      path = file != files.last ? '$path${file.path} ' : path + file.path;
    }
    final localMessage = Message(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      conversationId: conversation.id,
      content: path,
      type: MessageType.image,
      createdAt: DateTime.now(),
      senderId: currentUser.id,
      sender: currentUser,
      isLocal: true,
      repliedFrom: replyFromMessage,
    );

    _insertMessage(localMessage);
    _scrollToBottom();
    setStateMessage(StateMessage.sending);
  }

  void clearReplyMessage() {
    replyFromMessage = null;
  }

  Message? addSenderToMessage(Message? message) {
    if (message == null) {
      return null;
    }
    final sender = conversation.members.firstWhereOrNull(
      (member) => member.id == message.senderId,
    );

    return message.copyWith(sender: sender);
  }

  void _insertMessage(Message message) {
    pagingController.insertItemAt(0, message);
    if (indexLastSeen.value != -1) {
      indexLastSeen.value++;
    }
  }

  void _scrollToBottom() {
    anchorScrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
    );
  }

  void _replaceMessage({
    required Message oldMessage,
    required Message newMessage,
  }) {
    pagingController.replaceItem(
      oldMessage,
      newMessage,
      comparator: (oldItem, message) => oldItem.id == message.id,
    );
  }

  Future<void> _onNewMessage(Message message) async {
    if (message.conversationId != conversation.id ||
        message.isMine(myId: currentUser.id)) {
      return;
    }

    final isExist =
        pagingController.itemList?.any((element) => element.id == message.id) ??
            false;

    if (isExist) {
      return;
    }

    updateLastSeenMessage();
  }

  Future<void> _onSeenMessage(Map<String, dynamic> data) async {
    final String userId = data['userId'];
    final int lastSeen = data['lastSeen'];

    final updatedLastSeenUsers =
        Map<String, int>.from(conversation.lastSeenUsers ?? {});
    updatedLastSeenUsers[userId] = lastSeen;

    updateConversationLastSeenUser(updatedLastSeenUsers);
  }

  Future onCallTranslateTap() async {
    if (!isConversationInitiated) {
      return;
    }

    if (conversation.isBlocked || conversation.isLocked) {
      return;
    }
  }

  Future onCallVoiceTap() async {
    if (!isConversationInitiated) {
      return;
    }

    if (conversation.isBlocked || conversation.isLocked) {
      return;
    }
  }

  Future onCallVideoTap() async {
    if (!isConversationInitiated) {
      return;
    }

    if (conversation.isBlocked || conversation.isLocked) {
      return;
    }
  }

  void _onConversationDeleted(String event) {
    if (event != conversation.id) {
      return;
    }

    Get.back();
    ViewUtil.showAppSnackBar(
      Get.context!,
      Get.context!.l10n.chat__conversation_has_been_deleted,
    );
  }

  void onMessageTap(Message message) {
    switch (message.type) {
      case MessageType.call:
        final Call? call = Call.callFromStringJson(message.content);

        if (call != null) {
          if (message.isCallJitsi) {
            joinCallJitsi(call);

            return;
          }
        }
        break;
      default:
        break;
    }
  }

  void onUserAvatarTap(Message message) {
    if (!conversation.isGroup ||
        message.isMine(myId: currentUser.id) ||
        message.sender == null) {
      return;
    }

    final dashboardController = Get.find<ChatDashboardController>();

    showLoading();

    final Completer<void> completer = Completer<void>();
    dashboardController.goToPrivateChat(
      message.sender!,
      completer: completer,
    );

    completer.future.whenComplete(() => hideLoading());
  }

  void reportMessage(Message message) {
    Get.toNamed(
      Routes.report,
      arguments: ReportArgs(
        type: ReportType.message,
        data: message,
      ),
    )?.then(
      (isReported) {
        if (isReported != null && isReported) {
          // hideMessage(message);

          ViewUtil.showAppSnackBar(
            Get.context!,
            Get.context!.l10n.newsfeed__report_success,
            backgroundColor: AppColors.positive,
          );
        }
      },
    );
  }

  void hideMessage(Message message) {
    // _messages.value =
    //     _messages.where((element) => element.id != message.id).toList();

    final index = pagingController.itemList!
        .indexWhere((element) => element.id == message.id);

    if (index == -1) {
      return;
    }

    pagingController.removeItemAt(index);
  }

  /// This method is responsible for updating the last seen message in a conversation.
  ///
  /// After the new conversation object is retrieved, the current conversation's value is updated
  /// with the new last seen message and unread count from the new conversation object.
  ///
  /// Finally, an `UnreadMessage` event is added to the `_chatSocketService.onUnreadMessageStream`
  /// with the current conversation's ID and an unread count of 0. This is to notify other parts of the
  /// application that the last seen message for this conversation has been updated.
  void updateLastSeenMessage() {
    if (!isConversationInitiated) {
      return;
    }
  }

  void deleteMessage(Message message) {}

  void deleteMessageOnSocket(String messageId) {
    final message = pagingController.itemList
        ?.firstWhereOrNull((element) => element.id == messageId);

    if (message != null) {
      hideMessage(message);
    }
  }

  void blockUser(int userId) {}

  void unblockUser() {
    if (!isConversationInitiated ||
        conversation.isGroup ||
        !conversation.isBlocked ||
        !conversation.blockedByMe) {
      return;
    }
  }

  void _showLeaveGroupSuccess() {
    ViewUtil.showAppSnackBar(
      Get.context!,
      Get.context!.l10n.chat__conversation_leave_success,
    );
  }

  void forwardMessage(User toUser, Message message) {}

  Future jumpToMessage(Message message) async {}

  Future scrollToMessage(Message message) async {
    await scrollToValue(
      message,
      (element, value) => element.id == value.id,
    );
  }

  Future replyMessage(Message message) async {
    replyFromMessage = message;
  }

  void removeReplyMessage() {
    replyFromMessage = null;
  }

  void reactToMessage(
    Message message,
    String reactionType, {
    bool isCallToApi = true,
    String userId = '',
    bool isSocket = false,
    bool isRemoveReaction = false,
  }) {
    runAction(
      action: () async {
        var reactions = message.reactions ?? {};

        // listen to reaction event from socket
        if (isSocket) {
          // check userId exist in reactions
          final userIdExistReaction = reactions.values
              .expand((element) => element)
              .toList()
              .contains(userId);

          // remove userId from reactions
          if (userIdExistReaction) {
            reactions = reactions.map((key, value) {
              final newValue = value.where((element) => element != userId);

              return MapEntry(key, newValue.toList());
            });
          }

          // update unReaction to message
          if (isRemoveReaction) {
            final newMessageWithReaction = message.copyWith(reactions: {
              ...reactions,
            });

            _replaceMessage(
              oldMessage: message,
              newMessage: newMessageWithReaction,
            );

            return;
          }

          // update reaction to message from socket
          final newMessageWithReaction = message.copyWith(
            reactions: {
              ...reactions,
              reactionType: [
                ...reactions[reactionType] ?? [],
                userId,
              ],
            },
          );

          _replaceMessage(
            oldMessage: message,
            newMessage: newMessageWithReaction,
          );

          return;
        }

        // user react to message
        // check user has reacted according to the reactionType
        // if user has reacted according to the reactionType, remove reaction
        final valueWithReactionType = reactions[reactionType] ?? [];

        // if userId exist in valueWithReactionType, remove userId and unReact to message
        if (valueWithReactionType.contains(userId)) {
          reactions = reactions.map((key, value) {
            final newValue = value.where((element) => element != userId);

            return MapEntry(key, newValue.toList());
          });

          Message newMessageWithReaction;

          newMessageWithReaction = message.copyWith(reactions: {
            ...reactions,
          });

          _replaceMessage(
            oldMessage: message,
            newMessage: newMessageWithReaction,
          );
          if (isCallToApi) {}

          return;
        }

        // check userId exist in reactions
        final userIdExistReaction = reactions.values
            .expand((element) => element)
            .toList()
            .contains(userId);

        if (userIdExistReaction) {
          reactions = reactions.map((key, value) {
            final newValue = value.where((element) => element != userId);

            return MapEntry(key, newValue.toList());
          });
        }

        final newMessageWithReaction = message.copyWith(
          reactions: {
            ...reactions,
            reactionType: [
              ...reactions[reactionType] ?? [],
              userId,
            ],
          },
        );

        _replaceMessage(
          oldMessage: message,
          newMessage: newMessageWithReaction,
        );

        if (isCallToApi) {}

        return;
      },
    );
  }

  Future onCallVideoGroupTap() async {
    try {
      // check pin exits call jitsi
      final pinMessageController = Get.find<PinMessageController>();
      final hasCall = pinMessageController.pinnedMessages.any(
        (element) => element.type == MessageType.call && element.isCallJitsi,
      );
      // if exits throw message error and return
      if (hasCall) {
        ViewUtil.showToast(
          title: l10n.call__cant_create_meeting,
          message: l10n.call__meeting_going_on,
        );

        return;
      }
      final Call call = Call(
        id: conversation.id,
        chatChannelId: conversation.id,
      );
      final message = await sendCallGroupMessage(call);
      if (message == null) {
        return;
      }
      await pinMessageController.pinMessage(message);

      await createOrJoinCallJitsi(conversation.id, conversation.name);
    } catch (e) {
      LogUtil.e(e, name: runtimeType.toString());
    }
  }

  Future joinCallJitsi(Call call) async {
    await createOrJoinCallJitsi(call.id, conversation.name);
  }

  Future createOrJoinCallJitsi(String roomId, String roomName) async {
    final jitsiMeet = JitsiMeet();
    final configOverrides = {
      'startWithAudioMuted': true,
      'startWithVideoMuted': true,
      'subject': roomName,
      'whiteboard': {
        'enabled': true,
        'collabServerBaseUrl': 'https://whiteboard-edczoom.educhain.tech',
        'userLimit': 25,
      },
    };
    // if (!isCreatorOrAdmin) {
    //   configOverrides['buttonsWithNotifyClick'] = ['end-meeting'];
    // }

    final options = JitsiMeetConferenceOptions(
      serverURL: Get.find<EnvConfig>().jitsiServerUrl,
      room: roomId,
      configOverrides: configOverrides,
      featureFlags: {
        'unsaferoomwarning.enabled': false,
        FeatureFlags.preJoinPageEnabled: false,
        // 'ios.recording.enabled': true,
        'ios.screensharing.enabled': true,
        'recording.enabled': true,
        'meeting-password.enabled': true,
        'toolbox.enabled': true,
        'toolbox.alwaysVisible': true,
      },
      userInfo: currentUser.avatarPath != null &&
              currentUser.avatarPath!.isNotEmpty &&
              currentUser.avatarPath != 'null'
          ? JitsiMeetUserInfo(
              displayName: currentUser.fullName,
              email: currentUser.email ?? currentUser.phone ?? '',
              avatar: currentUser.avatarPath ?? '',
            )
          : JitsiMeetUserInfo(
              displayName: currentUser.fullName,
              email: currentUser.email ?? currentUser.phone ?? '',
            ),
    );
    await jitsiMeet.join(options);
  }

  void onMentionPressed(String? mention, Map<String, int> mentionUserIdMap) {
    if (mention == null) {
      return;
    }

    final userId = mentionUserIdMap[
        '<${AppConstants.mentionTag}>$mention</${AppConstants.mentionTag}>'];

    if (userId == null || userId == currentUser.id) {
      return;
    }

    final user = conversation.members.firstWhereOrNull(
      (element) => element.id == userId,
    );

    if (user != null) {
      Get.find<ChatDashboardController>().goToPrivateChat(user);
    }
  }

  void translateMessage(Message message) {
    if (!message.type.isTranslatable) {
      return;
    }
  }

  void showOriginalMessage(Message message) {
    final newMessage =
        message.copyWith(displayState: MessageDisplayState.original);

    _replaceMessage(
      oldMessage: message,
      newMessage: newMessage,
    );
  }

  void updateConversation(Conversation updatedConversation) {
    _conversation.value = updatedConversation;
  }

  void updateConversationLastSeenUser(Map<String, int> lastSeenUsersValue) {
    try {
      if (pagingController.itemList != null) {
        findIndexLastSeen(
          lastSeenUsers: lastSeenUsersValue,
          messages: pagingController.itemList!,
        );
      }
    } catch (e) {
      LogUtil.e(e);
    }
  }

  RxInt indexLastSeen = (-1).obs;
  late Map<String, int> lastSeenUser;

  void findIndexLastSeen({
    required Map<String, int> lastSeenUsers,
    required List<Message> messages,
  }) {
    try {
      if (pagingController.itemList == null) {
        indexLastSeen.value = -1;
        update();
        return;
      }
      if (conversation.isGroup) {
        indexLastSeen.value = -1;
        update();
        return;
      }
      var res = -1;
      final partner = conversation.chatPartner();
      final partnerLastSeen = DateTime.fromMillisecondsSinceEpoch(
          lastSeenUsers[partner!.id.toString()]!);

      for (int i = 0; i < messages.length; i++) {
        final message = messages[i];
        final messageCreateAt = message.createdAt;
        final isPartnerSeenLastMessage =
            messageCreateAt.isBefore(partnerLastSeen);
        if (message.isMine(myId: currentUser.id)) {
          if (isPartnerSeenLastMessage) {
            res = i;
            break;
          }
        } else {
          break;
        }
      }
      indexLastSeen.value = res;
      update();
    } catch (e) {
      LogUtil.e(e);
      indexLastSeen.value = -1;
      update();
    }
  }

  void setStateMessage(StateMessage state) {
    stateMessage.value = state;
  }

  @override
  Future<PaginatedList<Message>> fetchPaginatedList(
      {required int page, required int pageSize}) {
    // TODO: implement fetchPaginatedList
    throw UnimplementedError();
  }
}
