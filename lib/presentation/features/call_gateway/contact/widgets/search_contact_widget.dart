import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/all.dart';
import '../../../../../models/all.dart';
import '../../../../base/all.dart';
import '../../../../common_widgets/all.dart';
import '../../../../resource/gen/assets.gen.dart';
import '../../../../resource/styles/styles.dart';
import '../../../../routing/routers/app_pages.dart';
import '../all.dart';

class SearchContactWidget extends BaseView<ContactController> {
  const SearchContactWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.s16,
              vertical: Sizes.s16,
            ),
            child: buildAppBar(context),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.s16,
            ),
            child: CustomSearchBar(
              hintText: context.l10n.global__search,
              onClear: () {
                controller.searchContact('');
              },
              prefixIcon: AppIcon(
                icon: AppIcons.searchLg,
                color: AppColors.label1Color,
              ),
              onChanged: (value) {
                controller.changeSearching = value.isNotEmpty;

                controller.searchContact(value);
              },
            ),
          ),
          buildListContact(context),
        ],
      ),
    );
  }

  Widget buildAppBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: AppIcon(icon: AppIcons.arrowLeft),
        ),
        Text(
          l10n.contact__search_contacts,
          style: AppTextStyles.s20w600,
        ),
        const SizedBox(
          width: 16,
        ),
      ],
    );
  }

  Widget buildListContact(BuildContext context) {
    return Obx(
      () => Expanded(
        child: controller.isSearching.value
            ? ListView.builder(
                padding:
                    const EdgeInsets.only(top: Sizes.s16, bottom: Sizes.s16),
                itemCount: controller.contactsSearching.length,
                itemBuilder: (context, index) {
                  final user = controller.contactsSearching[index];

                  return _buildItemContact(
                    user: user,
                    isLast: index == controller.usersList.length - 1,
                    context: context,
                  );
                },
              )
            : ListView.builder(
                padding:
                    const EdgeInsets.only(top: Sizes.s16, bottom: Sizes.s16),
                itemCount: controller.usersList.length,
                itemBuilder: (context, index) {
                  final user = controller.usersList[index];

                  return _buildItemContact(
                    user: user,
                    isLast: index == controller.usersList.length - 1,
                    context: context,
                  );
                },
              ),
      ),
    );
  }

  Widget _buildItemContact({
    required UserContact user,
    required BuildContext context,
    bool isLast = false,
  }) {
    var name = user.fullName.removeAllWhitespace.isNotEmpty
        ? user.fullName
        : user.user?.fullName ?? '';

    if (name.isEmpty) {
      name = user.contactPhoneNumber;
    }
    final Widget header = Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Sizes.s16,
      ),
      child: Row(
        children: [
          AppCircleAvatar(
            url: user.contactAvatarPath ?? '',
            size: Sizes.s48,
          ),
          const SizedBox(width: Sizes.s8),
          Expanded(
            child: Text(
              name,
              style: AppTextStyles.s16w500.copyWith(color: AppColors.text1),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );

    return GetBuilder<ContactController>(
      init: controller,
      builder: (controller) {
        return GestureDetector(
          onTap: () {
            // controller.updateExpanded(user);
            controller.goToPrivateChat(user);
          },
          child: Container(
            decoration: BoxDecoration(
              color: user.isExpanded
                  ? const Color(0xff9493AC).withOpacity(0.08)
                  : Colors.transparent,
            ),
            child: Column(
              children: [
                AppSpacing.gapH12,
                header,
                AnimatedCrossFade(
                  firstChild: Container(height: 0.0),
                  secondChild: _buildExpandedItemContact(
                    user: user,
                    isLast: isLast,
                    context: context,
                  ),
                  firstCurve: const Interval(
                    0.0,
                    0.6,
                    curve: Curves.fastOutSlowIn,
                  ),
                  secondCurve: const Interval(
                    0.4,
                    1.0,
                    curve: Curves.fastOutSlowIn,
                  ),
                  sizeCurve: Curves.fastOutSlowIn,
                  crossFadeState: user.isExpanded
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                  duration: const Duration(milliseconds: 300),
                ),
                AppSpacing.gapH12,
                if (user.isExpanded) ...[
                  Divider(
                    color: AppColors.border1,
                    height: 1,
                  ),
                ] else ...[
                  if (!isLast) ...[
                    Divider(
                      color: AppColors.border1,
                      height: 1,
                      indent: 64,
                    ),
                  ],
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildExpandedItemContact({
    required UserContact user,
    required BuildContext context,
    bool isLast = false,
  }) {
    final isShowPhone = user.user?.isShowPhone ?? true;
    return Padding(
      padding: const EdgeInsets.only(
        left: 68,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppSpacing.gapH4,
          if (isShowPhone) ...[
            Text(
              user.contactPhoneNumber,
              style: AppTextStyles.s16w500.copyWith(color: AppColors.text1),
            ),
            AppSpacing.gapH4,
          ],
          Row(
            children: [
              // GestureDetector(
              //   onTap: () {
              //     controller.onCallVoice(user);
              //   },
              //   child: Container(
              //     padding: const EdgeInsets.all(Sizes.s8),
              //     decoration: const BoxDecoration(
              //       shape: BoxShape.circle,
              //       border: Border.fromBorderSide(
              //         BorderSide(color: Color(0xff252531), width: 2),
              //       ),
              //     ),
              //     child: AppIcon(icon: AppIcons.call),
              //   ),
              // ),
              GestureDetector(
                onTap: () {
                  controller.confirmCallTranslate(user);
                },
                child: Container(
                  padding: const EdgeInsets.all(Sizes.s8),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.fromBorderSide(
                      BorderSide(color: AppColors.subText3, width: 2),
                    ),
                  ),
                  child: AppIcon(
                    icon: Assets.icons.phoneTranslate.image(
                      width: 24,
                      height: 24,
                      color: AppColors.button5,
                    ),
                  ),
                ),
              ),
              AppSpacing.gapW24,
              GestureDetector(
                onTap: () {
                  controller.onVideoCall(user);
                },
                child: Container(
                  padding: const EdgeInsets.all(Sizes.s8),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.fromBorderSide(
                      BorderSide(color: AppColors.subText3, width: 2),
                    ),
                  ),
                  child: AppIcon(
                    icon: AppIcons.video,
                    color: AppColors.button5,
                  ),
                ),
              ),
              AppSpacing.gapW24,
              GestureDetector(
                onTap: () {
                  controller.goToPrivateChat(user);
                },
                child: Container(
                  padding: const EdgeInsets.all(Sizes.s8),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.fromBorderSide(
                      BorderSide(color: AppColors.subText3, width: 2),
                    ),
                  ),
                  child: AppIcon(
                    icon: AppIcons.message,
                    color: AppColors.button5,
                  ),
                ),
              ),
              // if (user.isExpanded)

              AppSpacing.gapW24,
              GestureDetector(
                onTap: () async {
                  _onEditContact(user, context);
                },
                child: Container(
                  padding: const EdgeInsets.all(Sizes.s8),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.fromBorderSide(
                      BorderSide(color: AppColors.subText3, width: 2),
                    ),
                  ),
                  child: AppIcon(
                    icon: AppIcons.edit,
                    color: AppColors.button5,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _onEditContact(UserContact userContact, BuildContext context) {
    Get.toNamed(Routes.addContactNumber, arguments: {
      'user': userContact, // your user contact object
      'isAddContact': false, // or false, depending on your logic
    });

    // showCupertinoModalBottomSheet(
    //   topRadius: const Radius.circular(20),
    //   expand: true,
    //   context: context,
    //   builder: (context) => ContactInfoHistory(
    //     userContact: userContact,
    //     isEditContact: true,
    //     controller: Get.find<CallHistoryController>(),
    //   ),
    // );
  }
}
