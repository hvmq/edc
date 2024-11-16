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
import 'bottom_sheet_list_of_nfts.dart';
import 'personal_page_controller.dart';
import 'profile_language_view.dart';
import 'profile_talk_language_view.dart';
import 'widgets/mana_mission_widget.dart';

class PersonalPageBusinessView extends BaseView<PersonalPageController> {
  const PersonalPageBusinessView({super.key});

  @override
  Widget buildPage(BuildContext context) {
    Widget builditemSetting(
            Object icon, Color color, String title, Function() onTap) =>
        Row(
          children: [
            AppIcon(
              icon: icon,
              color: color,
            ),
            AppSpacing.gapW12,
            Text(title, style: AppTextStyles.s16w600.text2Color),
            const Spacer(),
            AppIcon(
              icon: AppIcons.arrowRight,
              color: AppColors.text2,
            )
          ],
        ).clickable(() {
          onTap();
        });

    return RefreshIndicator(
      onRefresh: () async {
        controller.onRefreshManaMission();
      },
      child: SingleChildScrollView(
        child: Stack(
          children: [
            Transform.translate(
              offset: Offset(0, 0.1.sw),
              child: Assets.images.backgroundBusiness
                  .image(fit: BoxFit.fitWidth, width: double.infinity),
            ),
            Assets.images.nftVip
                .image(fit: BoxFit.fitWidth, width: double.infinity),
            SafeArea(
              child: Container(
                margin: EdgeInsets.only(top: 0.27.sw + 32),
                child: CustomPaint(
                  size: Size(1.sw, 100),
                  painter: DiagonalPainter(),
                ),
              ),
            ),
            SafeArea(
              child: Container(
                height: 1.sh,
                margin: EdgeInsets.only(top: 0.27.sw + 32 + 99),
                color: AppColors.blue4,
              ),
            ),
            SafeArea(
              child: Column(
                children: [
                  Row(
                    children: [
                      Obx(
                        () => controller.shareLink.value != ''
                            ? AppIcon(
                                icon: Icons.qr_code,
                                color: AppColors.white,
                                onTap: () => showQRCodeDialog(context),
                              )
                            : AppSpacing.emptyBox,
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          Container(
                            padding: AppSpacing.edgeInsetsAll8,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: AppColors.white),
                            child: const AppIcon(
                              icon: Icons.crop_free,
                              size: 16,
                            ),
                          ),
                          AppSpacing.gapW12,
                          Container(
                            padding: AppSpacing.edgeInsetsAll8,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: AppColors.white),
                            child: AppIcon(
                              icon: AppIcons.edit,
                              size: 16,
                            ),
                          ).clickable(() {
                            Get.toNamed(
                              Routes.profileBusiness,
                              arguments: {'isUpdateProfileFirstLogin': false},
                            );
                          }),
                        ],
                      )
                    ],
                  ).paddingSymmetric(horizontal: 20),
                  AppSpacing.gapH20,
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        SizedBox(
                          height: 0.15.sw + 0.3.sw + 154 + 40,
                          width: 0.85.sw,
                        ),
                        Positioned(
                          bottom: 0,
                          child: Container(
                            padding: const EdgeInsets.only(bottom: 50),
                            height: 0.3.sw + 154 + 40,
                            width: 0.85.sw,
                            decoration: BoxDecoration(
                                color: AppColors.white,
                                boxShadow: [
                                  BoxShadow(
                                      offset: const Offset(0, 2),
                                      blurRadius:
                                          2, // Độ mờ của bóng, giá trị thấp tạo bóng mỏng
                                      color: Colors.black.withOpacity(0.3))
                                ],
                                image: const DecorationImage(
                                    fit: BoxFit.fill,
                                    image: AssetImage(
                                      'assets/images/info-business.png',
                                    ))),
                            child: Obx(
                              () => Column(
                                children: [
                                  SizedBox(
                                    height: 0.15.sw + 12,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        currentUser.fullName,
                                        style: AppTextStyles.s18w700.text2Color,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      AppSpacing.gapW8,
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          gradient:
                                              const LinearGradient(colors: [
                                            Color(0xff061F64),
                                            Color(0xff124DD6),
                                          ]),
                                        ),
                                        child: Row(
                                          children: [
                                            Text(
                                              'BUSINESS',
                                              style: AppTextStyles.s12w600
                                                  .copyWith(
                                                      color: Colors.white,
                                                      fontSize: 12),
                                            ),
                                            AppSpacing.gapW4,
                                            AppIcon(
                                              icon: Assets.images.iconBusiness,
                                              size: 16,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  AppSpacing.gapH8,
                                  Text(
                                    '@${currentUser.contactName}',
                                    style: AppTextStyles.s16w500.text2Color,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  AppSpacing.gapH8,
                                  // Row(
                                  //   mainAxisAlignment:
                                  //       MainAxisAlignment.center,
                                  //   children: [
                                  //     AppIcon(
                                  //       icon: AppIcons.idSolid,
                                  //       color: AppColors.subText3,
                                  //     ),
                                  //     AppSpacing.gapW12,
                                  //     Text(
                                  //       currentUser.pinNumber ?? 'Unknow',
                                  //       style: AppTextStyles
                                  //           .s16w500.subText3Color,
                                  //     )
                                  //   ],
                                  // ),
                                  // const Spacer(),
                                  if (!(currentUser.email ?? '').contains(
                                      'privaterelay.appleid.com')) ...[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        AppIcon(
                                          icon: AppIcons.mail,
                                          color: AppColors.text2,
                                        ),
                                        AppSpacing.gapW12,
                                        Container(
                                          constraints:
                                              BoxConstraints(maxWidth: 0.65.sw),
                                          child: Text(
                                            currentUser.email ?? '',
                                            style: AppTextStyles
                                                .s16w500.text2Color,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        )
                                      ],
                                    ),
                                    AppSpacing.gapH8,
                                  ],

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      AppIcon(
                                        icon: AppIcons.call,
                                        color: AppColors.text2,
                                      ),
                                      AppSpacing.gapW12,
                                      Text(
                                        currentUser.phone ?? '',
                                        style: AppTextStyles.s16w500.text2Color,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      )
                                    ],
                                  ),
                                  AppSpacing.gapH8,
                                  controller.shareLink.value != ''
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            AppIcon(
                                              icon: AppIcons.link,
                                              color: AppColors.text2,
                                            ),
                                            AppSpacing.gapW12,
                                            Container(
                                              constraints: BoxConstraints(
                                                  maxWidth: 0.5.sw),
                                              child: Text(
                                                controller.shareLink.value,
                                                style: AppTextStyles
                                                    .s16w500.text2Color,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            )
                                          ],
                                        )
                                      : AppSpacing.emptyBox,
                                  controller.shareLink.value != ''
                                      ? const Spacer()
                                      : AppSpacing.emptyBox,
                                ],
                              ),
                            ),
                          ),
                        ),
                        Obx(
                          () => Container(
                            height: 0.3.sw,
                            width: 0.3.sw,
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xffA893FF),
                                  Color(0xffDE39FC),
                                  Color(0xffFFFFFF),
                                  Color(0xff4680FF),
                                ],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      const Color(0xffA893FF).withOpacity(0.5),
                                  offset: const Offset(-1, -1),
                                ),
                                BoxShadow(
                                  color:
                                      const Color(0xffDE39FC).withOpacity(0.5),
                                  offset: const Offset(-1, -1),
                                ),
                                BoxShadow(
                                  color:
                                      const Color(0xffFFFFFF).withOpacity(0.5),
                                  offset: const Offset(1, 1),
                                ),
                                BoxShadow(
                                  color:
                                      const Color(0xff4680FF).withOpacity(0.5),
                                  offset: const Offset(-1, 1),
                                ),
                              ],
                            ),
                            child: AppCircleAvatar(
                              url: currentUser.avatarPath ?? '',
                              size: 0.3.sw,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 31),
                    child: ManaMissionWidget(),
                  ),
                  AppSpacing.gapH20,
                  Container(
                    color: AppColors.blue4,
                    width: 1.sw,
                    padding: const EdgeInsets.symmetric(horizontal: 31),
                    child: buildContainerGroupItem(
                      Column(
                        children: [
                          builditemSetting(
                              AppIcons.profile,
                              const Color(0xff2388F9),
                              l10n.personal_page__my_profile, () {
                            Get.toNamed(
                              Routes.profileBusiness,
                              arguments: {'isUpdateProfileFirstLogin': false},
                            );
                          }),
                          const Padding(
                            padding: AppSpacing.edgeInsetsV16,
                            child: AppDivider(
                              color: AppColors.text2,
                            ),
                          ),
                          builditemSetting(
                              Icons.contact_phone,
                              AppColors.alertIcon,
                              l10n.personal_page__list_nft, () {
                            showBottomSheetListOfNFTs(context);
                          }),
                          const Padding(
                            padding: AppSpacing.edgeInsetsV16,
                            child: AppDivider(
                              color: AppColors.text2,
                            ),
                          ),
                          builditemSetting(Assets.images.crown,
                              AppColors.alertIcon, 'EDC meet VIP', () {
                            Get.toNamed(Routes.edcPremium);
                          }),
                          const Padding(
                            padding: AppSpacing.edgeInsetsV16,
                            child: AppDivider(
                              color: AppColors.text2,
                            ),
                          ),
                          builditemSetting(
                              Assets.icons.languageProfile,
                              const Color(0xff52C91D),
                              l10n.language__language, () {
                            Get.to(() => ProfileLanguageView(
                                  languageCode:
                                      controller.currentUser.talkLanguage ?? '',
                                  idUser: 0,
                                  type: 'setting',
                                  personalPageController: controller,
                                  currentUser: currentUser,
                                ));
                          }),
                          const Padding(
                            padding: AppSpacing.edgeInsetsV16,
                            child: AppDivider(
                              color: AppColors.text2,
                            ),
                          ),
                          builditemSetting(
                              Assets.icons.phoneTranslate.image(
                                  color: const Color(0xff2388F9), width: 24),
                              Colors.yellow,
                              l10n.personal_page__talk_language, () {
                            Get.to(() => ProfileTalkLanguageView(
                                  languageCode:
                                      controller.currentUser.talkLanguage ?? '',
                                  idUser: 0,
                                  type: 'setting',
                                  personalPageController: controller,
                                  currentUser: currentUser,
                                ));
                          }),
                          const Padding(
                            padding: AppSpacing.edgeInsetsV16,
                            child: AppDivider(
                              color: AppColors.text2,
                            ),
                          ),
                          // builditemSetting(
                          //     AppIcons.notification,
                          //     const Color(0xffc90909),
                          //     'Notification and Sounds'),
                          // const Padding(
                          //   padding: AppSpacing.edgeInsetsV16,
                          //   child: AppDivider(
                          //     color: AppColors.subText3,
                          //   ),
                          // ),
                          builditemSetting(
                              AppIcons.policy,
                              const Color(0xfffe7a00),
                              l10n.personal_page__policy_and_terms,
                              () {}),
                          const Padding(
                            padding: AppSpacing.edgeInsetsV16,
                            child: AppDivider(
                              color: AppColors.text2,
                            ),
                          ),
                          builditemSetting(
                              AppIcons.webpack,
                              const Color(0xff1fbb83),
                              l10n.personal_page__go_to_web_dapp,
                              () {}),
                          const Padding(
                            padding: AppSpacing.edgeInsetsV16,
                            child: AppDivider(
                              color: AppColors.text2,
                            ),
                          ),
                          changePasswordWidget(),
                          const Padding(
                            padding: AppSpacing.edgeInsetsV16,
                            child: AppDivider(
                              color: AppColors.text2,
                            ),
                          ),
                          builditemSetting(
                              AppIcons.trash,
                              const Color(0xff8322ff),
                              l10n.personal_page__delete_account, () {
                            _buildDeleteAccount();
                          }),
                          const Padding(
                            padding: AppSpacing.edgeInsetsV16,
                            child: AppDivider(
                              color: AppColors.text2,
                            ),
                          ),
                          builditemSetting(
                              AppIcons.logout,
                              const Color(0xffff4040),
                              l10n.personal_page__log_out, () {
                            controller.logout();
                          })
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 20,
                    color: AppColors.blue4,
                  ),
                ],
              ),
            ),
            // CustomScrollView(
            //   physics: const BouncingScrollPhysics(),
            //   controller: controller.scroll,
            //   slivers: [
            //     // SliverAppBar(
            //     //   automaticallyImplyLeading: false,
            //     //   expandedHeight: 395.h,
            //     //   backgroundColor: Colors.transparent,
            //     //   flexibleSpace: const FlexibleSpaceBar(
            //     //     background: ManaMissionWidget(),
            //     //   ),
            //     // ),

            //     SliverToBoxAdapter(
            //       child:
            //     ),
            //     SliverToBoxAdapter(
            //       child: controller.isLoadingLoadMore.value
            //           ? const Center(
            //               child: AppDefaultLoading(
            //                 color: AppColors.white,
            //               ),
            //             )
            //           : const SizedBox.shrink(),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }

  Widget buildContainerGroupItem(Widget child) => Container(
      padding: AppSpacing.edgeInsetsAll16,
      width: 0.85.sw,
      decoration: BoxDecoration(
        color: AppColors.blue4,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(blurRadius: 2, color: Colors.black.withOpacity(0.25))
        ],
      ),
      child: child);

  Widget changePasswordWidget() {
    return Obx(
      () => _buildItem(
        color: const Color(0xff2388F9),
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
                      style: AppTextStyles.s16w600.text2Color,
                    ),
                  ],
                ),
              ),
              AppIcon(
                icon: AppIcons.arrowRight,
                color: AppColors.text2,
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DiagonalPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.blue4
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
