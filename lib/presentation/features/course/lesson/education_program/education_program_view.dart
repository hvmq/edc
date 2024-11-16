import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/all.dart';
import '../../../../base/base_view.dart';
import '../../../../common_widgets/common_app_bar.dart';
import '../../../../common_widgets/common_scaffold.dart';
import '../../../../resource/resource.dart';
import '../lesson_homework/lesson_homework_view.dart';
import 'education_program_controller.dart';

class EducationProgramView extends BaseView<EducationProgramController> {
  const EducationProgramView({Key? key}) : super(key: key);

  @override
  Widget buildPage(BuildContext context) {
    return CommonScaffold(
      hideKeyboardWhenTouchOutside: true,
      // appBar: AppBar(
      //   leading: AppIcon(
      //     padding: const EdgeInsets.only(left: Sizes.s20),
      //     icon: AppIcons.arrowLeft,
      //     color: AppColors.button5,

      //   ).clickable(() => Get.back),
      //     elevation: 10,
      //     backgroundColor: Colors.transparent,
      // ),
      appBar: CommonAppBar(
        titleType: AppBarTitle.text,
        // text: context.l10n.button__sign_up,
        text: 'Education program',
        titleTextStyle: AppTextStyles.s20w600.text5Color,
        leadingIconColor: AppColors.button5,
        backgroundColor: Colors.white,
        elevation: 100,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: AppSpacing.edgeInsetsAll20,
          child: Column(
            children: [
              for (int i = 0; i < 12; i++) ...[
                Container(
                  // padding: EdgeInsets.only(bottom: 20.h),
                  child: Row(
                    children: [
                      Text(
                        'Lesson $i',
                        style: AppTextStyles.s14w600,
                      ),
                      Expanded(
                        child: Text(
                          ' - The process goes in-depth',
                          style: AppTextStyles.s14w600
                              .copyWith(color: AppColors.text8),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const Icon(
                        Icons.add,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ).clickable(() {
                  Get.to(() => const LessonHomeworkView());
                }),
                AppSpacing.gapH12,
              ],
            ],
          ),
        ),
      ),
    );
  }
}
