import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:styled_text/tags/styled_text_tag_action.dart';
import 'package:styled_text/widgets/styled_text.dart';

import '../../../../../../core/all.dart';
import '../../../../../common_widgets/all.dart';
import '../../../../../resource/resource.dart';

class BottomSheetAutoDelete extends StatefulWidget {
  const BottomSheetAutoDelete({super.key});

  @override
  State<BottomSheetAutoDelete> createState() => _BottomSheetAutoDeleteState();
}

class _BottomSheetAutoDeleteState extends State<BottomSheetAutoDelete> {
  int? currentIndex;
  Widget _buildChooseItem(String text, int index) => Column(
        children: [
          Row(
            children: [
              Text(
                text,
                style: AppTextStyles.s16Base,
              ),
              const Spacer(),
              AppCheckBox(
                value: currentIndex == index,
                onChanged: (p0) {
                  setState(() {
                    currentIndex = index;
                  });
                },
              ),
            ],
          ),
          const Divider(
            color: AppColors.border2,
            thickness: 0.5,
            height: 0.5,
          ),
        ],
      );

  Widget _buildAppbar() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: AppIcon(
              icon: AppIcons.arrowLeft,
            ),
          ),
          Text(
            Get.context!.l10n.auto_delete_appbar,
            style: AppTextStyles.s20w700,
          ),
          const SizedBox(
            width: 20,
          ),
        ],
      );

  Widget _buildImage() =>
      Center(child: Assets.images.autoDeleteMess.image(scale: 2));

  Widget _buildTextTitle() => Text(
        Get.context!.l10n.auto_delete_title,
        style: AppTextStyles.s20w700.toColor(AppColors.button5),
      );
  Widget _buildTextSetting() => StyledText(
        text: Get.context!.l10n.auto_delete_description,
        style: AppTextStyles.s14w400.text1Color,
        tags: {
          'apply': StyledTextActionTag(
            (_, __) {},
            style: AppTextStyles.s14w400.toColor(AppColors.button5),
          ),
        },
      );

  Widget _buildButtonChoose() => AppButton.secondary(
        color: AppColors.button5,
        label: Get.context!.l10n.choose,
        width: double.infinity,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAppbar(),
            AppSpacing.gapH20,
            _buildImage(),
            AppSpacing.gapH20,
            _buildTextTitle(),
            AppSpacing.gapH20,
            _buildChooseItem(context.l10n.text_off, 0),
            _buildChooseItem(context.l10n.text_after_1_hour, 1),
            _buildChooseItem(context.l10n.text_after_24_hour, 2),
            _buildChooseItem(context.l10n.text_after_7_day, 3),
            AppSpacing.gapH20,
            _buildTextSetting(),
            const Spacer(),
            _buildButtonChoose(),
            AppSpacing.gapH32,
          ],
        ),
      ),
    );
  }
}
