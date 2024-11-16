import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/all.dart';
import '../../base/all.dart';
import '../../common_widgets/all.dart';
import '../../resource/resource.dart';
import 'all.dart';

class ReportView extends BaseView<ReportController> {
  const ReportView({super.key});

  @override
  Widget buildPage(BuildContext context) {
    return CommonScaffold(
      appBar: CommonAppBar(
        text: controller.type == ReportType.post
            ? l10n.newsfeed__report_title
            : controller.type == ReportType.comment
                ? l10n.language__report_comment
                : l10n.language__report_message,
        titleType: AppBarTitle.text,
        titleTextStyle: AppTextStyles.s20w600,
      ),
      body: Obx(
        () => Column(
          children: [
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverList.builder(
                    itemCount: controller.categories.length,
                    itemBuilder: (context, index) {
                      final category = controller.categories[index];

                      return CheckboxListTile(
                        title: Text(
                          category.name,
                          style: AppTextStyles.s14w400,
                        ),
                        contentPadding: EdgeInsets.zero,
                        value: category.isSelected,
                        onChanged: (value) {
                          controller.changeSelectedCategory(index);
                        },
                        side: const BorderSide(color: AppColors.border2),
                        checkColor: AppColors.text1,
                        fillColor: MaterialStateProperty.resolveWith<Color>(
                          (states) {
                            if (states.contains(MaterialState.selected)) {
                              return AppColors.button5;
                            }

                            return Colors.transparent;
                          },
                        ),
                      );
                    },
                  ),
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          l10n.newsfeed__other_reasons,
                          style: AppTextStyles.s14w400,
                        ),
                        AppSpacing.gapH16,
                        AppTextField(
                          controller: controller.reportController,
                          hintText: l10n.newsfeed__other_reasons_hint,
                          hintStyle: AppTextStyles.s14w400.subText2Color,
                          maxLines: 3,
                          fillColor: Colors.transparent,
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColors.border2, width: 0.5),
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            AppButton.secondary(
              color: AppColors.button5,
              label: controller.type == ReportType.post
                  ? l10n.newsfeed__report_title
                  : controller.type == ReportType.comment
                      ? l10n.language__report_comment
                      : l10n.language__report_message,
              width: double.infinity,
              onPressed: controller.report,
            ).paddingSymmetric(vertical: Sizes.s20),
          ],
        ),
      ).paddingSymmetric(horizontal: Sizes.s20),
    );
  }
}
