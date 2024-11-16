import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../core/all.dart';
import '../../../../base/base_view.dart';
import '../../../../common_widgets/app_icon.dart';
import '../../../../resource/resource.dart';
import '../../../all.dart';
import '../../../zoom/widgets/join_meeting_view.dart';
import '../../../zoom/widgets/notes_meeting_view.dart';
import '../../../zoom/widgets/start_meeting_view.dart';
import '../../../zoom/zoom_home_controller.dart';
import '../../../zoom/zoom_home_view.dart';
import 'tabbar_all_home.dart';

class BodyHome extends BaseView<HomeController> {
  const BodyHome({super.key});

  @override
  Widget buildPage(BuildContext context) {
    const widthCard = 823;
    const heightCard = 515;
    return SingleChildScrollView(
      // controller: controller.scrollController,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Assets.images.backgroundHome
              .image(fit: BoxFit.fitWidth, width: double.infinity),
          SafeArea(
              child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Obx(
                () => Assets.images.cardNumber
                    .image(
                  // width: 0.8.sw,
                  height: controller.showCard.value
                      ? ((heightCard * 0.8.sw) / widthCard) +
                          ((heightCard * 0.1.sw) / widthCard)
                      : (heightCard * 0.8.sw) / widthCard,
                )
                    .clickable(() {
                  controller.setShowCard(!controller.showCard.value);
                }),
              ),
              Obx(() => Positioned(
                  top: (heightCard * 0.8.sw) / (widthCard * 2) - 30,
                  left: controller.showCard.value
                      ? 0.05.sw + (0.10197578 * 0.9.sw)
                      : 0.1.sw + (0.10197578 * 0.8.sw),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        currentUser.fullName,
                        style: AppTextStyles.s18w700.text2Color,
                      ),
                      AppSpacing.gapH8,
                      if (controller.showCard.value)
                        Text(
                          currentUser.email ?? '',
                          style: AppTextStyles.s14w500.text2Color,
                        ),
                      AppSpacing.gapH8,
                      if (controller.showCard.value)
                        Text(
                          currentUser.phone ?? '',
                          style: AppTextStyles.s14w500.text2Color,
                        ),
                      AppSpacing.gapH12,
                      if (controller.showCard.value)
                        Text(
                          l10n.global__nft_card_free,
                          style: AppTextStyles.s16w700
                              .toColor(const Color(0xffc1ff72)),
                        ),
                    ],
                  ))),
              Obx(
                () => AnimatedPadding(
                  padding: EdgeInsets.only(
                      top: controller.showCard.value
                          ? (heightCard * 0.8.sw) / widthCard + 40
                          : (heightCard * 0.8.sw) / (widthCard * 2)),
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                  child: Row(
                    children: [
                      Expanded(
                          child: Container(
                        height: 50,
                        decoration: const BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30))),
                      )),
                      Container(
                        child: CustomPaint(
                          size: Size(50,
                              50.toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                          painter: RPSCustomPainter(),
                        ),
                      ),
                      Expanded(
                          child: Container(
                        height: 50,
                        decoration: const BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(30))),
                      )),
                    ],
                  ),
                ),
              ),
              Obx(() => AnimatedPadding(
                  padding: EdgeInsets.only(
                      top: controller.showCard.value
                          ? (heightCard * 0.8.sw) / widthCard + 40 + 35
                          : (heightCard * 0.8.sw) / (widthCard * 2) + 35),
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                  child: Container(
                    width: double.infinity,
                    color: Colors.white,
                    padding: AppSpacing.edgeInsetsH20,
                    child: Column(
                      children: [
                        // AppTextField(
                        //   fillColor: Colors.white,
                        //   hintText: 'Search here',
                        //   hintStyle:
                        //       AppTextStyles.s16Base.toColor(AppColors.border3),
                        //   border: OutlineInputBorder(
                        //       borderSide: BorderSide(color: AppColors.border3),
                        //       borderRadius: BorderRadius.circular(100)),
                        //   prefixIcon: AppIcon(
                        //     icon: AppIcons.searchLg,
                        //     color: AppColors.border3,
                        //   ),
                        //   suffixIcon: AppIcon(
                        //     icon: AppIcons.microphone,
                        //     color: AppColors.border3,
                        //   ),
                        // ),
                        // SizedBox(
                        //     height: 40 +
                        //         (280 * (1.sw - 40)) / 740 +
                        //         20 +
                        //         18 +
                        //         20 +
                        //         250 +
                        //         20 +
                        //         18 +
                        //         20 +
                        //         300,
                        //     child: const TabBarHome())
                        groupButton(),
                        const TabbarAllHome()
                      ],
                    ),
                  )))
            ],
          )),
        ],
      ),
    );
  }

  Widget groupButton() {
    final List<GroupButtonItem> groupButtons = [
      GroupButtonItem(
        title: l10n.zoom__new_meeting,
        color: const Color(0xff124984),
        onTap: () {
          Get.lazyPut(() => ZoomHomeController(), fenix: true);
          Get.to(() => const StartMeetingView());
        },
        icon: Assets.icons.iconZoom,
      ),
      GroupButtonItem(
          title: l10n.zoom__join,
          color: const Color(0xff3A9A07),
          onTap: () {
            Get.lazyPut(() => ZoomHomeController(), fenix: true);
            Get.to(() => const JoinMeetingView());
          },
          icon: Assets.icons.iconZoomStart),
      GroupButtonItem(
          title: l10n.zoom__notes,
          color: const Color(0xff601284),
          onTap: () {
            Get.lazyPut(() => ZoomHomeController(), fenix: true);
            Get.to(() => const NotesMeetingView());
          },
          icon: Assets.icons.iconZoomNote),
    ];

    return Container(
      padding: const EdgeInsets.fromLTRB(0, 20, 24, 0),
      width: Get.width,
      child: Row(
        children: [
          ...groupButtons.map((item) {
            return Container(
              margin: const EdgeInsets.only(right: 20),
              child: Column(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                    decoration: BoxDecoration(
                        color: item.color,
                        borderRadius: BorderRadius.circular(100)),
                    child: AppIcon(
                      icon: item.title == l10n.zoom__new_meeting
                          ? Assets.icons.newMeeting
                          : item.title == l10n.zoom__notes
                              ? Assets.icons.notes
                              : Assets.icons.joinMeeting,
                      color: AppColors.white,
                    ),
                  ).clickable(() {
                    item.onTap();
                  }),
                  const SizedBox(height: 4),
                  Text(
                    item.title,
                    style: AppTextStyles.s14w500,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          })
        ],
      ),
    );
  }
}

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Circle Copy

    final Paint paintFill0 = Paint()
      ..color = AppColors.white
      ..style = PaintingStyle.fill
      ..strokeWidth = size.width * 0.01
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    final Path path_0 = Path();
    path_0.moveTo(size.width * -0.0040000, size.height * -0.0040000);
    path_0.cubicTo(
        size.width * -0.0050000,
        size.height * 0.3430000,
        size.width * 0.2990000,
        size.height * 0.4990000,
        size.width * 0.5000000,
        size.height * 0.4960000);
    path_0.cubicTo(
        size.width * 0.8490000,
        size.height * 0.4990000,
        size.width * 1.0110000,
        size.height * 0.1890000,
        size.width * 1.0040000,
        size.height * -0.0080000);
    path_0.quadraticBezierTo(size.width * 1.0040000, size.height * 0.1170000,
        size.width * 1.0040000, size.height * 0.4960000);
    path_0.lineTo(size.width * -0.0080000, size.height * 0.4960000);
    path_0.quadraticBezierTo(size.width * -0.0040000, size.height * 0.3710000,
        size.width * -0.0040000, size.height * -0.0040000);
    path_0.close();

    canvas.drawPath(path_0, paintFill0);

    // Layer 1

    final Paint paintFill1 = Paint()
      ..color = AppColors.white
      ..style = PaintingStyle.fill
      ..strokeWidth = size.width * 0.01
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    final Path path_1 = Path();
    path_1.moveTo(size.width * -0.0080000, size.height * 0.4880000);
    path_1.lineTo(size.width * 1.0040000, size.height * 0.4880000);
    path_1.lineTo(size.width * 1.0040000, size.height * 1.0060000);
    path_1.lineTo(size.width * -0.0080000, size.height * 1.0020000);

    canvas.drawPath(path_1, paintFill1);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
