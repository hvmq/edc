import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/all.dart';
import '../../../../base/all.dart';
import '../../../../common_widgets/app_icon.dart';
import '../../../../resource/styles/app_colors.dart';
import '../../../../resource/styles/gaps.dart';
import '../../../../resource/styles/text_styles.dart';

class ProfileController extends BaseController with ScrollMixin {
  final isAvatarLocal = false.obs;

  RxString imagePath = ''.obs;
  RxString avatarUrl = ''.obs;
  RxString isoCode = ''.obs;
  RxString phoneEdit = ''.obs;

  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController jobController = TextEditingController();
  TextEditingController knowledgeController = TextEditingController();
  TextEditingController hobbiesController = TextEditingController();

  RxString birthDay = ''.obs;

  RxBool isDisable = true.obs;
  RxBool isFillUsername = false.obs;

  final formKey = GlobalKey<FormState>();

  final Rx<PickedMedia?> _toSendMedia = Rx(null);
  PickedMedia? get toSendMedia => _toSendMedia.value;

  var isDisableLoginBtn = true.obs;

  bool isUpdateProfileFirstLogin = false;

  @override
  Future<void> onInit() async {
    try {
      isUpdateProfileFirstLogin =
          Get.arguments['isUpdateProfileFirstLogin'] as bool;
    } catch (e) {
      LogUtil.e(e);
    }

    avatarUrl.value = currentUser.avatarPath ?? '';

    // usernameController.text = currentUser.nickname ?? '';
    firstNameController.text = currentUser.firstName;
    lastNameController.text = currentUser.lastName;
    emailController.text = currentUser.email ?? '';
    phoneController.text = currentUser.phone ?? '';
    knowledgeController.text =
        currentUser.knowledge == 'null' ? '' : currentUser.knowledge ?? '';
    jobController.text = currentUser.job == 'null' ? '' : currentUser.job ?? '';
    hobbiesController.text =
        currentUser.hobbies == 'null' ? '' : currentUser.hobbies ?? '';
    birthDay.value =
        currentUser.birthDay == 'null' ? '' : currentUser.birthDay ?? '';

    // await getRegionInfoFromPhoneNumber(currentUser.phone ?? '');

    isDisableLoginBtn.value = true;
    super.onInit();
  }

  set setDisableLoginBtn(bool value) {
    isDisableLoginBtn.value = value;
  }

  set setFillUsername(bool value) {
    isFillUsername.value = value;
  }

  void setDisableSave() {
    final currentKnowledge =
        currentUser.knowledge == 'null' ? '' : currentUser.knowledge ?? '';
    final currentJob = currentUser.job == 'null' ? '' : currentUser.job ?? '';
    final currentHobbies =
        currentUser.hobbies == 'null' ? '' : currentUser.hobbies ?? '';
    final currentBirthDay =
        currentUser.birthDay == 'null' ? '' : currentUser.birthDay ?? '';
    isDisable.value =
        firstNameController.text.trim() == currentUser.firstName &&
            lastNameController.text.trim() == currentUser.lastName &&
            !isFillUsername.value &&
            knowledgeController.text.trim() == currentKnowledge &&
            jobController.text.trim() == currentJob &&
            hobbiesController.text.trim() == currentHobbies &&
            birthDay.value == currentBirthDay &&
            !isAvatarLocal.value;
  }

  void attachMedia(PickedMedia media) {
    _toSendMedia.value = media;
  }

  Future<void> onCameraButtonPressed(BuildContext context) async {
    await MediaHelper.takeImageFromCamera().then((media) {
      if (media != null) {
        if (isAvatarLocal.value == false) {}
        attachMedia(media);
        imagePath.value = media.file.path;
        isAvatarLocal.value = true;
        setDisableSave();
      }
    });
  }

  Future<void> getImageFromGallery(BuildContext context) async {
    await MediaHelper.pickImageFromGallery().then((media) {
      if (media != null) {
        if (isAvatarLocal.value == false) {
          // showModalBottomSheet(
          //     isScrollControlled: true,
          //     context: context,
          //     builder: (context) => customBackground());
        }
        attachMedia(media);
        imagePath.value = media.file.path;
        isAvatarLocal.value = true;
        setDisableSave();
      }
    }).catchError(
      (error) {
        if (error is ValidationException) {
          ViewUtil.showToast(
            title: Get.context!.l10n.error__file_is_too_large_title,
            message: Get.context!.l10n.error__file_is_too_large_message,
          );
        }
      },
    );
  }

  Future<void> updateAvatar({
    required File file,
  }) async {}

  Future<void> updateProfile() async {
    if (formKey.currentState!.validate()) {
      if (_toSendMedia.value != null) {
        await updateAvatar(file: _toSendMedia.value!.file);
      }
    }
  }

  String validFirstName(String firstName) {
    if (firstName.isEmpty) {
      return l10n.field__first_name_error_empty;
    }

    return '';
  }

  String validLastName(String lastName) {
    if (lastName.isEmpty) {
      return l10n.field__last_name_error_empty;
    }

    return '';
  }

  String validNickname(String nickname) {
    if (nickname.isEmpty) {
      return l10n.field__nickname_error_empty;
    } else if (!ValidationUtil.isValidUsername(nickname)) {
      return l10n.profile__username_not_valid;
    }

    return '';
  }

  String validEmail(String email) {
    if (email.isEmpty) {
      return l10n.field__email_error_empty;
    } else if (!ValidationUtil.isValidEmail(email)) {
      return l10n.field__email_error_invalid;
    }

    return '';
  }

  // Future<void> getRegionInfoFromPhoneNumber(String phone) async {
  //   if (phone.isEmpty) {
  //     isoCode.value = 'VN';

  //     return;
  //   }

  //   final PhoneNumber phoneNumberParse =
  //       await PhoneNumber.getRegionInfoFromPhoneNumber(phone);

  //   final String phoneParsableNumber =
  //       await PhoneNumber.getParsableNumber(phoneNumberParse);

  //   isoCode.value = phoneNumberParse.isoCode ?? '';
  //   phoneEdit.value = phoneNumberParse.phoneNumber ?? '';
  //   phoneController.text = phoneParsableNumber;
  //   update();
  // }

  Widget buildOptionItem({
    required BuildContext context,
    required Widget icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        icon,
        AppSpacing.gapH4,
        Text(
          title,
          style: AppTextStyles.s12w400.copyWith(
            color: AppColors.text1,
          ),
        ),
      ],
    ).clickable(() {
      Get.back();
      onTap();
    });
  }

  Widget buildCameraButton() {
    return buildOptionItem(
      context: Get.context!,
      icon: AppIcon(
        icon: AppIcons.camera,
        isCircle: true,
        backgroundColor: AppColors.button5,
        padding: AppSpacing.edgeInsetsAll8,
        color: Colors.white,
      ),
      title: Get.context!.l10n.chat_hub__camera_label,
      onTap: () {
        onCameraButtonPressed(Get.context!);
      },
    );
  }

  Widget buildGalleryButton() {
    return buildOptionItem(
      context: Get.context!,
      icon: AppIcon(
        icon: AppIcons.gallery,
        isCircle: true,
        backgroundColor: AppColors.button5,
        padding: AppSpacing.edgeInsetsAll8,
        color: Colors.white,
      ),
      title: Get.context!.l10n.chat_hub__gallery_label,
      onTap: () {
        getImageFromGallery(Get.context!);
      },
    );
  }

  void openImageOption() {
    ViewUtil.showBottomSheet(
      child: Padding(
        padding: AppSpacing.edgeInsetsAll20.copyWith(bottom: 0),
        child: GridView(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: Sizes.s16,
            mainAxisSpacing: Sizes.s32,
          ),
          children: [
            buildCameraButton(),
            buildGalleryButton(),
          ],
        ),
      ),
    );
  }

  @override
  Future<void> onEndScroll() async {
    // await loadMorePostPersonalPage();
  }

  @override
  Future<void> onTopScroll() async {
    // if (scroll.hasClients) {
    //   await scroll.animateTo(
    //     0,
    //     duration: const Duration(seconds: 1),
    //     curve: Curves.easeInOut,
    //   );
    // }
  }
}
