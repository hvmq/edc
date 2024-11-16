part of 'conversation_details_view.dart';

class _GroupChatDetails extends StatefulWidget {
  final ConversationDetailsController controller;

  const _GroupChatDetails({
    required this.controller,
  });

  @override
  State<_GroupChatDetails> createState() => _GroupChatDetailsState();
}

class _GroupChatDetailsState extends State<_GroupChatDetails> {
  bool isEdit = false;
  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (_) {
        if (widget.controller.isConversationUpdated) {
          Get.find<ChatHubController>()
              .conversationUpdated(widget.controller.conversation);
        }
      },
      child: CommonScaffold(
        hideKeyboardWhenTouchOutside: true,
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                context,
              ),
              sliver: SliverAppBar(
                backgroundColor: AppColors.white,
                pinned: true,
                expandedHeight: 0.6.sh,
                forceElevated: innerBoxIsScrolled,
                leading: Padding(
                  padding: const EdgeInsets.only(
                    left: Sizes.s16,
                    right: Sizes.s12,
                  ),
                  child: Row(
                    children: [
                      AppIcon(
                        icon: AppIcons.arrowLeft,
                        color: AppColors.text1,
                      ),
                      AppSpacing.gapW4,
                      Text(context.l10n.global__back,
                          style: AppTextStyles.s16w700),
                    ],
                  ),
                ).clickable(() {
                  Get.back();
                }),
                actions: [
                  // _buildSaveChangesButton(context),
                  _buildEditButton(context),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Sizes.s16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildConversationInfo(context),
                        AppSpacing.gapH16,
                        ActionChatDetails(
                          controller: widget.controller,
                          isGroup: widget.controller.conversation.isGroup,
                        ),
                        AppSpacing.gapH20,
                        _buildInfoGroup(context),
                      ],
                    ),
                  ),
                ),
                bottom: PreferredSize(
                  preferredSize: _buildTabBarResources(context).preferredSize,
                  child: Container(
                    color: AppColors.backgroundPinMessage,
                    child: _buildTabBarResources(context),
                  ),
                ),
              ),
            ),
          ],
          body: _buildTabBarViewResources(),
        ),
        // body: SingleChildScrollView(
        //   padding: AppSpacing.edgeInsetsH20,
        //   child: Column(
        //     children: [
        //       _buildConversationInfo(context),
        //       AppSpacing.gapH16,
        //       ActionChatDetails(
        //         controller: controller,
        //         isGroup: controller.conversation.isGroup,
        //       ),
        //       AppSpacing.gapH20,
        //       _buildInfoGroup(context),
        //       _buildTabBarResources(context),
        //       // _buildOtherSettings(context),
        //       // AppSpacing.gapH20,
        //       // _buildPrivacyAndSupport(context),
        //       // AppSpacing.gapH16,
        //       // ConversationSharedLink(controller: controller),
        //     ],
        //   ),
        // ),
      ),
    );
  }

  TabBar _buildTabBarResources(BuildContext context) {
    return TabBar(
      labelColor: AppColors.contentInfoCard,
      indicatorColor: AppColors.contentInfoCard,
      dividerColor: AppColors.backgroundPinMessage,
      dividerHeight: 0.5,
      controller: widget.controller.tabBarGroupController,
      labelPadding: EdgeInsets.zero,
      unselectedLabelColor: AppColors.subText3,
      tabs: [
        Tab(text: context.l10n.conversation_resources__tab_member),
        Tab(text: context.l10n.conversation_resources__tab_image),
        Tab(text: context.l10n.conversation_resources__tab_video),
        Tab(text: context.l10n.conversation_resources__tab_voice),
        Tab(text: context.l10n.conversation_resources__tab_links),
      ],
    );
  }

  Widget _buildTabBarViewResources() {
    return TabBarView(
      controller: widget.controller.tabBarGroupController,
      children: [
        _MembersTabView(controller: widget.controller),
        _ImageTabView(controller: widget.controller),
        _VideoTabView(controller: widget.controller),
        _VoiceTabView(controller: widget.controller),
        _LinkTabView(controller: widget.controller),
      ],
    );
  }

  CommonAppBar _buildAppBar(BuildContext context) {
    return CommonAppBar(
      titleType: AppBarTitle.none,
      actions: [_buildSaveChangesButton(context)],
    );
  }

  Widget _buildSaveChangesButton(BuildContext context) {
    return Obx(
      () => widget.controller.isEdited
          ? TextButton(
              onPressed: () {
                ViewUtil.hideKeyboard(context);
                widget.controller.saveChanges();
                setState(() {
                  isEdit = false;
                });
              },
              child: Text(
                context.l10n.button__save,
                style: AppTextStyles.s16w400.toColor(AppColors.button5),
              ),
            )
          : const SizedBox.shrink(),
    );
  }

  Widget _buildEditButton(BuildContext context) {
    return Obx(
      () => widget.controller.isCreatorOrAdmin
          ? TextButton(
              onPressed: () {
                Get.to(
                  () => EditInfoGroupChat(controller: widget.controller),
                  transition: Transition.cupertino,
                );
              },
              child: Text(
                context.l10n.button_edit,
                style: AppTextStyles.s16w400.toColor(AppColors.button5),
              ),
            )
          : const SizedBox.shrink(),
    );
  }

  Widget _buildConversationInfo(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          _buildAvatar(),
          AppSpacing.gapH12,
          _buildConversationTitle(),
          Text(
            '${widget.controller.conversation.members.length} ${context.l10n.conversation_details__members.toLowerCase()}',
            style: AppTextStyles.s14w400.copyWith(color: AppColors.subText3),
          ),
        ],
      ),
    );
  }

  Widget _buildConversationTitle() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        widget.controller.conversation.title(),
        style: AppTextStyles.s18w600,
        textAlign: TextAlign.center,
      ),
    );

    // return isEdit
    //     ? TextField(
    //         controller: widget.controller.conversationNameController,
    //         onChanged: (_) => widget.controller.validateIsEdited(),
    //         textAlign: TextAlign.center,
    //         style: AppTextStyles.s18w500,
    //         textCapitalization: TextCapitalization.sentences,
    //         decoration: const InputDecoration(border: InputBorder.none),
    //         autofocus: true,
    //       )
    //     : Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //         mainAxisSize: MainAxisSize.min,
    //         children: [
    //           Padding(
    //             padding: const EdgeInsets.only(left: 44),
    //             child: Text(
    //               widget.controller.conversationNameController.text,
    //               textAlign: TextAlign.center,
    //               style: AppTextStyles.s18w500,
    //             ),
    //           ),
    //           IconButton(
    //             onPressed: () {
    //               setState(() {
    //                 isEdit = true;
    //               });
    //             },
    //             icon: AppIcon(
    //               icon: AppIcons.edit,
    //               color: AppColors.button5,
    //               size: 18,
    //             ),
    //           ),
    //         ],
    //       );
  }

  Widget _buildAvatar() {
    return AppCircleAvatar(
      url: widget.controller.conversation.avatarUrl ?? '',
      size: 100,
      clickToSeeFullImage: true,
    );

    // return Stack(
    //   children: [
    //     Obx(
    //       () => widget.controller.newAvatar == null
    //           ? AppCircleAvatar(
    //               url: widget.controller.conversation.avatarUrl ?? '',
    //               size: 100,
    //             )
    //           : Container(
    //               width: 100,
    //               height: 100,
    //               decoration: BoxDecoration(
    //                 shape: BoxShape.circle,
    //                 image: DecorationImage(
    //                   image: FileImage(widget.controller.newAvatar!),
    //                   fit: BoxFit.cover,
    //                 ),
    //               ),
    //             ),
    //     ),
    //     Positioned(
    //       bottom: 0,
    //       right: 0,
    //       child: Container(
    //         height: 40,
    //         width: 40,
    //         decoration: BoxDecoration(
    //           color: AppColors.button5,
    //           shape: BoxShape.circle,
    //           border: Border.all(
    //             color: Colors.white,
    //             width: 0.5,
    //           ),
    //         ),
    //         child: Padding(
    //           padding: const EdgeInsets.all(8.0),
    //           child: AppIcon(
    //             icon: AppIcons.camera,
    //             color: AppColors.white,
    //           ),
    //         ),
    //       ).clickable(() {
    //         widget.controller.pickImage();
    //       }),
    //     ),
    //   ],
    // );
  }

  Widget _buildOtherSettings(BuildContext context) {
    return SettingGroupWidget(
      groupName: context.l10n.conversation_details__other_settings,
      children: [
        SettingItem(
          icon: AppIcons.media,
          title: context.l10n.conversation_details__chat_resource,
          onTap: widget.controller.goToChatResources,
        ),
        SettingItem(
          icon: AppIcons.user,
          title: context.l10n.conversation_details__members,
          onTap: widget.controller.goToChatMembers,
        ),
        SettingItem(
          icon: AppIcons.logout,
          title: context.l10n.conversation_details__leave_group,
          onTap: () => onLeaveGroup(context),
        ),
      ],
    );
  }

  Widget _buildPrivacyAndSupport(BuildContext context) {
    return SettingGroupWidget(
      groupName: context.l10n.conversation_details__privacy_and_support,
      children: [
        if (widget.controller.isCreatorOrAdmin)
          SettingItem(
            icon: AppIcons.delete,
            title: context.l10n.conversation_details__delete_chat,
            onTap: () => widget.controller.onDeleteChat(context),
          ),
      ],
    );
  }

  void onLeaveGroup(BuildContext context) {
    ViewUtil.showAppCupertinoAlertDialog(
      title: context.l10n.conversation_details__leave_group,
      message: context.l10n.conversation_details__leave_group_message,
      negativeText: context.l10n.button__cancel,
      positiveText: context.l10n.button__confirm,
      onPositivePressed: () {
        widget.controller.onLeaveGroupChat();
      },
    );
  }

  Container _buildInfoGroup(BuildContext context) {
    return Container(
      padding: AppSpacing.edgeInsetsAll16,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.backgroundPinMessage,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              _onAddMember(context);
            },
            child: Row(
              children: [
                Text(
                  context.l10n.conversation_members__add_member,
                  style:
                      AppTextStyles.s16w400.toColor(AppColors.contentInfoCard),
                ),
              ],
            ),
          ),
          AppSpacing.gapH8,
          AppDivider(color: AppColors.dividerInfoCard),
          AppSpacing.gapH8,
          GestureDetector(
            onTap: () {
              onLeaveGroup(context);
            },
            child: Row(
              children: [
                Text(
                  context.l10n.conversation_details__leave_group,
                  style: AppTextStyles.s16w400.toColor(AppColors.button7),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showQRCodeDialog(String sharedLink) {
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
                GestureDetector(
                  onLongPress: () {
                    ViewUtil.copyToClipboard(sharedLink).then((_) {
                      ViewUtil.showAppSnackBar(
                        Get.context!,
                        Get.context!.l10n.global__copied_to_clipboard,
                      );
                    });
                  },
                  child: Text(
                    sharedLink,
                    style: AppTextStyles.s16w500.text5Color,
                  ),
                ),
                AppSpacing.gapH16,
                AppQrCodeView(
                  sharedLink,
                  size: 300.w,
                ),
              ],
            ),
          ),
        ),
      ),
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
          widget.controller.addMember(selectedUsers.first);
        }
      },
    );
  }
}
