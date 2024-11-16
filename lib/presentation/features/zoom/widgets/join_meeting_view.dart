import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jitsi_meet_flutter_sdk/jitsi_meet_flutter_sdk.dart';

import '../../../../core/all.dart';
import '../../../common_controller.dart/all.dart';
import '../../../common_widgets/all.dart';
import '../../../resource/styles/app_colors.dart';
import '../../../resource/styles/gaps.dart';
import '../../../resource/styles/text_styles.dart';

class JoinMeetingView extends StatefulWidget {
  const JoinMeetingView({super.key});

  @override
  State<JoinMeetingView> createState() => _JoinMeetingViewState();
}

class _JoinMeetingViewState extends State<JoinMeetingView> {
  // bool isEnableJoinMeeting = false;
  bool isEnableCamera = true;
  bool isEnableNoAudio = true;
  bool isEnableRecordMeeting = false;

  TextEditingController idMettingController = TextEditingController();
  TextEditingController nameZoom = TextEditingController();
  String previousText = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // idMettingController.addListener(_formatIdmetting);
    final currentUser = Get.find<AppController>().lastLoggedUser!;
    nameZoom.text = currentUser.fullName;
  }

  // void _formatIdmetting() {
  //   String text = idMettingController.text.replaceAll('-', '');
  //   if (text.length > 12) text = text.substring(0, 12);

  //   String formatted = '';
  //   for (int i = 0; i < text.length; i++) {
  //     if (i != 0 && i % 4 == 0) formatted += '-';
  //     formatted += text[i];
  //   }

  //   // Kiểm tra nếu người dùng xóa ký tự cuối cùng
  //   if (idMettingController.text.length < previousText.length &&
  //       previousText.endsWith('-') &&
  //       !formatted.endsWith('-')) {
  //     formatted = formatted.substring(0, formatted.length - 1);
  //   }

  //   previousText = formatted;

  //   idMettingController.value = TextEditingValue(
  //     text: formatted,
  //     selection: TextSelection.collapsed(offset: formatted.length),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      hideKeyboardWhenTouchOutside: true,
      appBar: CommonAppBar(
        titleType: AppBarTitle.text,
        // text: context.l10n.button__sign_up,
        text: context.l10n.zoom__join_meeting,
        titleTextStyle: AppTextStyles.s20w600.text5Color,
        leadingIconColor: AppColors.button5,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: AppSpacing.edgeInsetsAll20,
          child: Column(
            children: [
              inputMeetingIdWidget(),
              AppSpacing.gapH28,
              optionWidget(),
              AppSpacing.gapH28,
              starMeetingButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget inputMeetingIdWidget() {
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
            controller: idMettingController,
            hintText: context.l10n.zoom__id_meeting,
            hintStyle: AppTextStyles.s16w500.text6Color
                .copyWith(color: AppColors.subText3),
            fillColor: Colors.transparent,
            contentPadding: const EdgeInsets.all(0),
            onChanged: (value) {
              setState(() {});
            },
          ),
          AppSpacing.gapH16,
          const AppDivider(height: 1, color: Color(0xff97B9DE)),
          AppSpacing.gapH16,
          AppTextField(
            controller: nameZoom,
            hintText: context.l10n.zoom__enter_your_name,
            hintStyle: AppTextStyles.s16w500.subText3Color,
            border: InputBorder.none,
            fillColor: Colors.transparent,
            contentPadding: EdgeInsets.zero,
            onChanged: (value) {
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget optionWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.zoom__participation_options,
          style: AppTextStyles.s16w600.text5Color,
        ),
        AppSpacing.gapH8,
        Container(
          padding: AppSpacing.edgeInsetsAll20,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.border2, width: 0.5),
            borderRadius: BorderRadius.circular(11),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    context.l10n.zoom__turn_off_my_camera,
                    style: AppTextStyles.s16w500,
                  ),
                  CupertinoSwitch(
                      activeColor: AppColors.button5,
                      trackColor: AppColors.subText3,
                      value: isEnableCamera,
                      onChanged: (value) {
                        setState(() {
                          isEnableCamera = !isEnableCamera;
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
                    context.l10n.zoom__no_audio_connection,
                    style: AppTextStyles.s16w500,
                  ),
                  CupertinoSwitch(
                    activeColor: AppColors.button5,
                    trackColor: AppColors.subText3,
                    value: isEnableNoAudio,
                    onChanged: (value) {
                      setState(() {
                        isEnableNoAudio = !isEnableNoAudio;
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

  Widget starMeetingButton() {
    return AppButton.secondary(
      onPressed: () {
        // isEnableJoinMeeting = !isEnableJoinMeeting;
        // setState(() {});
        final jitsiMeet = JitsiMeet();
        final configOverrides = {
          'startWithAudioMuted': isEnableNoAudio,
          'startWithVideoMuted': isEnableCamera,
          'subject': 'EDC Meet',
          'disableInviteFunctions': true,
          'whiteboard': {
            'enabled': true,
            'collabServerBaseUrl': 'https://whiteboard-edczoom.educhain.tech',
            'userLimit': 25,
          },
        };
        final currentUser = Get.find<AppController>().lastLoggedUser!;
        final options = JitsiMeetConferenceOptions(
          serverURL: Get.find<EnvConfig>().jitsiServerUrl,
          room: idMettingController.text,
          configOverrides: configOverrides,
          featureFlags: {
            'unsaferoomwarning.enabled': false,
            FeatureFlags.preJoinPageEnabled: false,
            // 'ios.recording.enabled': true,
            'ios.screensharing.enabled': true,
            'recording.enabled': true,
            'meeting-password.enabled': true,
            'toolbox.enabled': true,
            'toolbox.alwaysVisible': true,
            'invite.enabled': false,
          },
          userInfo: currentUser.avatarPath != null &&
                  currentUser.avatarPath!.isNotEmpty &&
                  currentUser.avatarPath != 'null'
              ? JitsiMeetUserInfo(
                  displayName: nameZoom.text,
                  email: currentUser.email ?? currentUser.phone ?? '',
                  avatar: currentUser.avatarPath ?? '',
                )
              : JitsiMeetUserInfo(
                  displayName: nameZoom.text,
                  email: currentUser.email ?? currentUser.phone ?? '',
                ),
        );
        jitsiMeet.join(options);
      },
      width: double.infinity,
      label: context.l10n.zoom__join_meeting,
      isDisabled: idMettingController.text.isEmpty || nameZoom.text.isEmpty,
      color: AppColors.button5,
    );
  }
}
