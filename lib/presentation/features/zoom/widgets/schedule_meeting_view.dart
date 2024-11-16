import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../core/all.dart';
import '../../../base/base_view.dart';
import '../../../common_widgets/all.dart';
import '../../../resource/styles/app_colors.dart';
import '../../../resource/styles/gaps.dart';
import '../../../resource/styles/text_styles.dart';
import '../zoom_home_controller.dart';
import 'edit_meeting_view.dart';

class ScheduleMeetingView extends BaseView<ZoomHomeController> {
  const ScheduleMeetingView({super.key});

  @override
  Widget buildPage(BuildContext context) {
    return CommonScaffold(
      hideKeyboardWhenTouchOutside: true,
      appBar: CommonAppBar(
        titleType: AppBarTitle.text,
        // text: context.l10n.button__sign_up,
        text: 'Schedule',
        titleTextStyle: AppTextStyles.s20w600.text5Color,
        leadingIconColor: AppColors.button5,
        actions: [
          Text(
            'Save',
            style: AppTextStyles.s16w500.copyWith(color: AppColors.subText3),
          ).clickable(() {
            Get.to(() => const EditMeetingView());
          })
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: AppSpacing.edgeInsetsAll20,
          child: Column(
            children: [
              settingTimeWidget(context),
              AppSpacing.gapH28,
              // optionWidget(),
              AppSpacing.gapH28,
            ],
          ),
        ),
      ),
    );
  }

  Widget settingTimeWidget(BuildContext context) {
    String formattedTime(DateTime dateTime) {
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final dateToFormat =
          DateTime(dateTime.year, dateTime.month, dateTime.day);

      if (dateToFormat == today) {
        return '${DateFormat('HH:mm').format(dateTime)} Today';
      } else {
        return DateFormat('HH:mm E, MMM d').format(dateTime);
      }
    }

    return Container(
      padding: AppSpacing.edgeInsetsAll20,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border2, width: 0.5),
        borderRadius: BorderRadius.circular(11),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTextField(
            hintText: '${currentUser.fullName} meeting',
            hintStyle: AppTextStyles.s16w500.subText3Color,
            border: InputBorder.none,
            fillColor: Colors.transparent,
            contentPadding: EdgeInsets.zero,
          ),
          AppSpacing.gapH16,
          const AppDivider(height: 1, color: Color(0xff97B9DE)),
          AppSpacing.gapH16,
          AppTextField(
            hintText: 'Description',
            hintStyle: AppTextStyles.s16w500.subText3Color,
            border: InputBorder.none,
            fillColor: Colors.transparent,
            contentPadding: EdgeInsets.zero,
          ),
          AppSpacing.gapH16,
          const AppDivider(height: 1, color: Color(0xff97B9DE)),
          AppSpacing.gapH16,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Start',
                style: AppTextStyles.s16w500,
              ),
              Row(
                children: [
                  Obx(
                    () => Text(
                      controller.startTimeSchedule.value,
                      style: AppTextStyles.s16w500
                          .copyWith(color: AppColors.subText3),
                    ),
                  ),
                  AppSpacing.gapW10,
                  const Icon(
                      size: 20,
                      Icons.arrow_forward_ios,
                      color: AppColors.subText3),
                ],
              ),
            ],
          ).clickable(() {
            showModalBottomSheet(
              context: context,
              builder: (context) => Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20, right: 20),
                      child: Text(
                        'Done',
                        style: AppTextStyles.s16w600.text5Color,
                      ),
                    ).clickable(() {
                      Get.back();
                    }),
                    Expanded(
                      child: CupertinoDatePicker(
                        showDayOfWeek: true,
                        minimumDate: DateTime.now(),
                        dateOrder: DatePickerDateOrder.dmy,
                        onDateTimeChanged: (va) {
                          controller.startTimeSchedule.value =
                              formattedTime(va);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
          // AppSpacing.gapH16,
          // const AppDivider(height: 1, color: Color(0xff97B9DE)),
          // AppSpacing.gapH16,
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Text(
          //       'Time',
          //       style: AppTextStyles.s16w500,
          //     ),
          //     Row(
          //       children: [
          //         Text(
          //           '30 minutes',
          //           style: AppTextStyles.s16w500
          //               .copyWith(color: AppColors.subText3),
          //         ),
          //         AppSpacing.gapW10,
          //         const Icon(
          //             size: 20,
          //             Icons.arrow_forward_ios,
          //             color: AppColors.subText3),
          //       ],
          //     ),
          //   ],
          // ),
          // AppSpacing.gapH16,
          // const AppDivider(height: 1, color: Color(0xff97B9DE)),
          // AppSpacing.gapH16,
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Text(
          //       'Time zone',
          //       style: AppTextStyles.s16w500,
          //     ),
          //     Row(
          //       children: [
          //         Text(
          //           'Asia/Ho Chi Minh',
          //           style: AppTextStyles.s16w500
          //               .copyWith(color: AppColors.subText3),
          //         ),
          //         AppSpacing.gapW10,
          //         const Icon(
          //             size: 20,
          //             Icons.arrow_forward_ios,
          //             color: AppColors.subText3),
          //       ],
          //     ),
          //   ],
          // ),
          // AppSpacing.gapH16,
          // const AppDivider(height: 1, color: Color(0xff97B9DE)),
          // AppSpacing.gapH16,
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Text(
          //       'Repeat',
          //       style: AppTextStyles.s16w500,
          //     ),
          //     Row(
          //       children: [
          //         Text(
          //           'Never',
          //           style: AppTextStyles.s16w500
          //               .copyWith(color: AppColors.subText3),
          //         ),
          //         AppSpacing.gapW10,
          //         const Icon(
          //             size: 20,
          //             Icons.arrow_forward_ios,
          //             color: AppColors.subText3),
          //       ],
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }

  // Widget optionWidget() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Container(
  //         padding: AppSpacing.edgeInsetsAll20,
  //         decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(11), color: Colors.white),
  //         child: Column(
  //           children: [
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 Text(
  //                   'Turn on persistent meeting chat',
  //                   style: AppTextStyles.s16w500,
  //                 ),
  //                 CupertinoSwitch(
  //                     activeColor: AppColors.button5,
  //                     trackColor: AppColors.subText3,
  //                     value: isEnablePeristentChat,
  //                     onChanged: (value) {
  //                       setState(() {
  //                         isEnablePeristentChat = value;
  //                       });
  //                     }),
  //               ],
  //             ),
  //             AppSpacing.gapH16,
  //             const AppDivider(height: 1, color: Color(0xff97B9DE)),
  //             AppSpacing.gapH16,
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 Text(
  //                   'Allow participants to enter\nbefore the meeting creator',
  //                   style: AppTextStyles.s16w500,
  //                 ),
  //                 CupertinoSwitch(
  //                     activeColor: AppColors.button5,
  //                     trackColor: AppColors.subText3,
  //                     value: isEnableAllowBeforeMeetingCreator,
  //                     onChanged: (value) {
  //                       setState(() {
  //                         isEnableAllowBeforeMeetingCreator = value;
  //                       });
  //                     }),
  //               ],
  //             ),
  //             AppSpacing.gapH16,
  //             const AppDivider(height: 1, color: Color(0xff97B9DE)),
  //             AppSpacing.gapH16,
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 Text(
  //                   'Allows the meeting creator to\nset a passcode for the room',
  //                   style: AppTextStyles.s16w500,
  //                 ),
  //                 CupertinoSwitch(
  //                     activeColor: AppColors.button5,
  //                     trackColor: AppColors.subText3,
  //                     value: isEnableAllowCreatorSetPass,
  //                     onChanged: (value) {
  //                       setState(() {
  //                         isEnableAllowCreatorSetPass = value;
  //                       });
  //                     }),
  //               ],
  //             ),
  //             AppSpacing.gapH16,
  //             const AppDivider(height: 1, color: Color(0xff97B9DE)),
  //             AppSpacing.gapH16,
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 Text(
  //                   'Activate the waiting room',
  //                   style: AppTextStyles.s16w500,
  //                 ),
  //                 CupertinoSwitch(
  //                     activeColor: AppColors.button5,
  //                     trackColor: AppColors.subText3,
  //                     value: isEnableActivateWaitingRoom,
  //                     onChanged: (value) {
  //                       setState(() {
  //                         isEnableActivateWaitingRoom = value;
  //                       });
  //                     }),
  //               ],
  //             ),
  //             AppSpacing.gapH16,
  //             const AppDivider(height: 1, color: Color(0xff97B9DE)),
  //             AppSpacing.gapH16,
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 Text(
  //                   'Video storage',
  //                   style: AppTextStyles.s16w500,
  //                 ),
  //                 CupertinoSwitch(
  //                     activeColor: AppColors.button5,
  //                     trackColor: AppColors.subText3,
  //                     value: isEnableVideoStorage,
  //                     onChanged: (value) {
  //                       setState(() {
  //                         isEnableVideoStorage = value;
  //                       });
  //                     }),
  //               ],
  //             ),
  //           ],
  //         ),
  //       ),
  //     ],
  //   );
  // }
}
