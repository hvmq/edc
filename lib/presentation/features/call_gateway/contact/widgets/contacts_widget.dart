import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/all.dart';
import '../../../../../models/all.dart';
import '../../../../base/all.dart';
import '../../../../common_widgets/all.dart';
import '../../../../resource/resource.dart';
import '../../../../routing/routers/app_pages.dart';
import '../all.dart';

class ContactsWidget extends BaseView<ContactController> {
  const ContactsWidget({super.key});

  @override
  Widget buildPage(BuildContext context) {
    // if (controller.usersList.isEmpty) {
    //   return buildNoContacts(context);
    // }

    return Obx(
      () => RefreshIndicator(
        onRefresh: () async {
          controller.getUserContacts(isLoading: false);
        },
        child: controller.usersList.isEmpty
            ? buildNoContacts(context)
            : Column(
                children: [
                  AppSpacing.gapH16,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: CustomSearchBar(
                      autofocus: false,
                      hintText: l10n.global__search,
                      onChanged: (value) {
                        controller.searchUser(value);
                      },
                    ),
                  ),
                  AppSpacing.gapH16,
                  Expanded(
                      child: ListView.builder(
                          itemCount: controller.searchResults.length,
                          itemBuilder: (context, index) {
                            final item = controller.searchResults[index];
                            return Column(
                              children: [
                                _buildItemContact(
                                  user: item,
                                  isLast: controller.usersList.indexWhere(
                                          (element) => element == item) ==
                                      controller.usersList.length - 1,
                                  context: context,
                                ),
                                if (index !=
                                    controller.usersList.length - 1) ...[
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 16),
                                    child: AppDivider(
                                      color: AppColors.divider,
                                    ),
                                  ),
                                ],
                              ],
                            );
                          })),
                ],
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
        : ((user.user == null)
            ? user.contactPhoneNumber
            : (user.user?.fullName ?? ''));
    if (name == '') {
      name = user.user?.fullName ?? '';
    }

    final Widget header = Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Sizes.s20,
      ),
      child: Row(
        children: [
          AppCircleAvatar(
            url: user.contactAvatarPath ?? '',
            size: Sizes.s48,
          ),
          const SizedBox(width: Sizes.s16),
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
                // AppSpacing.gapH12,
                // if (user.isExpanded) ...[
                //   Divider(
                //     color: AppColors.border1,
                //     height: 1,
                //   ),
                // ] else ...[
                //   if (!isLast) ...[
                //     Divider(
                //       color: AppColors.border3,
                //       height: 1,
                //       indent: 64,
                //     ),
                //   ],
                // ],
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
              //         BorderSide(color: AppColors.subText3, width: 2),
              //       ),
              //     ),
              //     child: AppIcon(
              //       icon: AppIcons.call,
              //       color: AppColors.button5,
              //     ),
              //   ),
              // ),
              // AppSpacing.gapW24,
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
                    color: AppColors.button5,
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

    Get.toNamed(Routes.addContactNumber, arguments: {
      'user': userContact, // your user contact object
      'isAddContact': false, // or false, depending on your logic
    });
  }

  Widget buildNoContacts(
    BuildContext context,
  ) {
    return ListView(
      padding: const EdgeInsets.all(Sizes.s16),
      children: [
        // AppIcon(
        //   icon: AppIcons.noContact,
        //   size: 280,
        // ),
        AppSpacing.gapH16,
        Text(
          context.l10n.contacts__empty_title,
          style: AppTextStyles.s16w500.copyWith(
            fontSize: 24,
            color: AppColors.white,
          ),
          textAlign: TextAlign.center,
        ),
        AppSpacing.gapH24,
        Text(
          context.l10n.contacts__empty_content,
          style: AppTextStyles.s14w400.copyWith(
            color: AppColors.bodyText1,
          ),
          textAlign: TextAlign.center,
        ),
        AppSpacing.gapH24,
        AppButton.secondary(
          label: context.l10n.contacts__empty_btn,
          color: AppColors.button5,
          width: double.infinity,
          onPressed: () {
            showBottomSheetAddContacts(context);
          },
        ),
      ],
    );
  }

  void showBottomSheetAddContacts(BuildContext context) {
    // showCupertinoModalBottomSheet(
    //   topRadius: const Radius.circular(20),
    //   expand: true,
    //   context: context,
    //   builder: (context) => BottomSheetAddContacts(
    //     controller: controller,
    //   ),
    // ).then((value) {
    //   controller.resetAvatarFile();
    // });

    Get.toNamed(
      Routes.addContactNumber,
      arguments: {
        'user': null, // your user contact object
        'isAddContact': true, // or false, depending on your logic
      },
    );
  }
}
