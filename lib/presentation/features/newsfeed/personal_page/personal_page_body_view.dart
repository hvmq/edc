import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../../core/all.dart';
import '../../../base/all.dart';
import '../../../common_widgets/all.dart';
import '../../../resource/resource.dart';
import '../../../routing/routers/app_pages.dart';
import '../widgets/invite_link_widget.dart';
import 'bottom_sheet_list_of_nfts.dart';
import 'personal_page_controller.dart';
import 'profile_language_view.dart';

class PersonalPageView extends BaseView<PersonalPageController> {
  const PersonalPageView({super.key});

  @override
  Widget buildPage(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        controller.onRefreshManaMission();
      },
      child: Stack(
        children: [
          CustomScrollView(
            physics: const ClampingScrollPhysics(),
            controller: controller.scroll,
            slivers: [
              SliverToBoxAdapter(
                child: Stack(
                  children: [
                    SizedBox(
                      height: 1250.h,
                    ),
                    _nftCard(context),
                    Positioned(
                      top: 180,
                      child: Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(
                                20.0), // Bán kính làm tròn góc trên bên trái
                            topRight: Radius.circular(
                                20.0), // Bán kính làm tròn góc trên bên phải
                          ),
                        ),
                        child: Column(
                          children: [
                            _userInfo(context),
                            _optionWidget(context)
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 130,
                      right: 20,
                      child: _avatarWidget(context),
                    ),
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: controller.isLoadingLoadMore.value
                    ? const Center(
                        child: AppDefaultLoading(
                          color: AppColors.white,
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget changePasswordWidget() {
    return Obx(
      () => _buildItem(
        color: AppColors.button5,
        icon: AppIcons.lock,
        title: controller.codeRx.value == 'match'
            ? l10n.setting__create_password
            : l10n.change_pass,
        onTap: () {
          if (controller.codeRx.value == 'match') {
            Get.toNamed(Routes.resetPassword, arguments: {
              'flowFrom': 'register',
              'phone': controller.currentUser.phone
            })!
                .then((value) => {
                      controller.setCodeRx(),
                      ViewUtil.showToast(
                        title: l10n.setting__success,
                        message: l10n.setting__password_created_successfully,
                      )
                    });
          } else {
            Get.toNamed(Routes.resetPassword, arguments: {
              'flowFrom': 'change',
              'phone': controller.currentUser.phone
            });
          }
        },
      ),
    );
  }

  Widget _buildItem({
    required Object icon,
    required String title,
    required VoidCallback onTap,
    bool isDivider = true,
    Color color = AppColors.text1,
    bool isTranslate = false,
  }) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    isTranslate
                        ? Padding(
                            padding: const EdgeInsets.only(right: 2),
                            child: Assets.icons.translation.svg(
                              width: 22,
                              color: Colors.white,
                            ),
                          )
                        : AppIcon(
                            icon: icon,
                            color: color,
                          ),
                    AppSpacing.gapW12,
                    Text(
                      title,
                      style: AppTextStyles.s20w600,
                    ),
                  ],
                ),
              ),
              AppIcon(
                icon: AppIcons.arrowRight,
                color: AppColors.subTextConversationItem,
              )
            ],
          ),
        ],
      ),
    );
  }

  void showBottomSheetListOfNFTs(BuildContext context) =>
      showCupertinoModalBottomSheet(
        expand: true,
        context: context,
        topRadius: const Radius.circular(20),
        builder: (context) => const BottomSheetListOfNFTs(),
      );

  void _buildDeleteAccount() {
    Get.bottomSheet(
      isScrollControlled: true,
      Obx(
        () => Form(
          key: controller.formKey,
          child: Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: AppColors.background10,
              ),
              borderRadius: BorderRadius.circular(30.r),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(width: Sizes.s24),
                    Center(
                      child: Text(
                        l10n.setting__delete_account,
                        style: AppTextStyles.s20w600,
                      ),
                    ),
                    AppIcon(
                      icon: AppIcons.close,
                      color: AppColors.subText2,
                      onTap: Get.back,
                    ),
                  ],
                ),
                const SizedBox(
                  height: Sizes.s16,
                ),
                Column(
                  children: [
                    AppCircleAvatar(
                      url: currentUser.avatarPath ?? '',
                      size: 80,
                    ),
                    const SizedBox(height: Sizes.s12),
                    Text(
                      (currentUser.nickname ?? '').isNotEmpty
                          ? currentUser.nickname!
                          : currentUser.fullName,
                      style: AppTextStyles.s16w600,
                    ),
                    const SizedBox(height: Sizes.s12),
                    Text(
                      l10n.setting__delete_account_message,
                      style: AppTextStyles.s12w400.copyWith(
                        color: AppColors.subText2,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: Sizes.s16,
                ),
                AppTextField(
                  controller: controller.deleteController,
                  validator: (value) {
                    if (value != null && value.isEmpty) {
                      return l10n.field__delete_account_empty;
                    }

                    return null;
                  },
                  border: const OutlineInputBorder(
                    borderSide:
                        BorderSide(color: AppColors.border2, width: 0.5),
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                  ),
                ),
                const SizedBox(height: Sizes.s24),
                AppButton.secondary(
                  color: AppColors.button5,
                  label: l10n.button__delete,
                  width: double.infinity,
                  onPressed: () async {
                    if (!controller.isLoadingBtnDeleteAccount.value) {
                      await controller.deleteAccount();
                    }
                  },
                ),
              ],
            ).paddingAll(20),
          ),
        ),
      ),
    );
  }

  void showQRCodeDialog(BuildContext context) {
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
                    ViewUtil.copyToClipboard(controller.shareLink.value)
                        .then((_) {
                      ViewUtil.showAppSnackBar(
                        context,
                        context.l10n.global__copied_to_clipboard,
                      );
                    });
                  },
                  child: Text(
                    controller.shareLink.value,
                    style: AppTextStyles.s16w500.text5Color,
                  ),
                ),
                AppSpacing.gapH16,
                AppQrCodeView(
                  controller.shareLink.value,
                  size: 300.w,
                ).clickable(() {}),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _nftCard(BuildContext context) {
    return Container(
      width: 1.sw,
      height: 200,
      color: Colors.amber,
      child: Stack(
        children: [
          Assets.images.cardNumber.image(width: 1.sw, fit: BoxFit.fitWidth),
          Positioned(
              top: MediaQuery.of(context).viewPadding.top + 16,
              width: 1.sw,
              child: Container(
                padding: const EdgeInsets.only(right: 20, left: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Assets.icons.qrCode
                            .svg(color: AppColors.white)
                            .clickable(() {
                          Get.to(
                            () => InviteLinkWidget(
                              link: controller.shareLink.value,
                              name: currentUser.fullName,
                            ),
                            transition: Transition.cupertino,
                          );
                        }),
                      ],
                    ),
                    AppSpacing.gapH12,
                    Text(
                      '${l10n.field_phone__label}: ${currentUser.phone}',
                      style: AppTextStyles.s16w600
                          .copyWith(color: AppColors.white),
                    ),
                    // AppSpacing.gapH12,
                    // Text(
                    //   '${l10n.field_phone__label}: ${currentUser.phone}',
                    //   style: AppTextStyles.s16w600
                    //       .copyWith(color: AppColors.white),
                    // ),
                    AppSpacing.gapH12,
                    if (!(currentUser.email ?? '')
                        .contains('privaterelay.appleid.com'))
                      Text(
                        currentUser.email ?? '',
                        style: AppTextStyles.s16w400
                            .copyWith(color: AppColors.white),
                      ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _avatarWidget(BuildContext context) {
    return AppCircleAvatar(
      url: currentUser.avatarPath ?? '',
      size: 100.w,
      clickToSeeFullImage: true,
    );
  }

  Widget _userInfo(BuildContext context) {
    return Container(
      width: 1.sw,
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0), // Bán kính làm tròn góc trên bên trái
          topRight:
              Radius.circular(20.0), // Bán kính làm tròn góc trên bên phải
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppSpacing.gapH12,
          Row(
            children: [
              Text(
                currentUser.fullName,
                style: AppTextStyles.s20w500.copyWith(color: AppColors.text1),
              ),
              AppSpacing.gapW12,
              Assets.icons.profileEditSvg_
                  .svg(color: AppColors.subTextConversationItem)
                  .clickable(() {
                Get.toNamed(
                  Routes.profile,
                  arguments: {'isUpdateProfileFirstLogin': false},
                );
              }),
            ],
          ),
          // AppSpacing.gapH12,
          // Row(
          //   children: [
          //     Text(
          //       currentUser.pinNumber ?? '',
          //       style: AppTextStyles.s14w400
          //           .copyWith(color: AppColors.subTextConversationItem),
          //     ),
          //     AppSpacing.gapW12,
          //     Assets.icons.copy.svg(color: AppColors.subTextConversationItem),
          //   ],
          // ),
          AppSpacing.gapH12,
          Text(
            '${l10n.field_phone__label}: ${currentUser.phone}',
            style: AppTextStyles.s14w400
                .copyWith(color: AppColors.subTextConversationItem),
          ),
          AppSpacing.gapH12,
          // gender location
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(29)),
                child: Row(
                  children: [
                    const Icon(
                      Icons.male,
                      color: AppColors.white,
                      size: 16,
                    ),
                    AppSpacing.gapW4,
                    Text(
                      '25',
                      style: AppTextStyles.s14w400
                          .copyWith(color: AppColors.text2),
                    )
                  ],
                ),
              ),
              AppSpacing.gapW8,
              const Icon(
                Icons.location_pin,
                color: AppColors.green1,
              ),
              AppSpacing.gapW4,
              Text(
                'Ho Chi Minh',
                style: AppTextStyles.s14w400.copyWith(color: AppColors.text1),
              )
            ],
          ),
          AppSpacing.gapH32,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    '500.000',
                    style:
                        AppTextStyles.s20w600.copyWith(color: AppColors.text1),
                  ),
                  AppSpacing.gapH16,
                  Row(
                    children: [
                      Text(
                        'EDC Neutron',
                        style: AppTextStyles.s16w400
                            .copyWith(color: AppColors.subTextConversationItem),
                      ),
                      AppSpacing.gapW12,
                      Assets.icons.profileEdcNeutron.image(),
                    ],
                  )
                ],
              ),
              Column(
                children: [
                  Text(
                    '500.000',
                    style:
                        AppTextStyles.s20w600.copyWith(color: AppColors.text1),
                  ),
                  AppSpacing.gapH16,
                  Row(
                    children: [
                      Text(
                        'EDC Token',
                        style: AppTextStyles.s16w400
                            .copyWith(color: AppColors.subTextConversationItem),
                      ),
                      AppSpacing.gapW12,
                      Assets.icons.profileEdcToken.image(),
                    ],
                  )
                ],
              ),
              Column(
                children: [
                  Text(
                    '500.000',
                    style:
                        AppTextStyles.s20w600.copyWith(color: AppColors.text1),
                  ),
                  AppSpacing.gapH16,
                  Row(
                    children: [
                      Text(
                        'USDT',
                        style: AppTextStyles.s16w400
                            .copyWith(color: AppColors.subTextConversationItem),
                      ),
                      AppSpacing.gapW12,
                      Assets.icons.profileUsdt.image(),
                    ],
                  )
                ],
              ),
            ],
          ),
          AppSpacing.gapH28,
          Row(
            children: [
              SizedBox(
                width: 1.sw - 40,
                child: AppButton.secondary(
                    isAnimation: false,
                    label: l10n.profile__edit,
                    width: double.infinity,
                    color: AppColors.button5,
                    textStyleLabel:
                        AppTextStyles.s14w400.copyWith(color: AppColors.text2),
                    onPressed: () {
                      Get.toNamed(
                        Routes.profile,
                        arguments: {'isUpdateProfileFirstLogin': false},
                      );
                    }),
              )
            ],
          ),
          AppSpacing.gapH28,

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: AppColors.backgroundPinMessage,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.profile__course,
                        style: AppTextStyles.s16w400
                            .copyWith(color: AppColors.subTextConversationItem),
                      ),
                      AppSpacing.gapH12,
                      Text(
                        '20',
                        style: AppTextStyles.s20w600,
                      ),
                      AppSpacing.gapH12,
                      Row(
                        children: [
                          Text(
                            l10n.profile__educhain,
                            style: AppTextStyles.s16w400.copyWith(
                                color: AppColors.subTextConversationItem),
                          ),
                          const Spacer(),
                          AppIcon(
                            icon: AppIcons.arrowRight,
                            color: AppColors.subTextConversationItem,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 16.0), // Khoảng cách giữa hai container
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: AppColors.backgroundPinMessage,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.profile__books,
                        style: AppTextStyles.s16w400
                            .copyWith(color: AppColors.subTextConversationItem),
                      ),
                      AppSpacing.gapH12,
                      Text(
                        '20',
                        style: AppTextStyles.s20w600,
                      ),
                      AppSpacing.gapH12,
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              l10n.profile__lib,
                              style: AppTextStyles.s16w400.copyWith(
                                  color: AppColors.subTextConversationItem),
                            ),
                          ),
                          AppIcon(
                            icon: AppIcons.arrowRight,
                            color: AppColors.subTextConversationItem,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          AppSpacing.gapH20,
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: AppColors.backgroundPinMessage,
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.profile__your_nft,
                      style: AppTextStyles.s16w400
                          .copyWith(color: AppColors.subTextConversationItem),
                    ),
                    AppSpacing.gapH12,
                    Text(
                      currentUser.phone ?? '',
                      style: AppTextStyles.s20w600,
                    )
                  ],
                ),
                Container(
                  decoration: const BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.all(Radius.circular(51))),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 28, vertical: 9),
                  child: Row(
                    children: [
                      Text(
                        l10n.profile__change,
                        style: AppTextStyles.s14w400
                            .copyWith(color: AppColors.text2),
                      ),
                      AppSpacing.gapW8,
                      Assets.icons.changeButton.svg(color: AppColors.text2),
                    ],
                  ),
                ).clickable(() {
                  showBottomSheetListOfNFTs(context);
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _optionWidget(BuildContext context) {
    return Container(
      width: 1.sw,
      color: AppColors.backgroundPinMessage,
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          builditemSetting(
              Assets.icons.profileGoToWebDapp.image(),
              const Color(0xff1fbb83),
              l10n.personal_page__go_to_web_dapp,
              () {}),
          Padding(
            padding: AppSpacing.edgeInsetsV16,
            child: AppDivider(color: AppColors.dividerOptionProfile),
          ),
          builditemSetting(Assets.icons.profileLanguageSetting.image(),
              const Color(0xff52C91D), l10n.language__language, () {
            Get.to(() => ProfileLanguageView(
                  languageCode: controller.currentUser.talkLanguage ?? '',
                  idUser: 0,
                  type: 'setting',
                  personalPageController: controller,
                  currentUser: currentUser,
                ));
          }),
          Padding(
            padding: AppSpacing.edgeInsetsV16,
            child: AppDivider(color: AppColors.dividerOptionProfile),
          ),
          builditemSetting(
              Assets.icons.profilePolicyTerm.image(),
              const Color(0xfffe7a00),
              l10n.personal_page__policy_and_terms,
              () {}),
          Padding(
            padding: AppSpacing.edgeInsetsV16,
            child: AppDivider(color: AppColors.dividerOptionProfile),
          ),
          builditemSetting(Assets.icons.profileSetting, AppColors.alertIcon,
              l10n.setting__title, () {
            Get.toNamed(Routes.setting);
          }),
          Padding(
            padding: AppSpacing.edgeInsetsV16,
            child: AppDivider(color: AppColors.dividerOptionProfile),
          ),
          builditemSetting(Assets.icons.profileLogout.image(),
              const Color(0xffff4040), l10n.personal_page__log_out, () {
            controller.logout();
          }),
        ],
      ),
    );
  }

  Widget builditemSetting(
          Object icon, Color color, String title, Function() onTap) =>
      Row(
        children: [
          AppIcon(
            icon: icon,
            color: color,
          ),
          AppSpacing.gapW12,
          Text(
            title,
            style: AppTextStyles.s20w600,
          ),
          const Spacer(),
          AppIcon(
            icon: AppIcons.arrowRight,
            color: AppColors.subTextConversationItem,
          )
        ],
      ).clickable(() {
        onTap();
      });
}
