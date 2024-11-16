import 'dart:async';

import 'package:get/get.dart';

import '../../../../../models/conversation.dart';
import '../../../../../models/user.dart';
import '../../../../base/base_controller.dart';
import '../../../all.dart';

class ConversationMembersArguments {
  final Conversation conversation;

  const ConversationMembersArguments({
    required this.conversation,
  });
}

class ConversationMembersController extends BaseController {
  late Conversation conversation;

  final _members = <User>[].obs;
  List<User> get members => _members;

  bool get canRemoveMembers =>
      conversation.creatorId == currentUser.id ||
      conversation.isAdmin(currentUser.id);

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments as ConversationMembersArguments;
    conversation = args.conversation;

    _members.assignAll(conversation.members);

    _getConversationDetails();
  }

  Future<void> _getConversationDetails() async {}

  void updateMembers(List<User> members) {
    // order creator > admin > you > others
    final sortedMembers = List<User>.from(
      members
        ..sort(
          (a, b) {
            if (a.id == conversation.creatorId) {
              return -1;
            } else if (conversation.isAdmin(a.id)) {
              return -1;
            } else if (a.id == currentUser.id) {
              return -1;
            } else {
              return 1;
            }
          },
        ),
    );

    _members.assignAll(sortedMembers);
  }

  Future<void> removeMember(User member) async {}

  Future<void> addMember(User member) async {}

  void updateConversation(Conversation updatedConversation) {
    conversation = updatedConversation;
    Get.find<ConversationDetailsController>().updateConversation(conversation);
  }

  void promoteOrRemoveAdmin(User member, bool isAddAdmin) {
    final adminIds = isAddAdmin
        ? [...conversation.adminIds, member.id]
        : conversation.adminIds.where((id) => id != member.id).toList();
  }

  // Future<void> goToPrivateChat(User member) async {
  //   final dashboardController = Get.find<ChatDashboardController>();

  //   try {
  //     showLoading();

  //     await dashboardController.goToPrivateChat(member);
  //   } finally {
  //     hideLoading();
  //   }
  // }
}
