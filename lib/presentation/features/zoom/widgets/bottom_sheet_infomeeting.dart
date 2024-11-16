import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/all.dart';
import '../../../common_widgets/all.dart';
import '../../../resource/gen/assets.gen.dart';
import '../../../resource/styles/app_colors.dart';
import '../../../resource/styles/gaps.dart';
import '../../../resource/styles/text_styles.dart';
import 'bottom_sheet_invite_friend.dart';
import 'edit_meeting_view.dart';

class BottomSheetInfoMeeting extends StatefulWidget {
  const BottomSheetInfoMeeting({super.key});

  @override
  State<BottomSheetInfoMeeting> createState() => _BottomSheetInfoMeetingState();
}

class _BottomSheetInfoMeetingState extends State<BottomSheetInfoMeeting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        padding: AppSpacing.edgeInsetsAll20,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          color: Colors.white,
        ),
        child: Column(
          children: [
            Container(
              width: Get.width * 0.3,
              height: 5,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(180),
                  color: Colors.black),
            ),
            AppSpacing.gapH24,
            Text(
              'ID meetting',
              style: AppTextStyles.s16w500.copyWith(color: AppColors.button5),
            ),
            AppSpacing.gapH8,
            Text(
              'GFDS - SN24 - 2830',
              style: AppTextStyles.s24w500.copyWith(color: AppColors.button5),
            ),
            AppSpacing.gapH16,
            Container(
              padding: AppSpacing.edgeInsetsAll20,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(11),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black
                        .withOpacity(0.25), // Shadow color with 25% opacity
                    blurRadius: 4, // Blur radius
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Start meeting',
                        style: AppTextStyles.s16w500,
                      ),
                      Assets.icons.iconMeetingInfoStart.svg(),
                    ],
                  ),
                  AppSpacing.gapH16,
                  const AppDivider(height: 1, color: Color(0xff97B9DE)),
                  AppSpacing.gapH16,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Invite friends',
                        style: AppTextStyles.s16w500,
                      ),
                      Assets.icons.iconMeetingInviteFriend.svg().clickable(() {
                        Navigator.pop(context);
                        showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (context) => SizedBox(
                              height: Get.height * 0.4,
                              child: const BottomSheetInviteFriend()),
                        );
                      }),
                    ],
                  ),
                  AppSpacing.gapH16,
                  const AppDivider(height: 1, color: Color(0xff97B9DE)),
                  AppSpacing.gapH16,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Edit meeting',
                        style: AppTextStyles.s16w500,
                      ),
                      Assets.icons.iconMeetingEdit.svg().clickable(() {
                        Navigator.pop(context);
                        Get.to(() => const EditMeetingView());
                      }),
                    ],
                  ),
                ],
              ),
            ),
            AppSpacing.gapH32,
            Text(
              'Cancel',
              style: AppTextStyles.s16w500.copyWith(color: AppColors.button5),
            ).clickable(() {
              Navigator.pop(context);
            }),
          ],
        ),
      ),
    );
  }
}
