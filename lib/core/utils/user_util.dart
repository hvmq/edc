import 'package:get/get.dart';

import '../../models/user.dart';
import '../../models/user_contact.dart';
import '../../presentation/features/call_gateway/contact/contact_controller.dart';
import '../all.dart';

class UserUtil {
  static bool isSavedContact(User? user) {
    try {
      if (user == null) return false;
      final contactController = Get.find<ContactController>();
      final index = contactController.usersList.value.firstWhereOrNull(
          (value) =>
              ((value.contactPhoneNumber ?? (value.user?.phone ?? '')) ==
                  user.phone) ||
              ((value.contactId ?? (value.user?.id ?? '')) == user.id));

      return index == null ? false : true;
    } catch (e) {
      LogUtil.e(e.toString());
      return false;
    }
  }

  static UserContact? getUserContact(User? user) {
    try {
      if (user == null) return null;
      final contactController = Get.find<ContactController>();
      final index = contactController.usersList.value.firstWhereOrNull(
          (value) =>
              ((value.contactPhoneNumber ?? (value.user?.phone ?? '')) ==
                  user.phone) ||
              ((value.contactId ?? (value.user?.id ?? '')) == user.id));

      return index;
    } catch (e) {
      LogUtil.e(e.toString());
      return null;
    }
  }
}
