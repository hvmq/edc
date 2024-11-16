import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../base/base_view.dart';
import '../../../resource/gen/assets.gen.dart';
import '../../../resource/styles/app_colors.dart';
import '../../../resource/styles/gaps.dart';
import '../../../resource/styles/text_styles.dart';
import 'course_document_controller.dart';

class CourseDocumentView extends BaseView<CourseDocumentController> {
  const CourseDocumentView({Key? key}) : super(key: key);

  @override
  Widget buildPage(BuildContext context) {
    Widget courseDoucmentItem() {
      return Container(
        decoration: BoxDecoration(
          color: AppColors.white.withOpacity(1),
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(blurRadius: 2, color: Colors.black.withOpacity(0.25))
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 0.23.sw,
              height: 0.23.sw,
              decoration: const BoxDecoration(
                color: AppColors.button5,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(14),
                  bottomLeft: Radius.circular(14),
                ),
              ),
              padding: AppSpacing.edgeInsetsAll20,
              // child: const Icon(Icons.document_scanner, color: Colors.white),
              child: Container(
                  padding: AppSpacing.edgeInsetsAll12,
                  child: Assets.icons.document.svg()),
            ),
            Expanded(
              child: Container(
                padding: AppSpacing.edgeInsetsAll20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Blockchain Document 2024. pdf',
                      style: AppTextStyles.s14w700,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      '60,9 MB',
                      style: AppTextStyles.s14w400
                          .copyWith(color: AppColors.subText2),
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Column(
          children: [
            for (int i = 0; i < 8; i++) ...[
              courseDoucmentItem(),
              AppSpacing.gapH12,
            ],
          ],
        ),
      ),
    );
  }
}
