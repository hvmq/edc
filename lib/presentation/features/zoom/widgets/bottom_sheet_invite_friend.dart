import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/all.dart';
import '../../../common_widgets/all.dart';
import '../../../resource/gen/assets.gen.dart';
import '../../../resource/styles/app_colors.dart';
import '../../../resource/styles/gaps.dart';
import '../../../resource/styles/text_styles.dart';

class BottomSheetInviteFriend extends StatefulWidget {
  const BottomSheetInviteFriend({super.key});

  @override
  State<BottomSheetInviteFriend> createState() =>
      _BottomSheetInviteFriendState();
}

class _BottomSheetInviteFriendState extends State<BottomSheetInviteFriend> {
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
            color: Colors.white),
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
                        'Send message',
                        style: AppTextStyles.s16w500,
                      ),
                      Assets.icons.iconMeetingSendMessage
                          .image(color: const Color(0xff124984), scale: 2),
                    ],
                  ),
                  AppSpacing.gapH16,
                  const AppDivider(height: 1, color: Color(0xff97B9DE)),
                  AppSpacing.gapH16,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Send by ID',
                            style: AppTextStyles.s16w500,
                          ),
                          Text(
                            'GFDS - SN24 - 2830',
                            style: AppTextStyles.s16w500
                                .copyWith(color: AppColors.subText3),
                          ),
                        ],
                      ),
                      Assets.icons.iconZoomSendId
                          .image(color: const Color(0xff124984), scale: 2),
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
