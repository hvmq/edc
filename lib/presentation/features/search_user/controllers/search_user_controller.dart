import 'package:get/get.dart';

import '../../../../core/helpers/debouncer.dart';
import '../../../../models/user.dart';
import '../../../base/base_controller.dart';

class SearchUserController extends BaseController {
  final _users = <User>[].obs;
  List<User> get users => _users.toList();

  final _searchDebouncer = Debouncer(delay: Duration.zero);

  RxBool isSearching = false.obs;

  void searchUser(String query) {
    query = query.trim();

    _searchDebouncer.run(() {
      runAction(
        action: () async {
          isSearching.value = true;
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
          isSearching.value = false;
        },
      );
    });
  }
}
