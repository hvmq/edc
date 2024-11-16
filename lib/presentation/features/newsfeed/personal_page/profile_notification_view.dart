import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/all.dart';
import '../../../common_widgets/all.dart';
import '../../../resource/styles/styles.dart';

class ProfileNotificationView extends StatefulWidget {
  const ProfileNotificationView({super.key});

  @override
  State<ProfileNotificationView> createState() =>
      _ProfileNotificationViewState();
}

class _ProfileNotificationViewState extends State<ProfileNotificationView> {
  bool isEnableJoinMeeting = false;
  bool isEnableCamera = false;
  bool isEnableNoAudio = false;
  bool isEnableRecordMeeting = false;

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      hideKeyboardWhenTouchOutside: true,
      appBar: CommonAppBar(
        titleType: AppBarTitle.text,
        // text: context.l10n.button__sign_up,
        text: 'Notifications',
        titleTextStyle: AppTextStyles.s20w600.text5Color,
        leadingIconColor: AppColors.button5,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: AppSpacing.edgeInsetsAll20,
          child: Column(
            children: [
              messageNotificationWidget(),
              AppSpacing.gapH28,
              inAppNotificationWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget messageNotificationWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Message Notifications',
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
                  const Icon(Icons.person, color: AppColors.button5),
                  AppSpacing.gapW12,
                  Text(
                    'Private chat',
                    style: AppTextStyles.s16w500,
                  ),
                  const Spacer(),
                  CupertinoSwitch(
                      activeColor: AppColors.button5,
                      trackColor: AppColors.subText3,
                      value: isEnableCamera,
                      onChanged: (value) {
                        setState(() {
                          isEnableCamera = value;
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
                  const Icon(Icons.people, color: Color(0xff319F43)),
                  AppSpacing.gapW12,
                  Text(
                    'Group chat',
                    style: AppTextStyles.s16w500,
                  ),
                  const Spacer(),
                  CupertinoSwitch(
                    activeColor: AppColors.button5,
                    trackColor: AppColors.subText3,
                    value: isEnableNoAudio,
                    onChanged: (value) {
                      setState(() {
                        isEnableNoAudio = value;
                      });
                    },
                  ),
                ],
              ),
              AppSpacing.gapH16,
              const AppDivider(height: 1, color: Color(0xff97B9DE)),
              AppSpacing.gapH16,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(
                    Icons.call,
                    color: Color(0xff9C40D4),
                    size: 24,
                  ),
                  // Assets.icons.phone
                  //     .svg(width: 30, height: 30, color: Colors.amber),
                  AppSpacing.gapW12,
                  Text(
                    'Call',
                    style: AppTextStyles.s16w500,
                  ),
                  const Spacer(),
                  CupertinoSwitch(
                      activeColor: AppColors.button5,
                      trackColor: AppColors.subText3,
                      value: isEnableRecordMeeting,
                      onChanged: (value) {
                        setState(() {
                          isEnableRecordMeeting = value;
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

  Widget inAppNotificationWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'In-App Notifications',
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
                    'In-App Sounds',
                    style: AppTextStyles.s16w500,
                  ),
                  CupertinoSwitch(
                      activeColor: AppColors.button5,
                      trackColor: AppColors.subText3,
                      value: isEnableCamera,
                      onChanged: (value) {
                        setState(() {
                          isEnableCamera = value;
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
                    'In-App Vibrate ',
                    style: AppTextStyles.s16w500,
                  ),
                  CupertinoSwitch(
                    activeColor: AppColors.button5,
                    trackColor: AppColors.subText3,
                    value: isEnableNoAudio,
                    onChanged: (value) {
                      setState(() {
                        isEnableNoAudio = value;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
