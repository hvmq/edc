import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/all.dart';
import '../../../../base/base_view.dart';
import '../../../../common_widgets/shimmer.dart';
import '../../../../resource/resource.dart';
import '../../controllers/home_controller.dart';
import 'blog_detail_view.dart';

class TabbarAllHome extends BaseView<HomeController> {
  const TabbarAllHome({super.key});

  @override
  Widget buildPage(BuildContext context) {
    return Obx(() => Column(
          children: [
            AppSpacing.gapH20,
            Assets.images.bannerHome
                .image(width: double.infinity)
                .clickable(() {}),
            AppSpacing.gapH20,
            blogsWidget(context),
          ],
        ));
  }

  Widget blogsWidget(BuildContext context) {
    List<dynamic> blogs = [];
    try {
      final currentLanguage = Localizations.localeOf(context).toString();
      blogs = controller.blogData.value[currentLanguage];
    } catch (e) {
      LogUtil.e(e.toString());
    }

    if (blogs.isEmpty) {
      return Column(
        children: [
          blogWidgetLoading(context),
          AppSpacing.gapH8,
          blogWidgetLoading(context),
          AppSpacing.gapH8,
          blogWidgetLoading(context),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.blog__popular_blogs,
          style: AppTextStyles.s18w700.text5Color,
        ),
        ...blogs.toList().map((blog) {
          return Container(
            height: 160,
            margin: const EdgeInsets.only(right: 12, top: 20, bottom: 20),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: Colors.black
                      .withOpacity(0.25), // Shadow color with 25% opacity
                  blurRadius: 4, // Blur radius
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(14),
                    bottomLeft: Radius.circular(14),
                  ),
                  child: Image.network(
                    blog['image'],
                    fit: BoxFit.cover,
                    height: 160,
                    width: 160,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          blog['title'],
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.s14w700,
                        ),
                        const Spacer(),
                        Text(
                          blog['discrible'],
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.s14Base.subText3Color,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ).clickable(() {
            Get.to(() => BlogDetailView(
                  blog: blog,
                ));
          });
        }),
      ],
    );
  }

  Widget buildContainer(
          double height, double width, bool isCircle, double radius) =>
      Container(
        height: height,
        width: width,
        decoration: isCircle
            ? BoxDecoration(
                shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
                color: AppColors.white,
              )
            : BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(radius)),
      );

  Widget loadingWidget(Widget child) {
    return Shimmer.fromColors(
      baseColor: AppColors.background6,
      highlightColor: AppColors.background6.withOpacity(0.5),
      child: child,
    );
  }

  Widget blogWidgetLoading(BuildContext context) {
    return Container(
      height: 160,
      margin: const EdgeInsets.only(right: 12, top: 20, bottom: 20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppColors.background6,
        ),
        // boxShadow: [
        //   BoxShadow(
        //     color:
        //         Colors.black.withOpacity(0.25), // Shadow color with 25% opacity
        //     blurRadius: 4, // Blur radius
        //   ),
        // ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          loadingWidget(
            Container(
              height: 160,
              width: 160,
              decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(14),
                  bottomLeft: Radius.circular(14),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  loadingWidget(buildContainer(60, 500, false, 10)),
                  const Spacer(),
                  loadingWidget(buildContainer(40, 500, false, 10)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
