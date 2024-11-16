import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../models/enums/mute_conversation_option_enum.dart';
import '../../../../../common_widgets/all.dart';
import '../../../../../resource/resource.dart';
import '../../../../all.dart';

class MuteConversationActionWidget extends StatefulWidget {
  final ConversationDetailsController controller;

  const MuteConversationActionWidget({required this.controller, super.key});

  @override
  State<MuteConversationActionWidget> createState() =>
      _MuteConversationActionWidgetState();
}

class _MuteConversationActionWidgetState
    extends State<MuteConversationActionWidget> {
  MenuController menuController = MenuController();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return GestureDetector(
      onTap: onCallVideoClick,
      child: MenuAnchor(
        controller: menuController,
        style: MenuStyle(
          backgroundColor: WidgetStateColor.resolveWith(
            (states) => Colors.white,
          ),
        ),
        menuChildren: MuteConversationOption.values
            .map(
              (e) => MenuItemButton(
                child: Text(
                  e.labelName(l10n),
                  style: AppTextStyles.s14w600.copyWith(
                    color: AppColors.text1,
                  ),
                ),
                onPressed: () {
                  widget.controller.onMuteConversation(e);
                },
              ),
            )
            .toList(),
        child: Container(
          // padding: const EdgeInsets.symmetric(horizontal: Sizes.s12),
          constraints: BoxConstraints(
              minWidth: 65.w, maxWidth: 65.w, maxHeight: 70.h, minHeight: 70.h),
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
                icon: AppIcons.bell,
                size: 20,
              ),
              AppSpacing.gapH8,
              Text(
                widget.controller.conversation.isMuted == true
                    ? l10n.text_unmute
                    : l10n.text_mute,
                style: AppTextStyles.s14w400,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onCallVideoClick() {
    if (widget.controller.conversation.isMuted == false) {
      menuController.open();
    } else {
      widget.controller.onUnMuteConversation();
    }
  }
}
