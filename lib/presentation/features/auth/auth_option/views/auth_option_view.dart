import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../../../core/all.dart';
import '../../../../base/all.dart';
import '../../../../common_widgets/all.dart';
import '../../../../resource/resource.dart';
import '../../../../routing/routing.dart';
import '../../../all.dart';
import '../../../user/settings/widgets/choose_language_widget.dart';

class AuthOptionView extends BaseView<AuthOptionController> {
  const AuthOptionView({Key? key}) : super(key: key);

  Widget _buildpattern() => Assets.gif.edcNotiHello.image(
        fit: BoxFit.fitWidth,
        width: double.infinity,
      );

  Widget _buildEllipse1() =>
      Assets.images.ellipseBackground1.image(scale: 1, fit: BoxFit.fitWidth);
  Widget _buildEllipse2() =>
      Assets.images.ellipseBackground2.image(fit: BoxFit.fitWidth, scale: 1);

  Widget _buildIcon(AssetGenImage image, double top, double left) =>
      Positioned(top: top, left: left, child: image.image(scale: 2));

  Widget _buildTextWelcome1(BuildContext context) => Text(
        Get.context!.l10n.text_welcome_auth_option_1,
        style: AppTextStyles.s28w600.copyWith(
            fontSize:
                (Localizations.localeOf(context).toString() == 'vi') ? 26 : 32,
            fontWeight: FontWeight.w600),
      );
  Widget _buildTextWelcome2(BuildContext context) => Row(
        children: [
          if (Localizations.localeOf(context).toString() == 'vi') ...[
            Text(
              '${Get.context!.l10n.text_welcome_auth_option_3} ',
              style: AppTextStyles.s28w600
                  .copyWith(fontSize: 26, fontWeight: FontWeight.w600),
            ),
            Text(
              Get.context!.l10n.text_welcome_auth_option_2,
              style: AppTextStyles.s28w600.copyWith(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  color: AppColors.text7),
            ),
          ],
          if (Localizations.localeOf(context).toString() != 'vi') ...[
            Text(
              Get.context!.l10n.text_welcome_auth_option_2,
              style: AppTextStyles.s28w600.copyWith(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  color: AppColors.text7),
            ),
            Text(
              ' ${Get.context!.l10n.text_welcome_auth_option_3}',
              style: AppTextStyles.s28w600
                  .copyWith(fontSize: 32, fontWeight: FontWeight.w600),
            ),
          ],
          Text(
            '!',
            style: AppTextStyles.s28w600.copyWith(
              fontSize: 32,
              fontWeight: FontWeight.w600,
              color: Localizations.localeOf(context).toString() == 'vi'
                  ? AppColors.text7
                  : null,
            ),
          ),
        ],
      );

  Widget _buildTextDescription() => Text(
        Get.context!.l10n.text_desciption_auth_option,
        style: AppTextStyles.s16Base,
      );

  Widget _buildRegisterButton() => AppButton.secondary(
        label: Get.context!.l10n.button__sign_up,
        width: double.infinity,
        onPressed: () => Get.toNamed(Routes.register),
      );

  Widget _buildLoginButton() => AppButton.secondary(
        label: Get.context!.l10n.button__sign_in,
        width: double.infinity,
        color: AppColors.button5,
        onPressed: () => Get.toNamed(Routes.login),
        isLoading: controller.isLoading,
      );

  Widget _buildLanguageButton(BuildContext context) => Container(
          padding: AppSpacing.edgeInsetsAll8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.white,
            boxShadow: [
              BoxShadow(
                  offset: const Offset(0, 2),
                  blurRadius: 2, // Độ mờ của bóng, giá trị thấp tạo bóng mỏng
                  color: Colors.black.withOpacity(0.3))
            ],
          ),
          child: AppIcon(
            icon: AppIcons.languageProfile,
            // color: AppColors.white,
          )).clickable(() {
        showCupertinoModalBottomSheet(
          topRadius: const Radius.circular(30),
          context: context,
          builder: (context) => ChooseLanguageWidget(
            languageCode: languages[0]['langCode'] ?? '',
            idUser: 0,
            type: 'register',
            email: '',
            user: null,
          ),
        );
      });

  @override
  Widget buildPage(BuildContext context) {
    return CommonScaffold(
      body: Stack(
        children: [
          Positioned(
            right: 0,
            top: 0.05.sh,
            width: 0.6.sw,
            child: _buildEllipse1(),
          ),
          Positioned(
            left: 0,
            top: 0.07.sh,
            width: 0.6.sw,
            child: _buildEllipse2(),
          ),
          Padding(
            padding: EdgeInsets.only(top: 0.05.sh),
            child: _buildpattern(),
          ),
          Positioned(
            right: 20,
            top: 40,
            child: _buildLanguageButton(context),
          ),

          // _buildIcon(Assets.images.authOptionIcon1, 0.04.sh, 0.25.sw),
          // _buildIcon(Assets.images.authOptionIcon2, 0.11.sh, 0.4.sw),
          // _buildIcon(Assets.images.authOptionIcon3, 0.27.sh, 0.1.sw),
          // _buildIcon(Assets.images.authOptionIcon4, 0.3.sh, 0.45.sw),
          Padding(
            padding: AppSpacing.edgeInsetsAll28,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTextWelcome1(context),
                _buildTextWelcome2(context),
                AppSpacing.gapH16,
                _buildTextDescription(),
                SizedBox(
                  height: 0.05.sh,
                ),
                _buildLoginButton(),
                AppSpacing.gapH16,
                _buildRegisterButton(),
                SizedBox(
                  height: 0.04.sh,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
