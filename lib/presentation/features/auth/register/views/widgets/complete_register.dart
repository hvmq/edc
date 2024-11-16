import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../../core/all.dart';
import '../../../../../common_widgets/all.dart';
import '../../../../../resource/resource.dart';
import '../../../../../routing/routers/app_pages.dart';

class CompleteRegister extends StatelessWidget {
  const CompleteRegister({super.key});

  @override
  Widget build(BuildContext context) {
    Widget buildEllipse1() =>
        Assets.images.ellipseBackground1.image(scale: 1, fit: BoxFit.fitWidth);
    Widget buildEllipse2() =>
        Assets.images.ellipseBackground2.image(fit: BoxFit.fitWidth, scale: 1);

    return CommonScaffold(
      backgroundLayer: true,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              Positioned(
                right: 0,
                top: 0,
                width: 0.6.sw,
                child: buildEllipse1(),
              ),
              Positioned(
                left: 0,
                top: 0.02.sh,
                width: 0.6.sw,
                child: buildEllipse2(),
              ),
              Assets.gif.edcNotiGoodJob.image(
                fit: BoxFit.fitWidth,
                width: double.infinity,
              ),
            ],
          ),
          Padding(
            padding: AppSpacing.edgeInsetsAll20,
            child: Text(
              context.l10n.auth__successfully_created_an_account,
              style: AppTextStyles.s16w600,
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: AppSpacing.edgeInsetsAll20,
            child: AppButton.secondary(
              color: AppColors.button5,
              label: context.l10n.auth__continue,
              width: double.infinity,
              onPressed: () => Get.toNamed(AppPages.afterAuthRoute),
            ),
          ),
        ],
      ),
    );
  }
}
