import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/all.dart';
import '../../../common_widgets/all.dart';
import '../../../resource/styles/app_colors.dart';
import '../../../resource/styles/gaps.dart';
import '../../../resource/styles/text_styles.dart';

class EditMeetingView extends StatefulWidget {
  const EditMeetingView({super.key});

  @override
  State<EditMeetingView> createState() => _EditMeetingViewState();
}

class _EditMeetingViewState extends State<EditMeetingView> {
  bool isEnablePeristentChat = false;
  bool isEnableAllowBeforeMeetingCreator = false;
  bool isEnableAllowCreatorSetPass = false;
  bool isEnableActivateWaitingRoom = false;
  bool isEnableVideoStorage = false;

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      hideKeyboardWhenTouchOutside: true,
      appBar: CommonAppBar(
        titleType: AppBarTitle.text,
        // text: context.l10n.button__sign_up,
        text: 'Personal meeting ID',
        titleTextStyle: AppTextStyles.s20w600.text5Color,
        leadingIconColor: AppColors.button5,
        actions: [
          Text(
            'Save',
            style: AppTextStyles.s16w500.copyWith(color: AppColors.subText3),
          ).clickable(() {
            Get.back();
          })
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: AppSpacing.edgeInsetsAll20,
          child: Column(
            children: [
              peronalMeetingWidget(),
              AppSpacing.gapH28,
              securityWidget(),
              AppSpacing.gapH28,
              optionWidget(),
              AppSpacing.gapH28,
            ],
          ),
        ),
      ),
    );
  }

  Widget peronalMeetingWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Personal meeting ID (PMI)',
          style: AppTextStyles.s16w600.copyWith(color: AppColors.text8),
        ),
        AppSpacing.gapH28,
        Container(
          padding: AppSpacing.edgeInsetsAll20,
          width: Get.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(11), color: Colors.white),
          child: Text(
            'GFDS - SN24 - 2830',
            style: AppTextStyles.s16w500.copyWith(color: AppColors.subText3),
          ),
        ),
      ],
    );
  }

  Widget optionWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Meeting options',
          style: AppTextStyles.s16w600.copyWith(color: AppColors.text8),
        ),
        AppSpacing.gapH28,
        Container(
          padding: AppSpacing.edgeInsetsAll20,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(11), color: Colors.white),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Save video',
                    style: AppTextStyles.s16w500,
                  ),
                  CupertinoSwitch(
                      activeColor: AppColors.button5,
                      trackColor: AppColors.subText3,
                      value: isEnablePeristentChat,
                      onChanged: (value) {
                        setState(() {
                          isEnablePeristentChat = value;
                        });
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
                    'Participant video turned on',
                    style: AppTextStyles.s16w500,
                  ),
                  CupertinoSwitch(
                      activeColor: AppColors.button5,
                      trackColor: AppColors.subText3,
                      value: isEnableAllowBeforeMeetingCreator,
                      onChanged: (value) {
                        setState(() {
                          isEnableAllowBeforeMeetingCreator = value;
                        });
                      }),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget securityWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Security',
          style: AppTextStyles.s16w600.copyWith(color: AppColors.text8),
        ),
        AppSpacing.gapH28,
        Container(
          padding: AppSpacing.edgeInsetsAll20,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(11), color: Colors.white),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Request a meeting password',
                    style: AppTextStyles.s16w500,
                  ),
                  CupertinoSwitch(
                      activeColor: AppColors.button5,
                      trackColor: AppColors.subText3,
                      value: isEnablePeristentChat,
                      onChanged: (value) {
                        setState(() {
                          isEnablePeristentChat = value;
                        });
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
                    'Password',
                    style: AppTextStyles.s16w500,
                  ),
                  CupertinoSwitch(
                      activeColor: AppColors.button5,
                      trackColor: AppColors.subText3,
                      value: isEnableAllowBeforeMeetingCreator,
                      onChanged: (value) {
                        setState(() {
                          isEnableAllowBeforeMeetingCreator = value;
                        });
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
                    'Activate the waiting room',
                    style: AppTextStyles.s16w500,
                  ),
                  CupertinoSwitch(
                      activeColor: AppColors.button5,
                      trackColor: AppColors.subText3,
                      value: isEnableAllowCreatorSetPass,
                      onChanged: (value) {
                        setState(() {
                          isEnableAllowCreatorSetPass = value;
                        });
                      }),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
