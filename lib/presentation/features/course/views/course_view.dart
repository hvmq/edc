import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../../core/all.dart';
import '../../../base/all.dart';
import '../../../resource/resource.dart';
import '../controllers/course_controller.dart';
import 'widgets/tabbar_course.dart';

class CourseView extends BaseView<CourseController> {
  const CourseView({Key? key}) : super(key: key);

  @override
  Widget buildPage(BuildContext context) {
    return Stack(
      children: [
        Assets.images.backgroundHome
            .image(fit: BoxFit.fitWidth, width: double.infinity),
        SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: AppSpacing.edgeInsetsAll20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Welcome,',
                        style: AppTextStyles.s20w700.text2Color,
                      ),
                      Text(
                        ' ${currentUser.fullName}!',
                        style: AppTextStyles.s20w700
                            .toColor(const Color(0xff699ED6)),
                      ),
                    ],
                  ),
                  Text(
                    'What will you learn today?',
                    style: AppTextStyles.s16Base.text2Color,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                    color: AppColors.white),
                child: const TabBarCourse(),
              ),
            ),
          ],
        ))
      ],
    );
  }
}
