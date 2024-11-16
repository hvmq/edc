import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jitsi_meet_flutter_sdk/jitsi_meet_flutter_sdk.dart';

import '../../../../core/all.dart';
import '../../../base/base_view.dart';
import '../../../common_controller.dart/app_controller.dart';
import '../../../common_widgets/all.dart';
import '../../../resource/styles/app_colors.dart';
import '../../../resource/styles/gaps.dart';
import '../../../resource/styles/text_styles.dart';
import '../../chat/conversation_details/views/widgets/all.dart';
import '../zoom_home_controller.dart';

class StartMeetingView extends BaseView<ZoomHomeController> {
  const StartMeetingView({Key? key}) : super(key: key);

  @override
  Widget buildPage(BuildContext context) {
    final idMeeting = Get.find<AppController>().lastLoggedUser!.zoomId;
    return CommonScaffold(
      hideKeyboardWhenTouchOutside: true,
      appBar: CommonAppBar(
        titleType: AppBarTitle.text,
        // text: context.l10n.button__sign_up,
        text: l10n.zoom__start_meeting,
        titleTextStyle: AppTextStyles.s20w600.text5Color,
        leadingIconColor: AppColors.button5,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: AppSpacing.edgeInsetsAll20,
          child: Column(
            children: [
              linkWidget(idMeeting ?? '', context),
              AppSpacing.gapH32,
              Obx(() => controller.sharedLink.value != ''
                  ? _buildInviteLink(context)
                  : AppSpacing.emptyBox),
              AppSpacing.gapH12,
              _buildZoomLink(context),
              AppSpacing.gapH28,
              optionWidget(),
              AppSpacing.gapH28,
              Obx(() => starMeetingButton(idMeeting ?? '')),
              AppSpacing.gapH24,
            ],
          ),
        ),
      ),
    );
  }

  Widget linkWidget(String idMeeting, BuildContext context) {
    return Container(
      padding: AppSpacing.edgeInsetsAll20,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border2, width: 0.5),
        borderRadius: BorderRadius.circular(11),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                '${l10n.zoom__id_meeting}: $idMeeting',
                style: AppTextStyles.s16w600,
              ),
              const Spacer(),
              AppIcon(
                icon: AppIcons.copy,
                size: 20,
              ).clickable(() {
                ViewUtil.copyToClipboard(idMeeting).then((_) {
                  ViewUtil.showAppSnackBar(
                    context,
                    context.l10n.global__copied_to_clipboard,
                  );
                });
              })
            ],
          ),
          AppSpacing.gapH16,
          const AppDivider(height: 1, color: Color(0xff97B9DE)),
          AppSpacing.gapH16,
          AppTextField(
            controller: controller.nameZoom,
            hintText: l10n.zoom__enter_your_name,
            hintStyle: AppTextStyles.s16w500.subText3Color,
            border: InputBorder.none,
            fillColor: Colors.transparent,
            contentPadding: EdgeInsets.zero,
            onChanged: (value) {
              if (controller.nameZoom.text.isEmpty) {
                controller.setDisableButton(true);
              } else {
                controller.setDisableButton(false);
              }
            },
          )
        ],
      ),
    );
  }

  Widget optionWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.zoom__participation_options,
          style: AppTextStyles.s16w600.text5Color,
        ),
        AppSpacing.gapH8,
        Container(
            padding: AppSpacing.edgeInsetsAll20,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.border2, width: 0.5),
              borderRadius: BorderRadius.circular(11),
            ),
            child: Obx(
              () => Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        l10n.zoom__turn_off_my_camera,
                        style: AppTextStyles.s16w500,
                      ),
                      CupertinoSwitch(
                          activeColor: AppColors.button5,
                          trackColor: AppColors.subText3,
                          value: controller.isEnableCamera.value,
                          onChanged: (value) {
                            controller.isEnableCamera.toggle();
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
                        l10n.zoom__no_audio_connection,
                        style: AppTextStyles.s16w500,
                      ),
                      CupertinoSwitch(
                        activeColor: AppColors.button5,
                        trackColor: AppColors.subText3,
                        value: controller.isEnableNoAudio.value,
                        onChanged: (value) {
                          controller.isEnableNoAudio.toggle();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            )),
      ],
    );
  }

  Widget _buildInviteLink(BuildContext context) {
    return SettingGroupWidget(
      groupName: context.l10n.zoom_for_mobile,
      children: [
        SettingItem(
          icon: AppIcons.link,
          title: controller.sharedLink.value,
          trailing: Row(
            children: [
              AppIcon(
                icon: Icons.qr_code,
                size: Sizes.s20,
                padding: AppSpacing.edgeInsetsAll8,
                onTap: _showQRCodeDialog,
              ),
              AppIcon(
                icon: AppIcons.copy,
                size: Sizes.s20,
                padding: AppSpacing.edgeInsetsAll8.copyWith(right: 0),
                onTap: () {
                  ViewUtil.copyToClipboard(controller.sharedLink.value)
                      .then((_) {
                    ViewUtil.showAppSnackBar(
                      context,
                      context.l10n.global__copied_to_clipboard,
                    );
                  });
                },
              ),
            ],
          ),
          onTap: _showQRCodeDialog,
        ),
      ],
    );
  }

  Widget _buildZoomLink(BuildContext context) {
    final idMeeting = Get.find<AppController>().lastLoggedUser!.zoomId;

    return SettingGroupWidget(
      groupName: context.l10n.zoom_for_desktop,
      children: [
        SettingItem(
          icon: AppIcons.link,
          title: '${Get.find<EnvConfig>().jitsiServerUrl}/$idMeeting',
          trailing: Row(
            children: [
              // AppIcon(
              //   icon: Icons.qr_code,
              //   size: Sizes.s20,
              //   padding: AppSpacing.edgeInsetsAll8,
              //   onTap: _showQRCodeDialog,
              // ),
              AppIcon(
                icon: AppIcons.copy,
                size: Sizes.s20,
                padding: AppSpacing.edgeInsetsAll8.copyWith(right: 0),
                onTap: () {
                  ViewUtil.copyToClipboard(
                          '${Get.find<EnvConfig>().jitsiServerUrl}/$idMeeting')
                      .then((_) {
                    ViewUtil.showAppSnackBar(
                      context,
                      context.l10n.global__copied_to_clipboard,
                    );
                  });
                },
              ),
            ],
          ),
          onTap: _showQRCodeDialog,
        ),
      ],
    );
  }

  void _showQRCodeDialog() {
    Get.dialog(
      barrierColor: Colors.black26,
      BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Dialog(
          backgroundColor: AppColors.opacityBackground,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Sizes.s24.w,
              vertical: Sizes.s40.h,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  controller.sharedLink.value,
                  style: AppTextStyles.s16w500.text5Color,
                ),
                AppSpacing.gapH16,
                AppQrCodeView(
                  controller.sharedLink.value,
                  size: 300.w,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget starMeetingButton(String idMeeting) {
    return AppButton.secondary(
      onPressed: () {
        final jitsiMeet = JitsiMeet();
        final configOverrides = {
          'startWithAudioMuted': controller.isEnableNoAudio.value,
          'startWithVideoMuted': controller.isEnableCamera.value,
          'subject': 'EDC Meet',
          'disableInviteFunctions': true,
          'whiteboard': {
            'enabled': true,
            'collabServerBaseUrl': 'https://whiteboard-edczoom.educhain.tech',
            'userLimit': 25,
          },
        };
        // if (!isCreatorOrAdmin) {
        //   configOverrides['buttonsWithNotifyClick'] = ['end-meeting'];
        // }
        final currentUser = Get.find<AppController>().lastLoggedUser!;
        final options = JitsiMeetConferenceOptions(
          serverURL: Get.find<EnvConfig>().jitsiServerUrl,
          room: idMeeting,
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
                  displayName: controller.nameZoom.text,
                  email: currentUser.email ?? currentUser.phone ?? '',
                  avatar: currentUser.avatarPath ?? '',
                )
              : JitsiMeetUserInfo(
                  displayName: controller.nameZoom.text,
                  email: currentUser.email ?? currentUser.phone ?? '',
                ),
        );
        jitsiMeet.join(options);
        Get.find<ZoomHomeController>()
            .addMeetingHistoryItem(idMeeting, DateTime.now().toString());
      },
      width: double.infinity,
      label: l10n.zoom__start_meeting,
      color: AppColors.button5,
      textStyleLabel: AppTextStyles.s18w500.copyWith(
        color: Colors.white,
      ),
      isDisabled: controller.disableButton.value,
    );
  }
}
