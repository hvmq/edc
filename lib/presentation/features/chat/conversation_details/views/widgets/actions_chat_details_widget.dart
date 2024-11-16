import 'package:flutter/material.dart';

import '../../../../../../core/all.dart';
import '../../../../../common_widgets/all.dart';
import '../../../../../resource/resource.dart';
import '../../../../all.dart';
import 'mute_conversation_action_widget.dart';

class ActionChatDetails extends StatelessWidget {
  final bool isGroup;
  final ConversationDetailsController controller;

  const ActionChatDetails({
    required this.controller,
    required this.isGroup,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (!isGroup) ...[
          GestureDetector(
            onTap: controller.onCallVoiceClick,
            child: Container(
              width: Sizes.s40,
              height: Sizes.s40,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: AppColors.button2,
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                shape: BoxShape.circle,
              ),
              child: AppIcon(
                icon: AppIcons.call,
                color: AppColors.white,
                padding: const EdgeInsets.all(Sizes.s8),
              ),
            ),
          ),
          AppSpacing.gapW24,
          GestureDetector(
            onTap: controller.onCallVideoClick,
            child: Container(
              width: Sizes.s40,
              height: Sizes.s40,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: AppColors.button2,
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                shape: BoxShape.circle,
              ),
              child: AppIcon(
                icon: AppIcons.video,
                color: AppColors.white,
                padding: const EdgeInsets.all(Sizes.s8),
              ),
            ),
          ),
          AppSpacing.gapW24,
        ],
        if (isGroup && controller.isCreatorOrAdmin) ...[
          GestureDetector(
            onTap: controller.onCallVideoGroupClick,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: Sizes.s12),
              height: 55,
              decoration: BoxDecoration(
                color: AppColors.backgroundPinMessage,
                borderRadius: const BorderRadius.all(
                  Radius.circular(12),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppIcon(
                    icon: AppIcons.video,
                  ),
                  Text(
                    'Video',
                    style: AppTextStyles.s14w500,
                  ),
                ],
              ),
            ),
          ),
          AppSpacing.gapW24,
        ],
        MuteConversationActionWidget(controller: controller),
        AppSpacing.gapW24,
        if (controller.isCreatorOrAdmin) _buildIconMore(context),
      ],
    );
  }

  Widget _buildIconMore(BuildContext context) => PopupMenuButton<int>(
        color: AppColors.backgroundPinMessage,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        position: PopupMenuPosition.under,
        onSelected: (value) {},
        itemBuilder: (context) => [
          // PopupMenuItem<int>(
          //   enabled: false,
          //   value: 1,
          //   child: AppDisableWidget(
          //     child: Row(
          //       children: [
          //         Text(
          //           context.l10n.text_notifi_sound,
          //           style: AppTextStyles.s16Base,
          //         ),
          //         const Spacer(),
          //         AppIcon(
          //           icon: AppIcons.bell,
          //           size: 20,
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          // PopupMenuItem<int>(
          //   value: 2,
          //   enabled: false,
          //   child: AppDisableWidget(
          //     child: Row(
          //       children: [
          //         Text(
          //           context.l10n.text_share_contact,
          //           style: AppTextStyles.s16Base,
          //         ),
          //         const Spacer(),
          //         AppIcon(
          //           icon: AppIcons.shareContact,
          //           size: 20,
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          // PopupMenuItem<int>(
          //   value: 3,
          //   enabled: false,
          //   child: AppDisableWidget(
          //     child: Row(
          //       children: [
          //         Text(
          //           context.l10n.text_languages,
          //           style: AppTextStyles.s16Base,
          //         ),
          //         const Spacer(),
          //         AppIcon(
          //           icon: AppIcons.language,
          //           size: 20,
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          if (controller.isCreatorOrAdmin) ...[
            PopupMenuItem<int>(
              value: 4,
              child: Row(
                children: [
                  Text(
                    context.l10n.text_clear_mess,
                    style: AppTextStyles.s16Base,
                  ),
                  const Spacer(),
                  AppIcon(
                    icon: AppIcons.clearMessage,
                    size: 20,
                  ),
                ],
              ),
              onTap: () {
                controller.onDeleteChat(context);
              },
            ),
          ],
        ],
        child: _buildItem(AppIcons.more, context.l10n.home__more_title),
      );

  Widget _buildItem(
    SvgGenImage icon,
    String text, {
    Function()? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.s12),
        height: 55,
        decoration: BoxDecoration(
          color: AppColors.backgroundPinMessage,
          borderRadius: const BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppIcon(
              icon: icon,
            ),
            Text(
              text,
              style: AppTextStyles.s14w500,
            ),
          ],
        ),
      ),
    );
  }
}
