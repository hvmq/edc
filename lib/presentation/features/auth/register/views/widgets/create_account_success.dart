import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../../core/all.dart';
import '../../../../../common_widgets/all.dart';
import '../../../../../resource/gen/assets.gen.dart';
import '../../../../../resource/styles/app_colors.dart';
import '../../../../../resource/styles/text_styles.dart';
import '../../../../../routing/routers/app_pages.dart';

class CreateAccountSuccess extends StatelessWidget {
  const CreateAccountSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    Widget buildpattern() => Assets.gif.edcNotiGoodJob.image();

    Widget buildLoginButton() => AppButton.secondary(
        label: Get.context!.l10n.button__continue,
        width: double.infinity,
        color: AppColors.button5,
        onPressed: () {
          Get.toNamed(Routes.home);
        });

    return CommonScaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Spacer(),
            buildpattern(),
            SizedBox(height: 0.1.sh),
            Text(
              textAlign: TextAlign.center,
              style: AppTextStyles.s16w600,
              AppLocalizations.of(Get.context!)!.text_sign_up_success,
            ),
            SizedBox(height: 0.1.sh),
            buildLoginButton(),
          ],
        ),
      ),
    );
  }
}
