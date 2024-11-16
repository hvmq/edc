import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../core/all.dart';
import '../../../../../resource/styles/styles.dart';

class BottomSheetLeaveGroup extends StatelessWidget {
  const BottomSheetLeaveGroup({super.key});

  @override
  Widget build(BuildContext context) {
    Widget buildLeaveButton() => Container(
          padding: AppSpacing.edgeInsetsV16,
          width: double.infinity,
          child: Center(
            child: Text(
              Get.context!.l10n.button_leave,
              style: AppTextStyles.s18Base.toColor(Colors.red),
            ),
          ),
        ).clickable(() {});

    Widget buildCancelButton() => InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            width: double.infinity,
            padding: AppSpacing.edgeInsetsAll16,
            decoration: const BoxDecoration(
              color: AppColors.background8,
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            child: Center(
              child: Text(
                Get.context!.l10n.button__cancel,
                style: AppTextStyles.s18Base,
              ),
            ),
          ),
        );

    return Padding(
      padding: AppSpacing.edgeInsetsAll20,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: AppSpacing.edgeInsetsH16,
            decoration: const BoxDecoration(
              color: AppColors.background8,
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            child: Column(
              children: [
                AppSpacing.gapH16,
                Text(
                  Get.context!.l10n.text_sure_leave,
                  style: AppTextStyles.s18Base.toColor(AppColors.text6),
                ),
                AppSpacing.gapH8,
                const Divider(
                  color: AppColors.border2,
                  thickness: 0.5,
                  height: 0.5,
                ),
                buildLeaveButton(),
              ],
            ),
          ),
          AppSpacing.gapH12,
          buildCancelButton(),
        ],
      ),
    );
  }
}
