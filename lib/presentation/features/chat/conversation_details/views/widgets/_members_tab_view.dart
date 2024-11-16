part of '../conversation_details_view.dart';

class _MembersTabView extends StatelessWidget {
  const _MembersTabView({
    required this.controller,
  });

  final ConversationDetailsController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return CustomScrollView(
          slivers: [
            SliverOverlapInjector(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: Sizes.s16,
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: CustomSearchBar(
                  hintText: context.l10n.global__search,
                  onClear: () {
                    controller.searchUserInGroup('');
                  },
                  prefixIcon: AppIcon(
                    icon: AppIcons.searchLg,
                    color: AppColors.subText2,
                    size: 20,
                  ),
                  onChanged: (value) {
                    controller.searchUserInGroup(value);
                  },
                  searchController: controller.searchController,
                  autofocus: false,
                  padding: const EdgeInsets.fromLTRB(16, 5, 16, 5),
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: Sizes.s8,
              ),
            ),
            // if (controller.conversation.members.isNotEmpty)
            //   SliverList.separated(
            //     itemCount: controller.conversation.members.length,
            //     itemBuilder: (context, index) {
            //       final member = controller.conversation.members[index];

            //       return GestureDetector(
            //         behavior: HitTestBehavior.opaque,
            //         onTap: () => _onTapMember(context, member),
            //         child: Padding(
            //           padding: const EdgeInsets.symmetric(
            //             horizontal: Sizes.s16,
            //           ),
            //           child: Row(
            //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //             children: [
            //               Row(
            //                 children: [
            //                   AppCircleAvatar(
            //                     url: member.avatarPath ?? '',
            //                     size: Sizes.s48,
            //                   ).clickable(() {
            //                     controller.onMemberAvatarTap(member);
            //                   }),
            //                   AppSpacing.gapW12,
            //                   ContactDisplayNameTextPrivateChat(
            //                     user: member,
            //                     maxLenght: 30,
            //                   ),
            //                 ],
            //               ),
            //               if (member.id ==
            //                   controller.conversation.creatorId) ...[
            //                 Text(context.l10n.conversation_members__creator),
            //               ] else if (controller.conversation
            //                   .isAdmin(member.id)) ...[
            //                 Text(context.l10n.conversation_members__admin),
            //               ],
            //             ],
            //           ),
            //         ),
            //       );
            //     },
            //     separatorBuilder: (context, index) => AppSpacing.gapH16,
            //   ),

            if (controller.searchMemberResult.isNotEmpty)
              SliverList.separated(
                itemCount: controller.searchMemberResult.length,
                itemBuilder: (context, index) {
                  final member = controller.searchMemberResult[index];

                  return GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => _onTapMember(context, member),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Sizes.s16,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              AppCircleAvatar(
                                url: member.avatarPath ?? '',
                                size: Sizes.s48,
                              ).clickable(() {
                                controller.onMemberAvatarTap(member);
                              }),
                              AppSpacing.gapW12,
                            ],
                          ),
                          if (member.id ==
                              controller.conversation.creatorId) ...[
                            Text(context.l10n.conversation_members__creator),
                          ] else if (controller.conversation
                              .isAdmin(member.id)) ...[
                            Text(context.l10n.conversation_members__admin),
                          ],
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => AppSpacing.gapH16,
              ),
          ],
        );
      },
    );
  }

  void _onRemoveMember(BuildContext context, User member) {
    ViewUtil.showAppCupertinoAlertDialog(
      title: context.l10n.conversation_members__remove_confirm_title,
      message: context.l10n.conversation_members__remove_confirm_message,
      negativeText: context.l10n.button__cancel,
      positiveText: context.l10n.button__confirm,
      onPositivePressed: () => controller.removeMember(member),
    );
  }

  void _onTapMember(BuildContext context, User member) {
    if (member.isDeactivated() || member.id == controller.currentUser.id) {
      return;
    }

    final actions = <ActionSheetItem>[];

    if (!(controller.conversation.isCreator(member.id) ||
        !controller.canRemoveMembers)) {
      final isAddAdmin = !controller.conversation.isAdmin(member.id);
      actions.addAll([
        ActionSheetItem(
          title: isAddAdmin
              ? context.l10n.conversation_members__promote_admin_label
              : context.l10n.conversation_members__remove_admin_label,
          onPressed: () => _onPromoteOrRemoveAdmin(context, member, isAddAdmin),
        ),
        ActionSheetItem(
          title: context.l10n.conversation_members__remove_confirm_title,
          onPressed: () => _onRemoveMember(context, member),
        ),
      ]);
    }

    if (actions.isEmpty) {
      return;
    }

    ViewUtil.showActionSheet(
      items: actions,
    );
  }

  void _onPromoteOrRemoveAdmin(
      BuildContext context, User member, bool isAddAdmin) {
    late String? title;
    late String? message;

    if (isAddAdmin) {
      title = context.l10n.conversation_members__promote_confirm_title;
      message = context.l10n.conversation_members__promote_confirm_message;
    } else {
      title = context.l10n.conversation_members__remove_admin_confirm_title;
      message = context.l10n.conversation_members__remove_admin_confirm_message;
    }

    ViewUtil.showAppCupertinoAlertDialog(
      title: title,
      message: message,
      negativeText: context.l10n.button__cancel,
      positiveText: context.l10n.button__confirm,
      onPositivePressed: () =>
          controller.promoteOrRemoveAdmin(member, isAddAdmin),
    );
  }
}
