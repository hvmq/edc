import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/all.dart';
import '../../../../models/all.dart';
import '../../../base/all.dart';

class AddContactNumberController extends BaseController {
  UserContact? user = Get.arguments['user'];
  bool isAddContact = Get.arguments['isAddContact'];
  final formKey = GlobalKey<FormState>();
  RxString imagePath = ''.obs;
  RxString avatarUrl = ''.obs;
  final isAvatarLocal = false.obs;

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController inputEnterPhoneController =
      TextEditingController();

  RxBool isAddNumber = false.obs;
  Rx<File?> avatarFile = Rx<File?>(null);

  RxString savedAvatarUrl = ''.obs;

  bool getIsShowPhone() {
    return user?.user?.isShowPhone ?? true;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    if (user != null) {
      firstNameController.text = user?.contactFirstName ?? '';
      lastNameController.text = user?.contactLastName ?? '';
      inputEnterPhoneController.text = user?.contactPhoneNumber ?? '';

      isAddNumber.value = false;
    } else {
      isAddNumber.value = true;
    }
    update();
    checkContactExist();
  }

  Future<void> checkContactExist() async {
    savedAvatarUrl.value = user!.user?.avatarPath ?? '';
    update();

    if (isAddContact) {
      return;
    }

    await runAction(
      action: () async {},
    );
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

  Future<void> uploadAvatar() async {
    if (avatarFile.value != null) {}
  }

  void addContact() {
    if (inputEnterPhoneController.text.trim().isEmpty) {
      ViewUtil.showToast(
        title: l10n.global__error_title,
        message: l10n.field_phone__error_empty,
      );
      return;
    }
  }

  void deleteContact() {
    if (isAddContact) {
      return;
    }
    final contactId = user?.id ?? 0;
  }
}
