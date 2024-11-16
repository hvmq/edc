import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/all.dart';
import '../../../../base/base_view.dart';
import '../../../../common_widgets/common_app_bar.dart';
import '../../../../common_widgets/common_scaffold.dart';
import '../../../../resource/styles/app_colors.dart';
import '../../../../resource/styles/gaps.dart';
import '../../../../resource/styles/text_styles.dart';
import '../personal_page_controller.dart';

class PrivacyView extends BaseView<PersonalPageController> {
  const PrivacyView({Key? key}) : super(key: key);

  Widget _buildDivider() => const Padding(
        padding: EdgeInsets.symmetric(vertical: 14),
        child: Divider(
          color: Color(0xffdbdbdb),
          height: 1,
        ),
      );

  Widget buildContainerGroupItem(Widget child) => Container(
        width: double.infinity,
        padding: AppSpacing.edgeInsetsAll20,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.border2, width: 0.5),
          borderRadius: BorderRadius.circular(11),
        ),
        child: child,
      );

  Widget builditemSetting(String title, bool itemValue, Function() onTap) =>
      Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: AppTextStyles.s16w500,
            ),
          ),
          AppSpacing.gapW12,
          CupertinoSwitch(
              activeColor: AppColors.button5,
              trackColor: AppColors.subText3,
              value: itemValue,
              onChanged: (value) {
                onTap();
              }),
        ],
      );

  Widget _buildSettings() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.setting__general,
          style: AppTextStyles.s16w600.text5Color,
        ),
        const SizedBox(height: Sizes.s16),
        buildContainerGroupItem(Column(
          children: [
            builditemSetting(
              l10n.setting__privacy_search_global,
              controller.currentUser.isSearchGlobal ?? true,
              () {
                controller.updatePrivacy(UpdatePrivacyType.globalSearch);
              },
            ),
          ],
        )),
      ],
    );
  }

  Widget _buildPrivacySettings() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.setting__privacy_discrible,
          style: AppTextStyles.s16w600.text5Color,
        ),
        const SizedBox(height: Sizes.s16),
        buildContainerGroupItem(Column(
          children: [
            // builditemSetting(
            //   l10n.field__email_label,
            //   controller.currentUser.isShowEmail ?? true,
            //   () {
            //     controller.updatePrivacy(UpdatePrivacyType.showEmail);
            //   },
            // ),
            // _buildDivider(),
            builditemSetting(
              l10n.field_phone__label,
              controller.currentUser.isShowPhone ?? true,
              () {
                controller.updatePrivacy(UpdatePrivacyType.showPhone);
              },
            ),
            // _buildDivider(),
            // builditemSetting(
            //   l10n.my_profile__date_of_birth,
            //   controller.currentUser.isShowBirthday ?? true,
            //   () {
            //     controller.updatePrivacy(UpdatePrivacyType.showBirthDay);
            //   },
            // ),
          ],
        )),
      ],
    );
  }

  @override
  Widget buildPage(BuildContext context) {
    return CommonScaffold(
      appBar: CommonAppBar(
        titleType: AppBarTitle.text,
        text: l10n.setting__privacy_label,
        titleTextStyle: AppTextStyles.s20w600.text5Color,
        leadingIconColor: AppColors.button5,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.s20),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  Obx(
                    () => Column(
                      children: [
                        AppSpacing.gapH20,
                        _buildSettings(),
                        AppSpacing.gapH20,
                        _buildPrivacySettings(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Obx(
            //   () => Padding(
            //     padding: const EdgeInsets.all(Sizes.s24),
            //     child: Text(
            //       'Version ${controller.version.value}',
            //       style: AppTextStyles.s18w400.text2Color,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
