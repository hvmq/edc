import 'package:flutter/material.dart' hide SearchController;
import 'package:get/get.dart';

import '../../../../core/all.dart';
import '../../../../models/user.dart';
import '../../../base/all.dart';
import '../../../common_widgets/all.dart';
import '../../../resource/resource.dart';
import '../../../routing/routing.dart';
import '../../all.dart';
import 'widgets/_user_item.dart';

class SearchInfoView extends BaseView<SearchInfoController> {
  const SearchInfoView({
    required this.type,
    Key? key,
    this.bindingCreator,
  }) : super(key: key);

  final SearchInfoBinding Function()? bindingCreator;
  final String type;

  void _createBinding() {
    final Bindings? binding = bindingCreator?.call();
    binding?.dependencies();
  }

  void _onUserTapped(User user) {
    if (type == 'message') {
      controller.goToPrivateChat(user);
    } else {
      Get.back();
      Get.toNamed(
        Routes.posterPersonal,
        arguments: {'user': user},
      );
    }
  }

  @override
  Widget buildPage(BuildContext context) {
    _createBinding();

    return CommonScaffold(
      // applyAutoPaddingBottom: true,
      hideKeyboardWhenTouchOutside: true,
      // backgroundColor: Colors.transparent,
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
    // return _buildBody();
  }

  CommonAppBar _buildAppBar() {
    return CommonAppBar(
      text: l10n.search__title,
      titleType: AppBarTitle.text,
      titleTextStyle: AppTextStyles.s20w600.text5Color,
      leadingIconColor: AppColors.button5,
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: AppSpacing.edgeInsetsH20,
      child: Column(
        children: [
          _buildSearchField(),
          AppSpacing.gapH8,
          Expanded(child: _buildSearchResult()),
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    return CustomSearchBar(
      hintText: type == 'message' ? l10n.search__placeholder : 'Search',
      onChanged: controller.search,
      autofocus: false,
    );
  }

  Widget _buildSearchResult() {
    return Obx(
      () {
        if (controller.users.isEmpty && controller.conversations.isEmpty) {
          return _buildEmptyResult();
        }

        return SingleChildScrollView(
          child: Column(
            children: [
              if (type == 'message') _buildConversationsList(),
              _buildUsersList(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildEmptyResult() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppIcon(
          icon: AppIcons.search,
          size: Sizes.s48,
          color: AppColors.subText2,
        ),
        AppSpacing.gapH20,
        Text(
          l10n.search__no_result,
          style: AppTextStyles.s18w500.subText2Color,
        ),
      ],
    );
  }

  Widget _buildConversationsList() {
    if (controller.conversations.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.search__conversations_label,
          style: AppTextStyles.s16w500,
        ),
        AppSpacing.gapH8,
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.conversations.length,
          itemBuilder: (context, index) {
            final conversation = controller.conversations[index];

            return ConversationItem(
              key: ValueKey(conversation.id),
              conversation: conversation,
              showChildOnly: true,
              contentPadding: EdgeInsets.zero,
              beforeGoToChat: Get.back,
            );
          },
        ),
      ],
    );
  }

  Widget _buildUsersList() {
    if (controller.users.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.search__users_label,
          style: AppTextStyles.s16w500,
        ),
        AppSpacing.gapH8,
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.users.length,
          separatorBuilder: (context, index) => const Padding(
            padding: EdgeInsets.only(left: Sizes.s56),
            child: Divider(thickness: 0.5, color: AppColors.bodyText1),
          ),
          itemBuilder: (context, index) {
            final user = controller.users[index];

            return UserItem(
              key: ValueKey(user.id),
              user: user,
              onTap: () => _onUserTapped(user),
            );
          },
        ),
        AppSpacing.gapH20,
      ],
    );
  }
}
