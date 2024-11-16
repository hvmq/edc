import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../core/all.dart';
import '../../../../../models/user.dart';
import '../../../../base/all.dart';
import '../../../../common_widgets/all.dart';
import '../../../../resource/resource.dart';
import '../../../search_user/views/search_user_bottom_sheet.dart';
import '../controllers/conversation_members_controller.dart';

class ConversationMembersView extends BaseView<ConversationMembersController> {
  const ConversationMembersView({Key? key}) : super(key: key);

  void _onRemoveMember(BuildContext context, User member) {
    ViewUtil.showAppCupertinoAlertDialog(
      title: context.l10n.conversation_members__remove_confirm_title,
      message: context.l10n.conversation_members__remove_confirm_message,
      negativeText: context.l10n.button__cancel,
      positiveText: context.l10n.button__confirm,
      onPositivePressed: () => controller.removeMember(member),
    );
  }

  void _onAddMember(BuildContext context) {
    ViewUtil.showBottomSheet<List<User>>(
      isScrollControlled: true,
      isFullScreen: true,
      child: CreateChatSearchUsersBottomSheet(
        allowSelectMultiple: false,
        title: context.l10n.conversation_members__add_member,
        hintText: context.l10n.global__search,
      ),
    ).then(
      (selectedUsers) {
        if (selectedUsers != null) {
          controller.addMember(selectedUsers.first);
        }
      },
    );
  }

  @override
  Widget buildPage(BuildContext context) {
    return CommonScaffold(
      applyAutoPaddingBottom: true,
      appBar: CommonAppBar(
        onLeadingPressed: () => Get.back(result: controller.conversation),
        titleType: AppBarTitle.text,
        text: context.l10n.conversation_members__title,
        actions: [
          AppIcon(
            icon: Icons.add,
            onTap: () => _onAddMember(context),
          ),
        ],
      ),
      body: Obx(
        () => ListView.builder(
          padding: AppSpacing.edgeInsetsH20,
          itemCount: controller.members.length,
          itemBuilder: (context, index) {
            final member = controller.conversation.members[index];

            return _buildUserItem(
              context,
              member,
            );
          },
        ),
      ),
    );
  }

  ListTile _buildUserItem(BuildContext context, User member) {
    final isYou = member.id == currentUser.id;

    return ListTile(
      splashColor: Colors.transparent,
      contentPadding: EdgeInsets.zero,
      leading: AppCircleAvatar(
        url: member.avatarPath ?? '',
        size: 40.r,
      ),
      title: Text(
        l10n.global__you,
        style: AppTextStyles.s16w400,
      ),
      subtitle: member.id == controller.conversation.creatorId
          ? Text(context.l10n.conversation_members__creator)
          : controller.conversation.isAdmin(member.id)
              ? Text(context.l10n.conversation_members__admin)
              : null,
      trailing: _buildTrailing(context, member),
      onTap: () => _onTapMember(member),
    );
  }

  Widget _buildTrailing(BuildContext context, User member) {
    if (!controller.canRemoveMembers || member.id == currentUser.id) {
      return AppSpacing.emptyBox;
    }

    return AppIcon(
      icon: Icons.close,
      size: Sizes.s16,
      color: AppColors.negative,
      onTap: () => _onRemoveMember(context, member),
    );
  }

  void _onTapMember(User member) {
    if (member.isDeactivated() || member.id == currentUser.id) {
      return;
    }

    final actions = <ActionSheetItem>[
      // ActionSheetItem(
      //   title: l10n.conversation_members__go_to_private_chat,
      //   onPressed: () => controller.goToPrivateChat(member),
      // ),
    ];

    if (!(controller.conversation.isCreator(member.id) ||
        !controller.canRemoveMembers)) {
      final isAddAdmin = !controller.conversation.isAdmin(member.id);
      actions.add(
        ActionSheetItem(
          title: isAddAdmin
              ? l10n.conversation_members__promote_admin_label
              : l10n.conversation_members__remove_admin_label,
          onPressed: () => _onPromoteOrRemoveAdmin(member, isAddAdmin),
        ),
      );
    }

    if (actions.isEmpty) {
      return;
    }

    ViewUtil.showActionSheet(
      items: actions,
    );
  }

  void _onPromoteOrRemoveAdmin(User member, bool isAddAdmin) {
    late String? title;
    late String? message;

    if (isAddAdmin) {
      title = l10n.conversation_members__promote_confirm_title;
      message = l10n.conversation_members__promote_confirm_message;
    } else {
      title = l10n.conversation_members__remove_admin_confirm_title;
      message = l10n.conversation_members__remove_admin_confirm_message;
    }

    ViewUtil.showAppCupertinoAlertDialog(
      title: title,
      message: message,
      negativeText: l10n.button__cancel,
      positiveText: l10n.button__confirm,
      onPositivePressed: () =>
          controller.promoteOrRemoveAdmin(member, isAddAdmin),
    );
  }
}
