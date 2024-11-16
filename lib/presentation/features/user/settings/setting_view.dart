import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../../core/all.dart';
import '../../../base/all.dart';
import '../../../common_widgets/all.dart';
import '../../../resource/resource.dart';
import '../../../routing/routing.dart';
import 'all.dart';
import 'widgets/bottom_sheet_block_list.dart';
import 'widgets/choose_language_widget.dart';
import 'widgets/delete_account_view.dart';

class SettingView extends BaseView<SettingController> {
  const SettingView({Key? key}) : super(key: key);

  Widget _buildPrivacySettings() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: Sizes.s20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            l10n.setting__general,
            style: AppTextStyles.s16w500.copyWith(color: AppColors.text1),
          ),
        ),
        const SizedBox(height: Sizes.s16),
        Container(
          decoration: BoxDecoration(
            color: AppColors.backgroundPinMessage,
            boxShadow: [
              BoxShadow(
                blurRadius: 4, // Độ mờ của shadow
                color: const Color(0xff000000)
                    .withOpacity(0.2), // Màu shadow với opacity 0.2
              ),
            ],
          ),
          child: Column(children: [
            Obx(() => _buildItem(
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
                                  message: l10n
                                      .setting__password_created_successfully,
                                )
                              });
                    } else {
                      Get.toNamed(Routes.resetPassword, arguments: {
                        'flowFrom': 'change',
                        'phone': controller.currentUser.phone
                      });
                    }
                  },
                )),
            _buildItem(
              icon: AppIcons.personDelete,
              title: l10n.setting__delete_account,
              onTap: () {
                _buildDeleteAccount();
              },
            ),
          ]),
        ),
      ],
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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Padding(
              padding: AppSpacing.edgeInsetsV12,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: AppTextStyles.s16w400.copyWith(color: color),
                    ),
                  ),
                  AppIcon(
                    icon: AppIcons.arrowRight,
                    color: color,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget buildPage(BuildContext context) {
    return CommonScaffold(
      appBar: CommonAppBar(
        titleType: AppBarTitle.text,
        text: l10n.setting__title,
        titleTextStyle: AppTextStyles.s16w600,
        centerTitle: false,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(2.0),
          child: Container(
            height: 1,
            width: 1.sw,
            color: AppColors.divider,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: [
                Column(
                  children: [
                    _buildPrivacySettings(),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _openWebSystem() {}

  void showBottomSheetChooseLanguage(BuildContext context) =>
      showCupertinoModalBottomSheet(
          topRadius: const Radius.circular(30),
          context: context,
          builder: (context) => ChooseLanguageWidget(
                languageCode: controller.currentUser.talkLanguage ?? '',
                idUser: 0,
                type: 'setting',
                settingController: controller,
                user: currentUser,
              ));

  void showBottomSheetBlocklist(BuildContext context) =>
      showCupertinoModalBottomSheet(
          topRadius: const Radius.circular(30),
          context: context,
          builder: (context) => BottomSheetBlocklist(
                controller: controller,
              ));

  void _buildDeleteAccount() {
    Get.to(() => DeleteAccountView(
          controller: controller,
        ));
  }
}
