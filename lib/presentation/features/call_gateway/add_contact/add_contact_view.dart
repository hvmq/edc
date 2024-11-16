import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/all.dart';
import '../../../base/all.dart';
import '../../../common_widgets/all.dart';
import '../../../resource/resource.dart';
import 'add_contact_controller.dart';

class AddContactNumberView extends BaseView<AddContactNumberController> {
  const AddContactNumberView({Key? key}) : super(key: key);

  @override
  Widget buildPage(BuildContext context) {
    return CommonScaffold(
      appBar: CommonAppBar(
        onLeadingPressed: () {
          Get.back();
        },
        titleType: AppBarTitle.none,
        titleWidget: Text(
          controller.isAddContact
              ? context.l10n.text_new_contact
              : context.l10n.text_edit_contact,
          style: AppTextStyles.s18w600.copyWith(color: AppColors.text1),
        ).clickable(() => Get.back()),
        leadingIconColor: AppColors.text1,
        centerTitle: false,
        actions: [
          Text(
            controller.isAddContact
                ? context.l10n.button__create
                : context.l10n.button__change,
            style: AppTextStyles.s16w500.text2Color.copyWith(
              color: AppColors.button5,
            ),
          ).clickable(() {
            if (controller.formKey.currentState!.validate()) {
              if (controller.isAddContact) {
                controller.addContact();
              } else {}
            }
          }),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: AppSpacing.edgeInsetsAll20,
            child: Column(
              children: [
                Row(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          decoration:
                              const BoxDecoration(shape: BoxShape.circle),
                        ),
                        Obx(
                          () => controller.avatarFile.value != null
                              ? Container(
                                  width: 90,
                                  height: 90,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: FileImage(
                                        controller.avatarFile.value!,
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                              : controller.isAddNumber.value
                                  // ? CircleAvatar(
                                  //     backgroundColor: const Color(0xff98B0C9),
                                  //     radius: 40,
                                  //     child: AppIcon(
                                  //       icon: AppIcons.camera,
                                  //       size: 32,
                                  //       color: Colors.white,
                                  //     ),
                                  //   ).clickable(() {
                                  //     controller.getImageFromGallery();
                                  //   })
                                  ? AppIcon(
                                      icon: Assets.images.defaultAvatar,
                                      size: 90,
                                      isCircle: true,
                                    )
                                  : AppCircleAvatar(
                                      size: 90,
                                      url: controller.savedAvatarUrl.value,
                                    ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: CircleAvatar(
                            backgroundColor: const Color(0xff98B0C9),
                            radius: 18,
                            child: AppIcon(
                              icon: AppIcons.camera,
                              size: 20,
                              color: Colors.white,
                            ),
                          ).clickable(() {
                            controller.getImageFromGallery();
                          }),
                        ),
                      ],
                    ),
                    AppSpacing.gapW20,
                    Expanded(
                      child: Column(
                        children: [
                          AppTextField(
                            controller: controller.firstNameController,
                            border: InputBorder.none,
                            fillColor: Colors.white,
                            style: AppTextStyles.s18Base.text1Color,
                            hintText: context.l10n.contact__first_name,
                            hintStyle: AppTextStyles.s16Base.subText2Color,
                            contentPadding: EdgeInsets.zero,
                            // validator: (value) {
                            //   if (value != null && value.isEmpty) {
                            //     return context
                            //         .l10n.field__first_name_error_empty;
                            //   }

                            //   return null;
                            // },
                            // autovalidateMode: AutovalidateMode.always,
                          ),
                          // Obx(
                          //   () => controller.isValidFirstName.value
                          //       ? const SizedBox()
                          //       : AppSpacing.gapH12,
                          // ),
                          AppSpacing.gapH12,
                          const Divider(
                            height: 0.5,
                            color: AppColors.subText2,
                          ),
                          AppSpacing.gapH12,
                          AppTextField(
                            controller: controller.lastNameController,
                            border: InputBorder.none,
                            style: AppTextStyles.s18Base.text1Color,
                            fillColor: Colors.white,
                            hintText: context.l10n.contact__last_name,
                            hintStyle: AppTextStyles.s16Base.subText2Color,
                            contentPadding: EdgeInsets.zero,
                            // autovalidateMode: AutovalidateMode.always,
                            // validator: (value) {
                            //   if (value != null && value.isEmpty) {
                            //     return context
                            //         .l10n.field__last_name_error_empty;
                            //   }

                            //   return null;
                            // },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                AppSpacing.gapH20,
                Row(
                  children: [
                    if (controller.getIsShowPhone())
                      AppIcon(
                        icon: Assets.images.phoneAddContact,
                        size: 20,
                      ),
                    AppSpacing.gapW8,
                    Text(
                      context.l10n.field_phone__label,
                      style: AppTextStyles.s16w500.subText2Color.copyWith(
                        color: !controller.getIsShowPhone()
                            ? AppColors.text2
                            : null,
                      ),
                    ),
                    // AppIcon(icon: AppIcons.plus),
                    AppSpacing.gapW8,
                    Expanded(
                      child: Form(
                        key: controller.formKey,
                        child: Obx(
                          () => AppTextField(
                            controller: controller.inputEnterPhoneController,
                            border: InputBorder.none,
                            style: AppTextStyles.s18Base.text1Color.copyWith(
                              color: !controller.getIsShowPhone()
                                  ? AppColors.text2
                                  : null,
                            ),
                            fillColor: Colors.white,
                            enabled: controller.isAddNumber.value,
                            contentPadding: EdgeInsets.zero,
                            autofocus: controller.isAddNumber.value,
                            // autovalidateMode: AutovalidateMode.always,
                            // validator: (value) {
                            //   if (value != null && value.isEmpty) {
                            //     return context
                            //         .l10n.field__last_name_error_empty;
                            //   }

                            //   return null;
                            // },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (!controller.isAddContact)
            Container(
              padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
              width: double.infinity,
              color: AppColors.grey11,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  l10n.contact__delete_contact,
                  style:
                      AppTextStyles.s16w500.copyWith(color: AppColors.negative),
                ),
              ),
            ).clickable(() {
              controller.deleteContact();
            }),
        ],
      ),
    );
  }
}
