import 'package:get/get.dart';

import '../../../../core/all.dart';
import '../../../../models/conversation.dart';
import '../../../../models/user.dart';
import '../../../base/all.dart';
import '../../chat/dashboard/controllers/dashboard_controller.dart';

class SearchInfoController extends BaseController {
  final _chatDashboardController = Get.find<ChatDashboardController>();

  final _users = <User>[].obs;
  List<User> get users => _users.toList();

  final _conversations = <Conversation>[].obs;
  List<Conversation> get conversations => _conversations.toList();

  final _searchDebouncer = Debouncer();

  void searchConversations(String query) {
    _conversations.clear();

    if (query.trim().isEmpty) {
      return;
    }

    _conversations
        .addAll(_chatDashboardController.allConversations.where((conversation) {
      return conversation.title().containsIgnoreCase(query.trim());
    }));
  }

  void search(String query) {
    query = query.trim();

    searchConversations(query);

    _searchDebouncer.run(() {
      runAction(
        handleLoading: false,
        action: () async {
          if (query.trim().isEmpty) {
            _users.value = [];

            return;
          }

          // if query is phone number and start with 0, remove the 0
          if (RegExp(r'^[0-9]+$').hasMatch(query) && query.startsWith('0')) {
            query = query.substring(1);
          }

          _users.value =
              users.where((user) => user.id != currentUser.id).toList();
        },
      );
    });
  }

  Future<void> goToPrivateChat(User user) async {}
}
