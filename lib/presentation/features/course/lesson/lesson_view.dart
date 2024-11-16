import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/all.dart';
import '../../../base/base_view.dart';
import '../../../common_widgets/all.dart';
import '../../../resource/resource.dart';
import 'education_program/education_program_view.dart';
import 'lesson_controller.dart';
import 'lesson_homework/lesson_homework_view.dart';

class LessonView extends BaseView<LessonController> {
  const LessonView({Key? key}) : super(key: key);

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
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: AppSpacing.edgeInsetsAll20,
          child: Column(
            children: [
              introLessonWidget(),
              AppSpacing.gapH20,
              listLessonWidget(),
              AppSpacing.gapH20,
              listLessonDetailWidget(context),
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
            'Intensive Blockchain course',
            style: AppTextStyles.s20w700,
          ),
          AppSpacing.gapH12,
          Text(
            'In this course, students will learn more about the Blockchain industry as well as practical applications, from there they can begin to conquer this field.',
            style: AppTextStyles.s14w400,
          ),
          AppSpacing.gapH12,
          Row(
            children: [
              Text(
                'Creator: ',
                style: AppTextStyles.s14w700,
              ),
              Text(
                'Kyo Nguyen',
                style: AppTextStyles.s14w700.copyWith(color: AppColors.button5),
              )
            ],
          ),
          AppSpacing.gapH4,
          Row(
            children: [
              AppIcon(icon: AppIcons.lessonTime),
              AppSpacing.gapW8,
              Text(
                'Last updated ',
                style: AppTextStyles.s14w400,
              ),
              Text('7/2024', style: AppTextStyles.s14w400)
            ],
          ),
          AppSpacing.gapH4,
          Row(
            children: [
              const Icon(Icons.language, color: Colors.black),
              AppSpacing.gapW8,
              Text(
                'English',
                style: AppTextStyles.s14w400,
              )
            ],
          ),
          AppSpacing.gapH12,
          Text(
            '\$400',
            style: AppTextStyles.s20w700.copyWith(fontSize: 40),
          ),
          AppSpacing.gapH12,
          buyButton(),
        ],
      ),
    );
  }

  Widget buyButton() {
    return AppButton.secondary(
      onPressed: () {},
      width: double.infinity,
      label: 'Buy',
      color: AppColors.button5,
      textStyleLabel: AppTextStyles.s18w500.copyWith(
        color: Colors.white,
      ),
    );
  }

  Widget listLessonWidget() {
    return SizedBox(
      height: 0.4.sh,
      width: 1.sw,
      child: Stack(
        children: [
          SizedBox(
            height: 0.5.sh,
          ),
          Positioned(
            bottom: 0,
            child: Container(
              height: 0.37.sh,
              width: 0.9.sw,
              padding: AppSpacing.edgeInsetsAll20,
              decoration: BoxDecoration(
                color: AppColors.white.withOpacity(1),
                borderRadius: BorderRadius.circular(21),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 2, color: Colors.black.withOpacity(0.25))
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              height: 0.4.sh,
              width: 0.85.sw,
              padding: AppSpacing.edgeInsetsAll20,
              decoration: BoxDecoration(
                  color: AppColors.white.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(21),
                  image: const DecorationImage(
                      opacity: 0.3,
                      fit: BoxFit.cover,
                      image: AssetImage(
                        'assets/images/background-profile.png',
                      ))),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              height: 0.37.sh,
              width: 0.9.sw,
              padding: AppSpacing.edgeInsetsAll20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'What you will learn',
                    style: AppTextStyles.s18w700,
                  ),
                  AppSpacing.gapH12,
                  for (int i = 0; i < 5; i++) ...[
                    Container(
                      padding: EdgeInsets.only(bottom: 8.h),
                      child: Row(
                        children: [
                          const Icon(Icons.done),
                          AppSpacing.gapW16,
                          Text(
                            'Lorem ipsum lesson 1 $i',
                            style: AppTextStyles.s14w400,
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget listLessonDetailWidget(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Education program',
            style: AppTextStyles.s18w700,
          ),
          AppSpacing.gapH4,
          Row(
            children: [
              Text(
                '12 lessons',
                style: AppTextStyles.s14w400,
              ),
              Text(
                ' - ',
                style: AppTextStyles.s14w400,
              ),
              Text(
                '3h17m total duration',
                style: AppTextStyles.s14w400,
              )
            ],
          ),
          AppSpacing.gapH20,
          for (int i = 0; i < 6; i++) ...[
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
          AppSpacing.gapH20,
          Center(
            child: Text(
              '6 more lessons',
              style: AppTextStyles.s14w600.copyWith(color: AppColors.text8),
            ),
          ).clickable(() {
            Get.to(() => const EducationProgramView());
          }),
        ],
      ),
    );
  }
}
