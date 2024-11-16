part of 'conversation_details_view.dart';

class _PrivateChatDetails extends StatefulWidget {
  final ConversationDetailsController controller;
  final ChatHubController chatHubController;

  const _PrivateChatDetails({
    required this.controller,
    required this.chatHubController,
  });

  @override
  State<_PrivateChatDetails> createState() => _PrivateChatDetailsState();
}

class _PrivateChatDetailsState extends State<_PrivateChatDetails> {
  late final TabController tabController;

  Widget _buildItem(
    Object icon,
    String text, {
    Function()? onTap,
    double size = 20,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // padding: const EdgeInsets.symmetric(horizontal: Sizes.s),

        constraints: BoxConstraints(
            minWidth: 65.w, maxWidth: 65.w, maxHeight: 70.h, minHeight: 70.h),
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
            Padding(
              padding:
                  (size == 16) ? const EdgeInsets.all(2.0) : EdgeInsets.zero,
              child: AppIcon(
                icon: icon,
                size: size,
              ),
            ),
            AppSpacing.gapH8,
            Text(
              text,
              style: AppTextStyles.s14w400,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconMore(BuildContext context) => PopupMenuButton<int>(
        color: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        position: PopupMenuPosition.under,
        onSelected: (value) {},
        itemBuilder: (context) => [
          // PopupMenuItem<int>(
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
          //   child: AppDisableWidget(
          //     child: Row(
          //       children: [
          //         Text(context.l10n.text_languages,
          //             style: AppTextStyles.s16Base),
          //         const Spacer(),
          //         AppIcon(
          //           icon: AppIcons.language,
          //           size: 20,
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
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
              widget.controller.deleteChat();
            },
          ),
        ],
        child: _buildItem(AppIcons.more, context.l10n.home__more_title),
      );

  Widget _buildAvatar() {
    return Obx(
      () => SizedBox(
        height: 0.4.sh,
        child: Stack(children: [
          if (widget.controller.conversation.chatPartner()?.avatarPath !=
                  null &&
              widget.controller.conversation.chatPartner()?.avatarPath != '' &&
              widget.controller.conversation.chatPartner()?.avatarPath !=
                  'null') ...[
            GestureDetector(
              onTap: () {
                showImageDetail();
              },
              child: Image.network(
                widget.controller.conversation.chatPartner()?.avatarPath ?? '',
                height: 0.33.sh,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ] else ...[
            SizedBox(
              height: 0.3.sh,
              width: double.infinity,
              child: Center(
                child: AppIcon(
                  icon: Assets.images.defaultAvatar,
                  size: 120,
                  isCircle: true,
                ),
              ),
            ),
          ],
          Positioned(
            bottom: 0,
            child: GestureDetector(
              onTap: () {
                showImageDetail();
              },
              child: SizedBox(
                width: 1.sw,
                child: Column(
                  // mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: Sizes.s8,
                        left: Sizes.s20,
                        bottom: Sizes.s4,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (widget.controller.conversation.chatPartner() !=
                              null)
                            AppSpacing.gapW4,
                        ],
                      ),
                    ),
                    AppSpacing.gapH8,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.chatHubController.isOnline
                              ? context.l10n.global__online
                              : context.l10n.global__offline,
                          style: AppTextStyles.s14w400.copyWith(
                              color: AppColors.subTextConversationItem),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        AppSpacing.gapW8,
                        Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: widget.chatHubController.isOnline
                                ? AppColors.positive
                                : AppColors.subText2,
                          ),
                        ),
                      ],
                    ),
                    AppSpacing.gapH12,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        _buildItem(
                          // AppIcons.call,
                          Assets.icons.chatRegular.svg(width: 22),
                          context.l10n.chat_title,
                          onTap: () {
                            Get.back();
                          },
                        ),
                        _buildItem(
                          // AppIcons.call,
                          Assets.icons.phoneTranslate.image(width: 22),
                          context.l10n.home__call_title,
                          onTap: () {
                            // widget.controller.onCallVoiceClick();
                            final currentUser = widget.controller.currentUser;
                          },
                        ),
                        _buildItem(
                          AppIcons.video,
                          context.l10n.conversation_resources__tab_video,
                          onTap: () {
                            widget.controller.onCallVideoClick();
                          },
                          size: 16,
                        ),
                        MuteConversationActionWidget(
                            controller: widget.controller),
                        _buildIconMore(context),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  Widget _buildContainerInfo() {
    return GetBuilder<ConversationDetailsController>(builder: (controller) {
      return Obx(
        () => Container(
          margin: AppSpacing.edgeInsetsAll20,
          padding: AppSpacing.edgeInsetsAll16,
          decoration: BoxDecoration(
            color: AppColors.backgroundPinMessage,
            borderRadius: const BorderRadius.all(
              Radius.circular(12),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.l10n.text_username,
                style: AppTextStyles.s14w400.text1Color,
              ),
              AppSpacing.gapH8,
              // const AppDivider(),
              // AppSpacing.gapH8,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      controller.conversation.chatPartner()?.nickname == null
                          ? '@...'
                          : '@${controller.conversation.chatPartner()?.nickname}',
                      style: AppTextStyles.s16w400
                          .toColor(AppColors.contentInfoCard),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  AppIcon(
                    icon: Assets.icons.qrCode,
                    size: Sizes.s20,
                    padding: AppSpacing.edgeInsetsAll8,
                    // onTap: _showQRCodeDialog,
                    onTap: () async {},
                  ),
                ],
              ),

              if (controller.isShowPhone.value) ...[
                AppSpacing.gapH8,
                AppDivider(color: AppColors.dividerInfoCard),
                AppSpacing.gapH8,
                Text(
                  context.l10n.field_phone__label,
                  style: AppTextStyles.s14Base.text1Color,
                ),
                AppSpacing.gapH8,
                Text(
                  (controller.isShowPhone.value)
                      ? (controller.conversation.chatPartner()?.phone ?? '')
                      : '',
                  style:
                      AppTextStyles.s16w400.toColor(AppColors.contentInfoCard),
                ),
                AppSpacing.gapH8,
                AppDivider(color: AppColors.dividerInfoCard),
                AppSpacing.gapH8,
              ],

              Obx(
                () => widget.controller.getPhonePartner().isNotEmpty
                    ? Text(
                        widget.controller.userContactList.isEmpty
                            ? widget.controller.l10n.contacts__empty_btn
                            : widget.controller.l10n.text_edit_contact,
                        style: AppTextStyles.s16w400
                            .toColor(AppColors.contentInfoCard),
                      ).clickable(() {
                        if (widget.controller.userContactList.isEmpty) {
                          final UserContact userContact = UserContact(
                            contactFirstName: '',
                            contactLastName: '',
                            contactPhoneNumber:
                                widget.controller.getPhonePartner(),
                            user: widget.controller.conversation.chatPartner(),
                          );
                          _onAddContact(userContact);
                        } else {
                          _onEditContact(
                            widget.controller.userContactList.first,
                          );
                        }
                      })
                    : const SizedBox.shrink(),
              ),
              // AppSpacing.gapH8,
              // const AppDivider(),
              // AppSpacing.gapH8,
              // GestureDetector(
              //   onTap: () {
              //     widget.controller.onBlockChat(context);
              //   },
              //   child: Row(
              //     children: [
              //       Text(
              //         context.l10n.button__block_user,
              //         style: AppTextStyles.s18w400.toColor(AppColors.button7),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      );
    });
  }

  TabBar _buildTabBarResources() {
    return TabBar(
      unselectedLabelColor: AppColors.subTextConversationItem,
      labelColor: AppColors.contentInfoCard,
      indicatorColor: AppColors.contentInfoCard,
      dividerColor: AppColors.white,
      dividerHeight: 0.1,
      controller: widget.controller.tabController,
      labelPadding: EdgeInsets.zero,
      tabs: [
        Tab(text: context.l10n.conversation_resources__tab_image),
        Tab(text: context.l10n.conversation_resources__tab_video),
        Tab(text: context.l10n.conversation_resources__tab_voice),
        Tab(text: context.l10n.conversation_resources__tab_links),
      ],
    );
  }

  Widget _buildTabBarViewResources() {
    return TabBarView(
      controller: widget.controller.tabController,
      children: [
        _ImageTabView(controller: widget.controller),
        _VideoTabView(controller: widget.controller),
        _VoiceTabView(controller: widget.controller),
        _LinkTabView(controller: widget.controller),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      hideKeyboardWhenTouchOutside: true,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverOverlapAbsorber(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            sliver: Obx(
              () => SliverAppBar(
                backgroundColor: AppColors.white,
                pinned: true,
                expandedHeight: widget.controller.isShowPhone.value ? 600 : 500,
                forceElevated: innerBoxIsScrolled,
                leading: Padding(
                  padding: const EdgeInsets.only(left: Sizes.s16),
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
                flexibleSpace: FlexibleSpaceBar(
                  background: Column(
                    children: [
                      _buildAvatar(),
                      _buildContainerInfo(),
                    ],
                  ),
                ),
                bottom: PreferredSize(
                  preferredSize: _buildTabBarResources().preferredSize,
                  child: Container(
                    color: AppColors.backgroundPinMessage,
                    child: _buildTabBarResources(),
                  ),
                ),
                actions: const [],
              ),
            ),
          ),
        ],
        body: _buildTabBarViewResources(),
      ),
    );
  }

  void _onEditContact(UserContact userContact) {
    Get.toNamed(Routes.addContactNumber, arguments: {
      'user': userContact, // your user contact object
      'isAddContact': false, // or false, depending on your logic
    });
  }

  void _onAddContact(UserContact userContact) {
    Get.toNamed(Routes.addContactNumber, arguments: {
      'user': userContact, // your user contact object
      'isAddContact': true, // or false, depending on your logic
    });

    // showCupertinoModalBottomSheet(
    //   topRadius: const Radius.circular(20),
    //   expand: true,
    //   context: context,
    //   builder: (context) => ContactInfo(
    //     userContact: userContact,
    //     isAddContact: true,
    //     controller: widget.controller,
    //   ),
    // );
  }

  void showImageDetail() {
    Get.generalDialog(
      barrierColor: Colors.black87,
      pageBuilder: (context, animation, secondaryAnimation) {
        return DismissiblePage(
          onDismissed: () => Navigator.of(context).pop(),
          // Start of the optional properties
          isFullScreen: false,
          minRadius: 10,
          maxRadius: 10,
          dragSensitivity: 1.0,
          maxTransformValue: .8,
          direction: DismissiblePageDismissDirection.multi,
          // onDragStart: () {
          //   print('onDragStart');
          // },
          // onDragUpdate: (details) {
          //   print(details);
          // },
          dismissThresholds: const {
            DismissiblePageDismissDirection.vertical: .2,
          },
          minScale: .8,
          reverseDuration: const Duration(milliseconds: 250),
          // End of the optional properties
          child: PhotoViewGallery.builder(
            builder: (BuildContext context, int index) =>
                PhotoViewGalleryPageOptions(
              imageProvider: NetworkImage(
                  widget.controller.conversation.chatPartner()?.avatarPath ??
                      ''),
              maxScale: 4.0,
              minScale: PhotoViewComputedScale.contained,
            ),
            itemCount: 1,
            // loadingBuilder: (context, event) =>
            //     _imageGalleryLoadingBuilder(event),

            scrollPhysics: const ClampingScrollPhysics(),
          ),
        );
      },
    );
  }

  void _showQRCodeDialog() {}
}
