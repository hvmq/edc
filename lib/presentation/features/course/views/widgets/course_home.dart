import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../core/all.dart';
import '../../../../common_widgets/app_icon.dart';
import '../../../../resource/styles/app_colors.dart';
import '../../../../resource/styles/gaps.dart';
import '../../../../resource/styles/text_styles.dart';
import '../../../../routing/routers/app_pages.dart';

class CourseHome extends StatefulWidget {
  const CourseHome({super.key});

  @override
  State<CourseHome> createState() => _CourseHomeState();
}

class _CourseHomeState extends State<CourseHome> {
  @override
  Widget build(BuildContext context) {
    Widget courseItem() {
      return Container(
        width: 0.35.sw,
        margin: const EdgeInsets.only(right: 12, top: 20, bottom: 20),
        decoration: BoxDecoration(
            color: AppColors.white, borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Expanded(
              flex: 5,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                child: Image.network(
                  'https://th.bing.com/th/id/OIP.ESG0VzWTe6b7tIzBLHDG-AAAAA?rs=1&pid=ImgDetMain',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Intensive Blockchain course',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.s14w700,
                    ),
                    const Spacer(),
                    Text(
                      'Kyo Nguyen',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.s12w600.subText3Color,
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Text(
                          '\$400',
                          style: AppTextStyles.s14w700,
                        ),
                        AppSpacing.gapW8,
                        Text(
                          '\$400',
                          style: AppTextStyles.s14Base.copyWith(
                            decoration: TextDecoration.lineThrough,
                            decorationThickness: 2.0,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ).clickable(() => Get.toNamed(Routes.lesson));
    }

    Widget courseListWidget() {
      return Container(
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Your courses',
                  style: AppTextStyles.s18w700.text5Color,
                ),
                const Spacer(),
                Text(
                  'See all',
                  style: AppTextStyles.s14w500.subText3Color,
                ),
                AppSpacing.gapW4,
                AppIcon(
                  icon: AppIcons.arrowRight,
                  size: 20,
                  color: AppColors.subText3,
                ),
              ],
            ),
            SizedBox(
              height: 250,
              child: ListView.builder(
                  itemCount: 10,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => courseItem()),
            ),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Column(
          children: [
            courseListWidget(),
            AppSpacing.gapH32,
            courseListWidget(),
            AppSpacing.gapH32,
            courseListWidget(),
          ],
        ),
      ),
    );
  }
}
