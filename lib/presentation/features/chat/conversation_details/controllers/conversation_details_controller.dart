import 'dart:async';
import 'dart:io';

import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/all.dart';
import '../../../../../models/all.dart';
import '../../../../../models/enums/mute_conversation_option_enum.dart';
import '../../../../base/base_controller.dart';
import '../../../../routing/routers/app_pages.dart';
import '../../all.dart';

class ConversationDetailsArguments {
  final Conversation conversation;

  const ConversationDetailsArguments({
    required this.conversation,
  });
}

class ConversationDetailsController extends BaseController
    with SingleGetTickerProviderMixin {
  late final Rx<Conversation> _conversation;

  Conversation get conversation => _conversation.value;

  final conversationNameController = TextEditingController();
  final _newAvatar = Rxn<File>();

  File? get newAvatar => _newAvatar.value;

  final _isEdited = false.obs;

  bool get isEdited => _isEdited.value;

  bool isConversationUpdated = false;

  bool get isCreatorOrAdmin => conversation.isCreatorOrAdmin(currentUser.id);

  RxList<UserContact> userContactList = <UserContact>[].obs;

  final Rx<User?> _userPartner = Rx(null);

  final _eventBus = Get.find<EventBus>();

  //conversation resource
  late final TabController tabController;
  late final TabController tabBarGroupController;

  final RxList<String> _images = <String>[].obs;
  List<String> get images => _images.reversed.toList();

  final RxList<String> _videos = <String>[].obs;
  List<String> get videos => _videos.reversed.toList();

  final RxList<String> _audios = <String>[].obs;
  List<String> get audios => _audios.reversed.toList();

  final RxList<String> _links = <String>[].obs;
  List<String> get links => _links.reversed.toList();
  //conversation resource

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 4, vsync: this);
    tabBarGroupController = TabController(length: 5, vsync: this);
    final args = Get.arguments as ConversationDetailsArguments;
    _conversation = args.conversation.obs;
    conversationNameController.text = conversation.name;

    if (!conversation.isGroup) {
      _getContactInfo();
    }

    _loadConversationResources();
    _loadConversationLinks();

    searchMemberResult.value = args.conversation.members;
    update();
  }

  @override
  void onClose() {
    conversationNameController.dispose();
    super.onClose();
  }

  Future<void> _getContactInfo() async {
    await getUserById(_conversation.value.chatPartner()!.id);
    await checkContactExist();
  }

  Future<void> getContactInfo() async {
    await getUserById(_conversation.value.chatPartner()!.id);
    await checkContactExist();
  }

  void validateIsEdited() {
    _isEdited.value = conversationNameController.text != conversation.name ||
        newAvatar != null;
  }

  void goToChatResources() {
    Get.toNamed(
      Routes.conversationResources,
      arguments: ConversationResourcesArguments(conversation: conversation),
    );
  }

  void onDeleteChat(BuildContext context) {
    ViewUtil.showAppCupertinoAlertDialog(
      title: context.l10n.delete_chat__confirm_title,
      message: context.l10n.delete_chat__confirm_message,
      negativeText: context.l10n.button__cancel,
      positiveText: context.l10n.button__confirm,
      onPositivePressed: deleteChat,
    );
  }

  void deleteChat() {}

  void saveChanges() {
    if (!isEdited) {
      return;
    }

    if (conversationNameController.text.isEmpty) {
      return ViewUtil.showAppSnackBar(
        Get.context!,
        Get.context!.l10n.conversation_details__error_empty_chat_name,
      );
    }
  }

  Future<void> pickImage() async {
    final pickedImage = await MediaHelper.pickImageFromGallery();

    if (pickedImage == null) {
      return;
    }

    _newAvatar.value = pickedImage.file;

    validateIsEdited();
  }

  void updateConversation(Conversation updatedConversation) {
    _conversation.value = updatedConversation;

    searchMemberResult.value =
        searchUsersByQuery(updatedConversation.members, searchController.text);

    Get.find<ChatHubController>().updateConversation(updatedConversation);
  }

  void goToChatMembers() {
    Get.toNamed(
      Routes.conversationMembers,
      arguments: ConversationMembersArguments(conversation: conversation),
    );
  }

  void onCallVoiceClick() {}

  void onCallVideoClick() {}

  Future<void> getUserById(int userId) async {}

  String getInfoPartner() {
    final String phone = _userPartner.value?.phone ?? '';
    final String nickname = _userPartner.value?.nickname ?? '';

    if (phone.isNotEmpty && nickname.isNotEmpty) {
      return '$phone • @$nickname';
    } else if (phone.isNotEmpty) {
      return phone;
    } else if (nickname.isNotEmpty) {
      return '@$nickname';
    } else {
      return '';
    }
  }

  String getEmailPartner() {
    return _userPartner.value?.email ?? '';
  }

  String getPhonePartner() {
    return _userPartner.value?.phone ?? '';
  }

  String getNicknamePartner() {
    return _userPartner.value?.nickname ?? '';
  }

  bool getIsShowPhonePartner() {
    return _userPartner.value?.isShowPhone ?? true;
  }

  RxBool isShowPhone = false.obs;

  Future<void> checkContactExist() async {}

  void updateForChat(UserContact userContact) {}

  void onAddContactClick({required UserContact userContact}) {}

  void onEditContactClick({required UserContact userContact}) {}

  void onLeaveGroupChat() {}

  void onBlockChat(BuildContext context) {
    if (conversation.isGroup) {
      return;
    }

    final chatHubController = Get.find<ChatHubController>();

    chatHubController.blockUser(conversation.chatPartner()!.id);

    Get.back();
  }

  void onMuteConversation(MuteConversationOption e) {}

  void onUnMuteConversation() {}

  void updateMuteInChatHubView(bool mute) {
    if (Get.isRegistered<ChatHubController>()) {
      final chatHubController = Get.find<ChatHubController>();
      chatHubController.conversationUpdated(
        chatHubController.conversation.copyWith(
          isMuted: mute,
        ),
      );
    }
  }

  void onCallVideoGroupClick() {
    if (Get.isRegistered<ChatHubController>()) {
      final chatHubController = Get.find<ChatHubController>();
      chatHubController.onCallVideoGroupTap();
    }
  }

  Future<void> _loadConversationResources() async {}

  Future<void> _loadConversationLinks() async {
    // link is include in content inside tag <hyper>
  }

  void promoteOrRemoveAdmin(User member, bool isAddAdmin) {
    final adminIds = isAddAdmin
        ? [...conversation.adminIds, member.id]
        : conversation.adminIds.where((id) => id != member.id).toList();
  }

  bool get canRemoveMembers =>
      conversation.creatorId == currentUser.id ||
      conversation.isAdmin(currentUser.id);

  Future<void> addMember(User member) async {}

  void onMemberAvatarTap(User member) {
    if (member.isDeactivated() || member.id == currentUser.id) {
      return;
    }

    Get.back();

    final dashboardController = Get.find<ChatDashboardController>();

    showLoading();

    final Completer<void> completer = Completer<void>();
    dashboardController.goToPrivateChat(
      member,
      completer: completer,
    );

    completer.future.whenComplete(() => hideLoading());
  }

  Future<void> removeMember(User member) async {}

  RxList<User> searchMemberResult = <User>[].obs;

  TextEditingController searchController = TextEditingController();

  List<User> searchUsersByQuery(List<User> users, String query) {
    // Chuyển query về chữ thường để không phân biệt chữ hoa, chữ thường
    final String lowerCaseQuery = query.toLowerCase();

    // Lọc danh sách user theo điều kiện
    return users.where((user) {
      return (query.isEmpty) ||
          (user.nickname ?? '').toLowerCase().contains(lowerCaseQuery) ||
          (user.email ?? '').toLowerCase().contains(lowerCaseQuery) ||
          (user.phone ?? '').toLowerCase().contains(lowerCaseQuery) ||
          (user.webUserId ?? '').toLowerCase().contains(lowerCaseQuery);
    }).toList();
  }

  void searchUserInGroup(String query) {
    searchMemberResult.value =
        searchUsersByQuery(_conversation.value.members, query);
    update();
  }
}
