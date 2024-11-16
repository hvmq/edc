import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../core/all.dart';
import '../../../../base/base_view.dart';
import '../../../../common_widgets/common_app_bar.dart';
import '../../../../common_widgets/common_scaffold.dart';
import '../../../../resource/resource.dart';
import '../homework/homework_view.dart';
import 'lesson_homework_controller.dart';

class LessonHomeworkView extends BaseView<LessonHomeworkController> {
  const LessonHomeworkView({Key? key}) : super(key: key);

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
        // text: 'Lesson',
        titleTextStyle: AppTextStyles.s20w600.text5Color,
        leadingIconColor: AppColors.button5,
        backgroundColor: Colors.white,
        elevation: 100,
        actions: const [
          Icon(Icons.message, color: AppColors.button5),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: AppSpacing.edgeInsetsAll20,
          child: Column(
            children: [
              introLessonWidget(),
              AppSpacing.gapH12,
              listLessonWidget(),
              homeworkWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget introLessonWidget() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppSpacing.gapH24,
          Container(
            height: 0.3.sh,
            // width: 0.85.sw,
            padding: AppSpacing.edgeInsetsAll20,
            decoration: BoxDecoration(
                // color: AppColors.white.withOpacity(0.4),
                borderRadius: BorderRadius.circular(6),
                image: const DecorationImage(
                    // opacity: 0.3,
                    fit: BoxFit.cover,
                    image: AssetImage(
                      'assets/images/lession_intro_video.png',
                    ))),
          ),
          AppSpacing.gapH24,
          Text(
            'Lesson 1 - The process goes in- depth',
            style: AppTextStyles.s20w700,
          ),
          AppSpacing.gapH12,
          Text(
            'In this course, students will learn more about the Blockchain industry as well as practical applications, from there they can begin to conquer this field.',
            style: AppTextStyles.s14w400,
          ),
          AppSpacing.gapH12,
        ],
      ),
    );
  }

  Widget listLessonWidget() {
    return Container(
      child: Column(
        children: [
          for (int i = 0; i < 2; i++) ...[
            Stack(
              children: [
                Container(
                  padding: AppSpacing.edgeInsetsAll16,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 2,
                        blurRadius: 4,
                        offset:
                            const Offset(0, 2), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          '$i. Lorem ipsum lesson $i',
                          style: AppTextStyles.s16w700,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        '00:00 - 06:12',
                        style: AppTextStyles.s16w400,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                if (i == 0)
                  Positioned(
                      bottom: 0,
                      child: Container(
                        width: 3,
                        height: 6,
                        color: const Color(0xff52C91D),
                      ))
              ],
            ),
            AppSpacing.gapH12,
          ],
        ],
      ),
    );
  }

  Widget homeworkWidget() {
    return Container(
      padding: AppSpacing.edgeInsetsAll16,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Text('Homework', style: AppTextStyles.s16w700.text5Color),
          ),
          const Icon(
            Icons.arrow_forward_ios,
            size: 12.0, // Kích thước biểu tượng
            color: Colors.black, // Màu biểu tượng
          ),
        ],
      ),
    ).clickable(() {
      Get.to(() => const HomeworkView());
    });
  }
}
