import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/all.dart';
import '../../../../models/all.dart';
import '../../../base/all.dart';

class ContactController extends BaseController
    with GetTickerProviderStateMixin {
  // static const _pageSize = 15;

  // TextEditingController searchController = TextEditingController();
  RxBool isSearching = false.obs;
  RxList<UserContact> usersList = <UserContact>[].obs;
  RxList<UserContact> contactsSearching = <UserContact>[].obs;

  int pageKey = 0;
  final ScrollController scrollController = ScrollController();

  static List<UserContact> usersContact = [];

  RxString isoCode = ''.obs;
  RxBool isEditContact = false.obs;

  // Avatar
  RxString imagePath = ''.obs;
  // RxString avatarUrl = ''.obs;
  final isAvatarLocal = false.obs;
  RxString phoneEdit = ''.obs;
  RxBool isDisabledBtnSync = false.obs;
  RxBool isDisabledBtnAdd = false.obs;
  RxBool isDisabledBtnEdit = false.obs;

  final TextEditingController inputEnterPhoneController =
      TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  late AnimationController animationController;

  final formKey = GlobalKey<FormState>();

  final _searchDebouncer = Debouncer();

  Rx<File?> avatarFile = Rx<File?>(null);
  RxString avatarUrl = ''.obs;

  late TabController tabController;

  @override
  Future<void> onInit() async {
    // searchController.addListener(_onSearchChanged);
    tabController = TabController(length: 3, vsync: this);

    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..repeat();
    animationController.stop();

    getUserContacts();

    super.onInit();
  }

  @override
  void dispose() {
    scrollController.dispose();
    animationController.dispose();
    super.dispose();
  }

  // void _onSearchChanged() {
  //   changeSearching = true;
  // searchContact(searchController.text);
  // }

  set changeSearching(bool value) {
    isSearching.value = value;
  }

  set changeIsEditContact(bool value) {
    isEditContact.value = value;
    update();
  }

  void getUserContacts({bool isLoading = true}) {}

  Future<void> searchContact(String query) async {
    // if (searchController.text.isEmpty) {
    //   changeSearching = false;

    //   return;
    // }

    _searchDebouncer.run(() {
      contactsSearching.clear();
      query = query.trim();
      // if (RegExp(r'^[0-9]+$').hasMatch(query) && query.startsWith('0')) {
      //   query = query.substring(1);
      // }

      final List<UserContact> users = usersList.where((userContact) {
        if (userContact.contactPhoneNumber.contains(query) ||
            userContact.fullName.toLowerCase().contains(query.toLowerCase())) {
          return true;
        }

        // if (userContact.user?.webUserId?.contains(query) ?? false) {
        //   return true;
        // }

        return false;
      }).toList();

      contactsSearching.addAll(users);
    });
  }

  Future<void> updateContact(UserContact user) async {
    isDisabledBtnEdit.value = true;
    update();
  }

  void deleteContact(int contactId) {}

  void updateDeleteContact(int contactId) {
    usersList.removeWhere((element) => element.id == contactId);
    update();
  }

  // Future<void> addContact() async {
  //   isDisabledBtnAdd.value = true;
  //   update();
  //   try {
  //     if (formKey.currentState!.validate()) {
  //       final user = UserContact(
  //         contactFirstName: firstNameController.text.trim(),
  //         contactLastName: lastNameController.text.trim(),
  //         contactPhoneNumber: phoneEdit.value.trim(),
  //         contactAvatarPath: avatarUrl.value.trim(),
  //       );

  //       late ContactsResult contactsResult;

  //       await runAction(action: () async {
  //         contactsResult = await _contactRepository.addContact([user]);
  //       });

  //       _userPool.updateContact(user);

  //       if (contactsResult.created.isNotEmpty) {
  //         usersList.add(contactsResult.created.first);
  //         update();

  //         Get.back();

  //         ViewUtil.showToast(
  //           title: l10n.global__success_title,
  //           message: l10n.contact__add_success,
  //         );
  //       } else if (contactsResult.notCreated.existed.isNotEmpty) {
  //         ViewUtil.showToast(
  //           title: l10n.global__error_title,
  //           message: l10n.contact__already_exist,
  //         );
  //       } else if (contactsResult.notCreated.notFounds.isNotEmpty) {
  //         ViewUtil.showToast(
  //           title: l10n.global__error_title,
  //           message: l10n.contact__no_exist,
  //         );
  //       } else {
  //         ViewUtil.showToast(
  //           title: l10n.global__error_title,
  //           message: l10n.global__error_has_occurred,
  //         );
  //       }
  //     }
  //   } finally {
  //     Future.delayed(const Duration(milliseconds: 1000), () {
  //       isDisabledBtnAdd.value = false;
  //       update();
  //     });
  //   }
  // }

  // Future<void> reSyncContactLocal() async {
  //   try {
  //     isDisabledBtnSync.value = true;
  //     update();

  //     final List<UserContact> contacts = await getAndSyncContactLocalPhone();
  //     if (contacts.isNotEmpty) {
  //       usersList.addAll(contacts);
  //       update();
  //     }

  //     animationController.stop();
  //     animationController.reset();
  //   } catch (e) {
  //     ViewUtil.showToast(
  //       title: l10n.global__error_title,
  //       message: l10n.global__error_has_occurred,
  //     );
  //   } finally {
  //     Future.delayed(const Duration(milliseconds: 500), () {
  //       animationController.stop();
  //       animationController.reset();
  //       isDisabledBtnSync.value = false;
  //       update();
  //     });
  //   }
  // }

  void onCallVoice(UserContact user) {
    if (user.userId == null) {
      return;
    }
  }

  void confirmCallTranslate(UserContact user) {}

  void onCallTranslate(UserContact user) {
    if (user.userId == null) {
      return;
    }
  }

  void onVideoCall(UserContact user) {
    if (user.userId == null) return;
  }

  Future<void> goToPrivateChat(UserContact contact) async {
    if (contact.contactId == null) {
      return;
    }
  }

  void updateExpanded(UserContact userContact) {
    if (usersList.isNotEmpty && userContact.isExpanded) {
      for (var user in usersList) {
        user.isExpanded = false;
      }
    } else if (usersList.isNotEmpty) {
      for (var user in usersList) {
        user.isExpanded = false;
      }
      userContact.isExpanded = true;
    }

    update();
  }

  Future<void> getImageFromGallery() async {
    final pickedImage = await MediaHelper.pickImageFromGallery();

    if (pickedImage == null) {
      return;
    }

    avatarFile.value = pickedImage.file;
  }

  void resetAvatarFile() {
    avatarFile.value = null;
  }

  Future<void> uploadAvatar() async {}

  void addContact() {}

  // Danh sách chứa kết quả tìm kiếm
  RxList<UserContact> searchResults = <UserContact>[].obs;

  // Hàm tìm kiếm
  void searchUser(String query) {
    late List<UserContact> initialResults;
    if (query.isEmpty) {
      // Nếu không có từ khóa, trả về danh sách đầy đủ
      initialResults = usersList;
    } else {
      // Tìm kiếm và lọc danh sách
      final List<UserContact> initialResults = usersList.where((user) {
        // Kiểm tra từng điều kiện riêng lẻ
        if (user.contactFirstName.toLowerCase().contains(query.toLowerCase())) {
          return true;
        }
        if (user.contactLastName.toLowerCase().contains(query.toLowerCase())) {
          return true;
        }
        if (user.contactPhoneNumber
            .toLowerCase()
            .contains(query.toLowerCase())) {
          return true;
        }

        // Kiểm tra nếu user.user != null và tìm kiếm bên trong các thuộc tính của nó
        if (user.user != null) {
          if (user.user!.fullName.toLowerCase().contains(query.toLowerCase())) {
            return true;
          }
          final email = user.user!.email ?? '';
          if (email.toLowerCase().contains(query.toLowerCase())) {
            return true;
          }
          final phone = user.user!.phone ?? '';
          if (phone.toLowerCase().contains(query.toLowerCase())) {
            // Giả sử user.user có các thuộc tính này
            return true;
          }
        }

        // Nếu không thỏa mãn bất kỳ điều kiện nào, trả về false
        return false;
      }).toList();
    }

    final List<UserContact> res = [];
    for (var i in initialResults) {
      final list = res.where((j) {
        return j.contactFirstName + j.contactLastName + j.contactPhoneNumber ==
            i.contactFirstName + i.contactLastName + i.contactPhoneNumber;
      });
      if (list.isEmpty) {
        res.add(i);
      }
    }
    searchResults.value = res;
  }
}
