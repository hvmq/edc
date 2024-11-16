import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../../../../core/all.dart';
import '../../../../../common_widgets/all.dart';
import '../../../../../resource/resource.dart';
import '../../../../all.dart';

class ProfileInfomationPage extends StatefulWidget {
  const ProfileInfomationPage({super.key});

  @override
  State<ProfileInfomationPage> createState() => _ProfileInfomationPageState();
}

class _ProfileInfomationPageState extends State<ProfileInfomationPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController birthDayController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController languageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String firstName = '';
  String lastName = '';
  String username = '';
  String password = '';
  String passwordConfirm = '';
  String phone = '';
  int id = 0;
  String imagePath = '';
  String avatarUrl = '';
  PickedMedia? toSendMedia;

  String? email;
  @override
  void initState() {
    super.initState();
    // password = Get.arguments['password'] as String;
    // passwordConfirm = Get.arguments['passwordConfirm'] as String;
    final phoneBegin = Get.arguments['phone'] as String;
    id = Get.arguments['id'] as int;
    email = Get.arguments['email'] as String;
    final nickname = Get.arguments['nickname'] as String?;
    final avatar = Get.arguments['avatarPath'] as String?;
    final firstName = Get.arguments['firstName'] as String?;
    final lastName = Get.arguments['lastName'] as String?;

    phone = phoneBegin.replaceAll(RegExp(r'\s+'), '');
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      updateLanguage();
      phoneController.text = phone;
      firstNameController.text = firstName ?? '';
      lastNameController.text = lastName ?? '';
      usernameController.text = nickname ?? '';
      imagePath = avatar ?? '';

      setState(() {});
    });
  }

  @override
  void dispose() {
    birthDayController.dispose();
    super.dispose();
  }

  bool isAvatarLocal = false;

  void attachMedia(PickedMedia media) {
    toSendMedia = media;
  }

  void updateLanguage() {}

  void onCameraButtonPressed() {
    MediaHelper.takeImageFromCamera().then((media) {
      if (media != null) {
        setState(() {
          attachMedia(media);
          imagePath = media.file.path;
          isAvatarLocal = true;
        });
      }
    });
  }

  Future<void> getImageFromGallery() async {
    await MediaHelper.pickImageFromGallery().then((media) {
      if (media != null) {
        setState(() {
          attachMedia(media);
          imagePath = media.file.path;
          isAvatarLocal = true;
        });
      }
    }).catchError(
      (error) {
        // if (error is ValidationException) {
        //   ViewUtil.showToast(
        //     title: Get.context!.l10n.error__file_is_too_large_title,
        //     message: Get.context!.l10n.error__file_is_too_large_message,
        //   );
        // }
      },
    );
  }

  Widget _buildOptionItem({
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
            color: AppColors.white,
          ),
        ),
      ],
    ).clickable(() {
      Get.back();
      onTap();
    });
  }

  Widget _buildCameraButton() {
    return _buildOptionItem(
      context: Get.context!,
      icon: AppIcon(
        icon: AppIcons.camera,
        isCircle: true,
        backgroundColor: AppColors.button5,
        padding: AppSpacing.edgeInsetsAll8,
      ),
      title: Get.context!.l10n.chat_hub__camera_label,
      onTap: onCameraButtonPressed,
    );
  }

  Widget _buildGalleryButton() {
    return _buildOptionItem(
      context: Get.context!,
      icon: AppIcon(
        icon: AppIcons.gallery,
        isCircle: true,
        backgroundColor: AppColors.button5,
        padding: AppSpacing.edgeInsetsAll8,
      ),
      title: Get.context!.l10n.chat_hub__gallery_label,
      onTap: getImageFromGallery,
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
            _buildCameraButton(),
            _buildGalleryButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildTextFieldName(
    TextEditingController controller,
    TextInputAction textInputAction, {
    String? Function(String?)? validator,
    Function(String)? onChanged,
    bool readOnly = false,
    String? hintText,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return AppTextField(
      textInputAction: textInputAction,
      controller: controller,
      fillColor: Colors.transparent,
      border: InputBorder.none,
      contentPadding: const EdgeInsets.all(Sizes.s20),
      readOnly: readOnly,
      hintText: hintText,
      hintStyle: AppTextStyles.s16w400.copyWith(color: AppColors.text6),
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: onChanged,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
    );
  }

  Widget _buildTextFieldSingle({
    required TextEditingController controller,
    required TextInputAction textInputAction,
    String? Function(String?)? validator,
    Function(String)? onChanged,
    String? hintText,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
  }) =>
      Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.backgroundTextField),
        child: _buildTextFieldName(controller, textInputAction,
            hintText: hintText,
            validator: validator,
            onChanged: onChanged,
            keyboardType: keyboardType,
            inputFormatters: inputFormatters),
      );

  Widget _buildTextFieldDouple(
          {required TextEditingController controllerFirst,
          required TextEditingController controllerSecond,
          required TextInputAction textInputActionFirst,
          required TextInputAction textInputActionSecond,
          String? Function(String?)? validatorFirst,
          String? Function(String?)? validatorSecond,
          Function(String)? onChangedFirst,
          Function(String)? onChangedSecond,
          String? hintTextFirst,
          String? hintTextSecond,
          bool readOnlyFirst = false,
          bool readOnlySecond = false}) =>
      Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.backgroundTextField),
        child: Column(
          children: [
            _buildTextFieldName(controllerFirst, textInputActionFirst,
                hintText: hintTextFirst,
                validator: validatorFirst,
                onChanged: onChangedFirst,
                readOnly: readOnlyFirst),
            Padding(
              padding: AppSpacing.edgeInsetsH20,
              child: AppDivider(
                color: AppColors.border3,
              ),
            ),
            _buildTextFieldName(controllerSecond, textInputActionSecond,
                hintText: hintTextSecond,
                validator: validatorSecond,
                onChanged: onChangedSecond,
                readOnly: readOnlySecond),
          ],
        ),
      );

  Widget _buildAvatar() => SizedBox(
        width: 130.w,
        height: 130.w,
        child: Stack(
          fit: StackFit.expand,
          clipBehavior: Clip.none,
          children: [
            AppCircleAvatar(
              size: 130.w,
              url: imagePath,
            ),
          ],
        ),
      );

  Widget _buildButtonComplete() => GetBuilder<RegisterController>(
        init: RegisterController(),
        builder: (controller) {
          firstName = controller.firstName;
          lastName = controller.lastName;
          username = controller.username;

          return Obx(() => AppButton.secondary(
                // isDisabled: isDisableBtn,
                label: Get.context!.l10n.mana_mission__complete,
                color: AppColors.button5,
                width: double.infinity,
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final isExist =
                        await controller.checkPhoneNumberIsExists(phone);
                    if (isExist) {
                      await controller.updateInfo(
                        firstNameController.text,
                        lastNameController.text,
                        usernameController.text,
                        '@PassworddefaulPisolution07062024',
                        '@PassworddefaulPisolution07062024',
                        phone,
                        toSendMedia,
                        context,
                        controller,
                      );
                    } else {
                      ViewUtil.showToast(
                        title: context.l10n.global__error_title,
                        message: context.l10n.profile__phone_exits,
                      );
                      await showCupertinoModalBottomSheet(
                        expand: true,
                        context: context,
                        enableDrag: false,
                        builder: (context) => BottomSheetChooseNumber(
                          controller: controller,
                          type: 'number',
                          currentId: 0,
                          email: controller.email,
                        ),
                      ).then((value) {
                        if (value != null) {
                          setState(() {
                            phone = value;
                            phoneController.text = value;
                          });
                        }
                      });
                    }
                  }
                },
                isLoading: controller.isLoadingUpdateInfo.value,
              ));
        },
      );

  // void check() {
  //   if (usernameController.text.trim().isEmpty ||
  //       firstNameController.text.trim().isEmpty ||
  //       lastNameController.text.trim().isEmpty) {
  //     setState(() {
  //       isDisableBtn = true;
  //     });
  //   } else {
  //     setState(() {
  //       isDisableBtn = false;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      backgroundLayer: true,
      appBar: CommonAppBar(
        titleType: AppBarTitle.text,
        text: context.l10n.your_info,
        titleTextStyle: AppTextStyles.s20w600.text5Color,
        // leadingIconColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _buildAvatar(),
                AppSpacing.gapH28,
                _buildTextFieldDouple(
                  controllerFirst: firstNameController,
                  controllerSecond: lastNameController,
                  textInputActionFirst: TextInputAction.next,
                  textInputActionSecond: TextInputAction.next,
                  hintTextFirst: context.l10n.profile__first_name,
                  hintTextSecond: context.l10n.profile__last_name,
                  validatorFirst: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return context.l10n.text_validate_firstname;
                    }
                    return null;
                  },
                  validatorSecond: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return context.l10n.text_validate_lastname;
                    }
                    return null;
                  },
                ),
                // AppSpacing.gapH20,
                // _buildTextFieldSingle(
                //   controller: birthDayController,
                //   textInputAction: TextInputAction.next,
                //   keyboardType: TextInputType.number,
                //   inputFormatters: [
                //     FilteringTextInputFormatter.digitsOnly,
                //     LengthLimitingTextInputFormatter(10),
                //   ],
                //   hintText: 'Date of Birth',
                //   validator: (value) {
                //     if (value == null || value.trim().isEmpty) {
                //       return 'Please enter your birth day';
                //     }
                //     return null;
                //   },
                // ),
                AppSpacing.gapH20,
                _buildTextFieldDouple(
                    controllerFirst: usernameController,
                    controllerSecond: phoneController,
                    textInputActionFirst: TextInputAction.done,
                    textInputActionSecond: TextInputAction.done,
                    hintTextFirst: context.l10n.profile__username,
                    hintTextSecond: context.l10n.profile__phone_number,
                    validatorFirst: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return context.l10n.text_validate_username;
                      }
                      return null;
                    },
                    readOnlySecond: true
                    // validatorSecond: (value) {
                    //   if (value == null || value.trim().isEmpty) {
                    //     return context.l10n.text_validate_username;
                    //   }
                    //   return null;
                    // },
                    ),
                // _buildTextFieldName(
                //   context.l10n.profile__username,
                //   usernameController,
                //   TextInputAction.next,
                //   hintText: context.l10n.hint_username,
                //   validator: (value) {
                //     if (value == null || value.trim().isEmpty) {
                //       return context.l10n.text_validate_username;
                //     }
                //     return null;
                //   },
                // ),

                AppSpacing.gapH40,
                _buildButtonComplete(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
