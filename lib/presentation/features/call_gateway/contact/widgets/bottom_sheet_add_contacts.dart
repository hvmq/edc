import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/all.dart';
import '../../../../common_widgets/all.dart';
import '../../../../resource/resource.dart';
import '../all.dart';

class BottomSheetAddContacts extends StatelessWidget {
  final ContactController controller;

  const BottomSheetAddContacts({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    Widget buildTextFieldName(
      TextEditingController controller,
      TextInputAction textInputAction, {
      String? Function(String?)? validator,
      Function(String)? onChanged,
      bool readOnly = false,
      String? hintText,
    }) {
      return Padding(
        padding: const EdgeInsets.only(bottom: Sizes.s20),
        child: AppTextField(
          textInputAction: textInputAction,
          controller: controller,
          fillColor: Colors.transparent,
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.border2, width: 0.5),
            borderRadius: BorderRadius.all(Radius.circular(100)),
          ),
          contentPadding: const EdgeInsets.all(Sizes.s16),
          readOnly: readOnly,
          hintText: hintText,
          hintStyle: AppTextStyles.s16w400.copyWith(color: AppColors.border2),
          validator: validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          onChanged: onChanged,
        ),
      );
    }

    Widget buildAppBar() => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
                controller.resetAvatarFile();
              },
              icon: Text(
                context.l10n.button__cancel,
                style: AppTextStyles.s16w600.toColor(AppColors.button6),
              ),
            ),
            Text(
              context.l10n.title_new_contact,
              style: AppTextStyles.s20w600.text1Color,
            ),
            IconButton(
              onPressed: () {
                controller.addContact();
              },
              icon: Text(
                context.l10n.button__done,
                style: AppTextStyles.s16w600.toColor(AppColors.button6),
              ),
            ),
          ],
        );

    Widget buildAvatar({File? avatarFile}) {
      if (avatarFile == null) {
        return AppIcon(
          icon: AppIcons.avatarDefault,
          size: 120,
          isCircle: true,
        );
      }

      return Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: FileImage(
              avatarFile,
            ),
            fit: BoxFit.cover,
          ),
        ),
      );
    }

    Widget buildAddAvatarButton() => IconButton(
          onPressed: () {
            controller.getImageFromGallery();
          },
          icon: Text(
            context.l10n.contact__add_photo,
            style: AppTextStyles.s16w600.toColor(AppColors.button6),
          ),
        );

    return Scaffold(
      body: Obx(
        () => ListView(
          padding: const EdgeInsets.all(Sizes.s16),
          children: [
            buildAppBar(),
            AppSpacing.gapH20,
            buildAvatar(avatarFile: controller.avatarFile.value),
            buildAddAvatarButton(),
            AppSpacing.gapH20,
            buildTextFieldName(
              controller.lastNameController,
              TextInputAction.next,
              hintText: context.l10n.contact__last_name,
            ),
            buildTextFieldName(
              controller.firstNameController,
              TextInputAction.done,
              hintText: context.l10n.contact__first_name,
            ),
            buildTextFieldName(
              controller.inputEnterPhoneController,
              TextInputAction.next,
              hintText: context.l10n.field_phone__label,
            ),
          ],
        ),
      ),
    );
  }
}
