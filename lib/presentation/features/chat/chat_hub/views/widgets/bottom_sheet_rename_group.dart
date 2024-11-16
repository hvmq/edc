import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../../core/all.dart';
import '../../../../../common_widgets/all.dart';
import '../../../../../resource/resource.dart';

class BottomSheetRenameGroup extends StatefulWidget {
  const BottomSheetRenameGroup({super.key});

  @override
  State<BottomSheetRenameGroup> createState() => _BottomSheetRenameGroupState();
}

class _BottomSheetRenameGroupState extends State<BottomSheetRenameGroup> {
  int? currentIndex;
  TextEditingController editNameController = TextEditingController();
  Widget _buildTextFieldEditName() {
    return Padding(
      padding: EdgeInsets.only(bottom: 15.h),
      child: AppTextField(
        controller: editNameController,
        fillColor: Colors.transparent,
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.border2, width: 0.5),
          borderRadius: BorderRadius.all(Radius.circular(100)),
        ),
        label: Get.context!.l10n.edit_group_name_label,
        hintText: Get.context!.l10n.edit_group_name_hint,
        hintStyle: AppTextStyles.s16w400.copyWith(color: AppColors.border2),

        textInputAction: TextInputAction.done,

        // onChanged: (value) {
        //   if (controller.appController.lastLoggedUser != null &&
        //       controller.validatePassword(value).isEmpty) {
        //     controller.setDisableLoginBtn = false;
        //   } else if (controller.validatePassword(value).isEmpty &&
        //       (controller
        //               .validateEmail(controller.emailController.text)
        //               .isEmpty ||
        //           controller.phoneController.text.isNotEmpty)) {
        //     controller.setDisableLoginBtn = false;
        //   }
        // },
      ),
    );
  }

  Widget _buildAppbar() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(
            width: 40,
          ),
          Text(
            Get.context!.l10n.edit_name_title,
            style: AppTextStyles.s20w700,
          ),
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Text(
              Get.context!.l10n.button__cancel,
              style: AppTextStyles.s16Base.toColor(AppColors.button6),
            ),
          ),
        ],
      );

  Widget _buildSaveButton() => AppButton.secondary(
        label: Get.context!.l10n.button__save,
        color: AppColors.button5,
        width: double.infinity,
        onPressed: () => Navigator.pop(context),
      );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppSpacing.edgeInsetsAll20,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAppbar(),
          AppSpacing.gapH20,
          _buildTextFieldEditName(),
          const Spacer(),
          _buildSaveButton(),
        ],
      ),
    );
  }
}
