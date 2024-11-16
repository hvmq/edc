import 'package:flutter/material.dart';

import '../../../base/base_view.dart';
import '../../../common_widgets/all.dart';
import '../../../resource/resource.dart';
import 'course_history_controller.dart';

class CourseHistoryView extends BaseView<CourseHistoryController> {
  const CourseHistoryView({Key? key}) : super(key: key);

  @override
  Widget buildPage(BuildContext context) {
    Widget courseHistoryItem() {
      return Container(
        padding: AppSpacing.edgeInsetsAll20,
        decoration: BoxDecoration(
          color: AppColors.white.withOpacity(1),
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(blurRadius: 2, color: Colors.black.withOpacity(0.25))
          ],
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Intensive Blockchain course',
                        style: AppTextStyles.s14w700,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      AppSpacing.gapH4,
                      Text(
                        'Lesson1 - The process goes in-depth',
                        style: AppTextStyles.s14w400,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                ),
                Container(
                    decoration: BoxDecoration(
                      color: AppColors.label2,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                    child: Text(
                      'In progress',
                      style: AppTextStyles.s12w700
                          .copyWith(fontSize: 10)
                          .copyWith(color: AppColors.white),
                    )),
              ],
            ),
            AppSpacing.gapH16,
            for (int i = 0; i < 4; i++) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '$i. How to goes in-depth',
                    style: AppTextStyles.s14w700,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (i == 0)
                    Text('100%',
                        style: AppTextStyles.s14w700
                            .copyWith(color: const Color(0xff52C91D))),
                  if (i > 0)
                    Text('--',
                        style: AppTextStyles.s14w700
                            .copyWith(color: AppColors.subText2)),
                ],
              )
            ],
            AppSpacing.gapH16,
            const AppDivider(height: 1),
            AppSpacing.gapH16,
            for (int i = 0; i < 3; i++) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '$i. Homework$i',
                    style: AppTextStyles.s14w700,
                  ),
                  Text('--',
                      style: AppTextStyles.s14w700
                          .copyWith(color: AppColors.subText2)),
                ],
              )
            ],
          ],
        ),
      );
    }

    return SingleChildScrollView(
      child: Padding(
        padding: AppSpacing.edgeInsetsAll20,
        child: Column(
          children: [
            for (int i = 0; i < 5; i++) ...[
              courseHistoryItem(),
              AppSpacing.gapH24,
            ],
          ],
        ),
      ),
    );
  }
}
