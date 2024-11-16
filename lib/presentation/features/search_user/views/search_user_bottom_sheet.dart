import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/all.dart';
import '../../../../models/all.dart';
import '../../../common_widgets/all.dart';
import '../../../resource/resource.dart';
import '../controllers/search_user_controller.dart';
import 'widgets/_user_item.dart';

class CreateChatSearchUsersBottomSheet extends StatefulWidget {
  const CreateChatSearchUsersBottomSheet({
    Key? key,
    this.allowSelectMultiple = true,
    this.title,
    this.hintText,
  }) : super(key: key);

  final bool allowSelectMultiple;
  final String? title;
  final String? hintText;

  @override
  State<CreateChatSearchUsersBottomSheet> createState() =>
      _CreateChatSearchUsersBottomSheetState();
}

class _CreateChatSearchUsersBottomSheetState
    extends State<CreateChatSearchUsersBottomSheet> {
  bool _isCreatingGroup = false;

  void _onCreateGroup() {
    setState(() {
      _isCreatingGroup = true;
    });
  }

  final List<User> _selectedUsers = [];

  void _onSelected(User user) {
    if (!_isCreatingGroup) {
      Get.back(result: [user]);
    }

    setState(() {
      _selectedUsers.contains(user)
          ? _selectedUsers.remove(user)
          : _selectedUsers.add(user);
    });
  }

  void _onSubmit() {
    Get.back(result: _selectedUsers);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: SearchUserController(),
      builder: (controller) {
        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.s32,
            vertical: Sizes.s28,
          ),
          decoration: const BoxDecoration(color: AppColors.white),
          child: Column(
            children: [
              _buildHeader(context),
              AppSpacing.gapH20,
              _buildSearchField(context, controller),
              AppSpacing.gapH20,
              if (widget.allowSelectMultiple) _buildCreateGroupButton(context),
              AppSpacing.gapH20,
              Obx(
                () => controller.isSearching.value
                    ? const Expanded(
                        child: Center(
                          child: AppDefaultLoading(
                            color: AppColors.button5,
                          ),
                        ),
                      )
                    : Expanded(
                        child: Obx(
                          () => ListView.separated(
                            itemCount: controller.users.length,
                            separatorBuilder: (context, index) => const Padding(
                              padding: EdgeInsets.only(left: Sizes.s56),
                              child: Divider(
                                height: Sizes.s20,
                                thickness: 0.5,
                                color: AppColors.subText2,
                              ),
                            ),
                            itemBuilder: (context, index) {
                              final user = controller.users[index];

                              return UserItem(
                                key: ValueKey(user.id),
                                user: user,
                                isSelected: _selectedUsers.contains(user),
                                isSelectable: _isCreatingGroup,
                                onTap: () => _onSelected(user),
                              );
                            },
                          ),
                        ),
                      ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          context.l10n.button__cancel,
          style: AppTextStyles.s16w400.text5Color,
        ).clickable(Get.back),
        Padding(
          padding: AppSpacing.edgeInsetsH8,
          child: Text(
            widget.title ?? context.l10n.chat_create__title,
            style: AppTextStyles.s20w600.text5Color,
          ),
        ),
        Opacity(
          opacity: _isCreatingGroup ? 1 : 0,
          child: IgnorePointer(
            ignoring: !_isCreatingGroup,
            child: Text(
              context.l10n.button__create,
              style: AppTextStyles.s16w400.toColor(
                _selectedUsers.isNotEmpty
                    ? AppColors.button5
                    : AppColors.subText2,
              ),
            ).clickable(_onSubmit),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchField(
    BuildContext context,
    SearchUserController controller,
  ) {
    return CustomSearchBar(
      hintText: widget.hintText ?? context.l10n.chat_create__search_hint,
      onChanged: controller.searchUser,
      prefixIcon: AppIcon(
        icon: AppIcons.create,
        color: AppColors.button5,
      ),
    );
  }

  Widget _buildCreateGroupButton(BuildContext context) {
    if (_isCreatingGroup) {
      return AppSpacing.emptyBox;
    }

    return Row(
      children: [
        AppIcon(
          isCircle: true,
          icon: AppIcons.group,
          color: Colors.black,
        ),
        AppSpacing.gapW12,
        Text(
          context.l10n.chat_create__create_group_label,
          style: AppTextStyles.s16w400,
        ),
      ],
    ).clickable(_onCreateGroup);
  }
}
