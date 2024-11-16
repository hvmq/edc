import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/all.dart';
import '../../base/base_view.dart';
import '../../common_widgets/all.dart';
import '../../resource/resource.dart';
import '../library/core/utils/resource/assets_constant/image_constant.dart';
import 'widgets/join_meeting_view.dart';
import 'widgets/notes_meeting_view.dart';
import 'widgets/start_meeting_view.dart';
import 'zoom_home_controller.dart';

class ZoomHomeView extends BaseView<ZoomHomeController> {
  const ZoomHomeView({Key? key}) : super(key: key);

  @override
  Widget buildPage(BuildContext context) {
    return CommonScaffold(
      hideKeyboardWhenTouchOutside: true,
      appBar: CommonAppBar(
        titleType: AppBarTitle.none,
        // text: context.l10n.button__sign_up,
        titleWidget: Image.asset(
          ImageConstants.logo,
          width: 104,
        ),
        // text: l10n.zoom__meeting,
        titleTextStyle: AppTextStyles.s20w600.text5Color,
        leadingIconColor: AppColors.button5,
        leadingIcon: LeadingIcon.none,
        centerTitle: false,
        // actions: [
        //   Assets.icons.iconZoomRefresh
        //       .image(color: AppColors.subText3, scale: 2),
        //   AppSpacing.gapW10,
        //   Assets.icons.iconZoomInfo
        //       .image(color: AppColors.subText3, scale: 2)
        //       .clickable(() async {
        //     showModalBottomSheet(
        //       isScrollControlled: true,
        //       context: context,
        //       builder: (context) => SizedBox(
        //           height: Get.height * 0.55,
        //           child: const BottomSheetInfoMeeting()),
        //     );
        //   }),
        // ],
      ),
      body: Column(
        children: [
          AppSpacing.gapH16,
          groupButton(),
          AppSpacing.gapH12,
          refreshHistoryButton(),
          AppSpacing.gapH24,
          zoomList(),
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
      // GroupButtonItem(
      //     title: 'Schedule',
      //     color: const Color(0xff141284),
      //     onTap: () {
      //       Get.to(() => const ScheduleMeetingView());
      //     },
      //     icon: Assets.icons.iconZoomCalendar),
      GroupButtonItem(
          title: l10n.zoom__notes,
          color: const Color(0xff601284),
          onTap: () {
            Get.lazyPut(() => ZoomHomeController(), fenix: true);
            Get.to(() => const NotesMeetingView());
          },
          icon: Assets.icons.iconZoomNote),
      // GroupButtonItem(
      //     title: 'Lesson',
      //     color: const Color(0xff601284),
      //     onTap: () {
      //       Get.toNamed(Routes.lesson);
      //     },
      //     icon: Assets.icons.iconZoomNote),
    ];
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
      width: Get.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ...groupButtons.map((item) {
            return Container(
              constraints: BoxConstraints(maxWidth: 120.w, minWidth: 120.w),
              child: Column(
                children: [
                  Container(
                    height: Get.width * 1 / 6.5,
                    width: Get.width * 1 / 6.5,
                    decoration: BoxDecoration(
                        color: item.color,
                        borderRadius: BorderRadius.circular(12)),
                    child: item.icon.image(color: Colors.white, scale: 2),
                  ).clickable(() {
                    item.onTap();
                  }),
                  const SizedBox(height: 16),
                  Text(
                    item.title,
                    style: AppTextStyles.s14w500,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            );
          })
        ],
      ),
    );
  }

  Widget refreshHistoryButton() {
    return Column(
      children: [
        const AppDivider(color: Color(0xff97B9DE), height: 1),
        Container(
          padding: const EdgeInsets.only(top: 16, bottom: 16),
          decoration: const BoxDecoration(border: Border.symmetric()),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Assets.icons.iconZoomRefreshHistory
                  .image(color: const Color(0xff124984), scale: 2),
              AppSpacing.gapW8,
              Text(
                l10n.zoom__history,
                style: AppTextStyles.s16w500
                    .copyWith(color: const Color(0xff124984)),
              ),
            ],
          ).clickable(() {
            controller.loadMeetingHistory();
          }),
        ),
        const AppDivider(color: Color(0xff97B9DE), height: 1),
      ],
    );
  }

  Widget zoomList() {
    return Expanded(
        child: Padding(
      padding: AppSpacing.edgeInsetsH20,
      child: Obx(() => ListView.builder(
          itemCount: controller.meetingHistoryList.length,
          itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  children: [
                    Assets.icons.iconZoom
                        .image(color: const Color(0xff124984), scale: 2),
                    AppSpacing.gapW10,
                    Text(
                      controller.meetingHistoryList[index].idMeeting,
                      style:
                          AppTextStyles.s16w600.copyWith(color: Colors.black),
                    ),
                    const Spacer(),
                    Text(
                      DateTimeUtil.timeAgo(
                          context,
                          DateTime.parse(
                              controller.meetingHistoryList[index].time)),
                      style: AppTextStyles.s14w500
                          .copyWith(color: AppColors.subText3),
                    ),
                  ],
                ),
              ))),
    ));
  }
}

class GroupButtonItem {
  String title;
  Color color;
  Function onTap;
  AssetGenImage icon;
  GroupButtonItem(
      {required this.title,
      required this.color,
      required this.onTap,
      required this.icon});
}

class MeetingHistoryItem {
  String userId;
  String idMeeting;
  String time;

  MeetingHistoryItem({
    required this.userId,
    required this.idMeeting,
    required this.time,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'idMeeting': idMeeting,
      'time': time,
    };
  }

  // Phương thức chuyển đổi từ Map thành đối tượng
  factory MeetingHistoryItem.fromMap(Map<String, dynamic> map) {
    return MeetingHistoryItem(
      userId: map['userId'] ?? '',
      idMeeting: map['idMeeting'] ?? '',
      time: map['time'] ?? '',
    );
  }
}
