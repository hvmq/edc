import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../core/all.dart';
import '../../../../../../models/all.dart';
import '../../../../common_widgets/app_icon.dart';
import '../../../../common_widgets/circle_avatar.dart';
import '../../../../common_widgets/text_field.dart';
import '../../../../resource/styles/app_colors.dart';
import '../../../../resource/styles/gaps.dart';
import '../../../../resource/styles/text_styles.dart';
import '../call_history_controller.dart';

class ContactInfoHistory extends StatefulWidget {
  final UserContact userContact;
  final bool isAddContact;
  final bool isEditContact;
  final CallHistoryController controller;

  const ContactInfoHistory({
    required this.userContact,
    required this.controller,
    this.isAddContact = false,
    this.isEditContact = false,
    super.key,
  });

  @override
  _ContactInfoHistoryState createState() => _ContactInfoHistoryState();
}

class _ContactInfoHistoryState extends State<ContactInfoHistory> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  String avatarPath = '';

  @override
  void initState() {
    _phoneController.text = widget.userContact.contactPhoneNumber;
    _firstNameController.text = widget.userContact.contactFirstName;
    _lastNameController.text = widget.userContact.contactLastName;
    avatarPath = widget.userContact.contactAvatarPath ?? '';

    super.initState();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.s32,
          vertical: Sizes.s28,
        ),
        child: ListView(
          children: [
            _buildHeader(
              context,
              action: () {
                if (widget.isEditContact) {
                  final UserContact userContact = UserContact(
                    id: widget.userContact.id,
                    contactPhoneNumber: widget.userContact.contactPhoneNumber,
                    contactFirstName: _firstNameController.text,
                    contactLastName: _lastNameController.text,
                    contactAvatarPath: avatarPath.isEmpty ? null : avatarPath,
                  );

                  widget.controller
                      .onEditContactClick(userContact: userContact);
                }
                if (widget.isAddContact) {
                  final UserContact userContact = UserContact(
                    contactPhoneNumber: widget.userContact.contactPhoneNumber,
                    contactFirstName: _firstNameController.text,
                    contactLastName: _lastNameController.text,
                  );

                  widget.controller.onAddContactClick(userContact: userContact);
                }
              },
            ),
            AppSpacing.gapH24,
            _buildAvatar(
              widget.userContact.user?.avatarPath ?? '',
            ),
            _buildTextFieldName(
              label: context.l10n.contact__last_name,
              controller: _lastNameController,
              textInputAction: TextInputAction.next,
            ),
            _buildTextFieldName(
              label: context.l10n.contact__first_name,
              controller: _firstNameController,
              textInputAction: TextInputAction.next,
            ),
            _buildTextFieldName(
              label: context.l10n.field_phone__label,
              controller: _phoneController,
              textInputAction: TextInputAction.done,
              enabled: false,
            ),
            AppSpacing.gapH28,
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(
    BuildContext context, {
    required void Function() action,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          context.l10n.button__cancel,
          style: AppTextStyles.s16w400.subText2Color,
        ).clickable(Get.back),
        Text(
          context.l10n.button__done,
          style: AppTextStyles.s16w400.subText2Color,
        ).clickable(action),
      ],
    );
  }

  Widget _buildAvatar(String avatarUrl) {
    return Align(
      child: AppCircleAvatar(
        url: avatarUrl,
        size: 100,
      ),
    );
  }

  Widget _buildTextFieldName({
    required String label,
    required TextEditingController controller,
    required TextInputAction textInputAction,
    String? Function(String?)? validator,
    Function(String)? onChanged,
    bool enabled = true,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Sizes.s20),
      child: AppTextField(
        enabled: enabled,
        textInputAction: textInputAction,
        controller: controller,
        label: label,
        contentPadding: const EdgeInsets.all(Sizes.s16),
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.border2, width: 0.5),
          borderRadius: BorderRadius.all(Radius.circular(100)),
        ),
        suffixIcon: enabled
            ? AppIcon(
                icon: AppIcons.editLight,
                color: AppColors.subText2,
                padding: const EdgeInsets.only(right: Sizes.s2),
              )
            : null,
        validator: validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onChanged: onChanged,
        fillColor: Colors.white,
      ),
    );
  }

  Widget _buildTextFieldPhone(
    BuildContext context, {
    required UserContact user,
    required TextEditingController textEditingController,
    required String isoCode,
    bool enabled = true,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: Sizes.s16),
          child: SizedBox(
            height: 24,
            child: Text(
              context.l10n.field_phone__label,
              style: AppTextStyles.s16w400.text1Color,
            ),
          ),
        ),
        AppSpacing.gapH4,
        // InternationalPhoneNumberInput(
        //   initialValue: PhoneNumber(isoCode: isoCode),
        //   keyboardAction: TextInputAction.done,
        //   textAlignVertical: TextAlignVertical.top,
        //   spaceBetweenSelectorAndTextField: 0,
        //   textFieldController: textEditingController,
        //   formatInput: false,
        //   // focusNode: controller.phoneFocus,
        //   isEnabled: enabled,
        //   selectorConfig: const SelectorConfig(
        //     selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
        //     leadingPadding: Sizes.s12,
        //     useBottomSheetSafeArea: true,
        //     setSelectorButtonAsPrefixIcon: true,
        //     trailingSpace: false,
        //   ),
        //   selectorTextStyle: AppTextStyles.s16w400.text1Color,
        //   textStyle: AppTextStyles.s16w400.text1Color,
        //   onInputChanged: (value) {
        //     _phoneController.text = value.phoneNumber ?? '';

        //     if (isoCode != value.isoCode) {
        //       isoCode = value.isoCode ?? '';
        //       _phoneController.clear();
        //     }
        //   },
        //   // validator: (value) {
        //   //   if (value != null && value.isEmpty) {
        //   //     return context.l10n.field_phone__error_empty;
        //   //   }
        //   //   if (value != null && int.tryParse(value) == null) {
        //   //     return context.l10n.field_phone__error_invalid;
        //   //   }
        //   //   return null;
        //   // },
        //   errorMessage: context.l10n.field_phone__error_invalid,
        //   autoValidateMode: AutovalidateMode.onUserInteraction,
        //   inputDecoration: InputDecoration(
        //     fillColor: AppColors.subText1.withOpacity(0.2),
        //     filled: true,
        //     hintText: context.l10n.field_phone__label,
        //     contentPadding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
        //     hintStyle: AppTextStyles.s16w400.subText1Color,
        //     errorStyle: AppTextStyles.s14Base.negativeColor,
        //     errorMaxLines: 2,
        //     border: const OutlineInputBorder(
        //       borderSide: BorderSide.none,
        //       borderRadius: BorderRadius.all(Radius.circular(100)),
        //     ),
        //     enabledBorder: const OutlineInputBorder(
        //       borderSide: BorderSide.none,
        //       borderRadius: BorderRadius.all(Radius.circular(100)),
        //     ),
        //     disabledBorder: const OutlineInputBorder(
        //       borderSide: BorderSide.none,
        //       borderRadius: BorderRadius.all(Radius.circular(100)),
        //     ),
        //     focusedBorder: const OutlineInputBorder(
        //       borderSide: BorderSide.none,
        //       borderRadius: BorderRadius.all(Radius.circular(100)),
        //     ),
        //     errorBorder: const OutlineInputBorder(
        //       borderSide: BorderSide.none,
        //       borderRadius: BorderRadius.all(Radius.circular(100)),
        //     ),
        //     suffixIcon: enabled
        //         ? AppIcon(
        //             icon: AppIcons.editLight,
        //             color: AppColors.subText2,
        //             padding: const EdgeInsets.only(right: Sizes.s20),
        //           )
        //         : null,
        //     suffixIconConstraints: const BoxConstraints(
        //       maxWidth: Sizes.s16 + Sizes.s24 + Sizes.s8,
        //     ),
        //   ),
        // ),
      ],
    ).paddingOnly(bottom: Sizes.s16);
  }
}
