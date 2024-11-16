import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

import '../../../../../../../../core/configs/env_config.dart';
import '../../../../../../../../core/extensions/all.dart';
import '../../../../../../../../models/call.dart';
import '../../../../../../../../models/call_history.dart';
import '../../../../../../../../models/conversation.dart';
import '../../../../../../../../models/message.dart';
import '../../../../../../../common_widgets/app_icon.dart';
import '../../../../../../../resource/gen/assets.gen.dart';
import '../../../../../../../resource/styles/app_colors.dart';
import '../../../../../../../resource/styles/gaps.dart';
import '../../../../../../../resource/styles/text_styles.dart';

class PreviewCallMessageBody extends StatelessWidget {
  final Message message;
  final bool isMine;
  final int currentUserId;
  final Conversation conversation;

  const PreviewCallMessageBody({
    required this.message,
    required this.isMine,
    required this.currentUserId,
    required this.conversation,
    super.key,
  });

  CallHistory? getCallHistory(List<CallHistory> callHistories, int senderId) {
    final index = callHistories.indexWhere(
      (element) => element.userId == senderId,
    );
    if (index != -1) {
      return callHistories[index];
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(Get.context!)!;
    final Call? call = Call.callFromStringJson(message.content);

    if (message.isCallJitsi) {
      String? groupName;
      String? joinUrl;
      groupName = conversation.name;
      joinUrl = '${Get.find<EnvConfig>().jitsiUrl}/${conversation.id}';

      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.popup.withOpacity(0.22),
        ),
        padding: const EdgeInsets.only(
          top: Sizes.s8,
          bottom: Sizes.s8,
          left: Sizes.s24,
          right: Sizes.s8,
        ),
        child: buildItemCallGroup(
          Icons.video_call,
          l10n.call__call_meeting(groupName ?? ''),
          AppColors.white,
          joinUrl ?? '',
        ),
      ).clickable(() async {});
    }
    if (call == null) {
      return AppSpacing.emptyBox;
    }

    final callHistory = getCallHistory(call.callHistories ?? [], currentUserId);
    if (callHistory == null) {
      return AppSpacing.emptyBox;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Sizes.s24,
        vertical: Sizes.s8,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.popup.withOpacity(0.22),
      ),
      child: _buildStatusCall(
        callHistory.status,
        Duration(seconds: callHistory.duration).toHHMMSS(),
        call.isVideo ?? false,
      ),
    ).clickable(() {});
  }

  Widget _buildStatusCall(String status, String time, bool isVideoCall) {
    final l10n = AppLocalizations.of(Get.context!)!;

    Widget result = const SizedBox();
    switch (status) {
      case 'outgoing':
        result = buildItemStatusCall(
          AppIcons.phoneOut,
          isVideoCall
              ? l10n.call_history__video_outgoing
              : l10n.call_history__outgoing,
          const Color(0xff3A9A07),
          time,
        );
        break;
      case 'incoming':
        result = buildItemStatusCall(
          AppIcons.phoneIn,
          isVideoCall
              ? l10n.call_history__video_incoming
              : l10n.call_history__incoming,
          const Color(0xff3A9A07),
          time,
        );
        break;
      case 'missed':
        result = buildItemStatusCall(
          AppIcons.phoneMissed,
          isVideoCall
              ? l10n.call_history__video_missed
              : l10n.call_history__missed,
          const Color(0xff3A9A07),
          time,
        );
        break;
      case 'canceled':
        result = buildItemStatusCall(
          AppIcons.phoneOut,
          isVideoCall
              ? l10n.call_history__video_canceled
              : l10n.call_history__canceled,
          const Color(0xff3A9A07),
          time,
        );
      case 'declined':
        result = buildItemStatusCall(
          AppIcons.phoneMissed,
          isVideoCall
              ? l10n.call_history__video_declined
              : l10n.call_history__declined,
          AppColors.negative,
          time,
        );
        break;
    }

    return result;
  }

  Widget buildItemStatusCall(
    SvgGenImage icon,
    String title,
    Color color,
    String time,
  ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppIcon(
          icon: icon,
          size: Sizes.s28,
          color: AppColors.white,
          isCircle: true,
          backgroundColor: color,
        ),
        AppSpacing.gapW4,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: AppTextStyles.s16w500.copyWith(
                  color: AppColors.text1, decoration: TextDecoration.none),
            ),
            const SizedBox(
              width: Sizes.s4,
            ),
            Text(
              time,
              style: AppTextStyles.s14w600.copyWith(
                  color: AppColors.text1, decoration: TextDecoration.none),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildItemCallGroup(
    Object icon,
    String title,
    Color color,
    String time,
  ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppIcon(
          icon: icon,
          size: Sizes.s28,
          color: color,
          isCircle: true,
          backgroundColor: const Color(0xff3A9A07),
        ),
        AppSpacing.gapW12,
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: AppTextStyles.s16w500.copyWith(
                    color: AppColors.text1, decoration: TextDecoration.none),
                maxLines: 2,
              ),
              const SizedBox(
                width: Sizes.s4,
              ),
              Text(
                time,
                style: AppTextStyles.s14w600.copyWith(
                    color: AppColors.button5,
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.button5),
                maxLines: 2,
              ),
            ],
          ),
        ),
      ],
    ).clickable(() {});
  }
}
