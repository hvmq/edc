import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../base/all.dart';
import '../../../common_widgets/all.dart';
import '../../../resource/resource.dart';
import '../controllers/splash_controller.dart';

class SplashView extends BaseView<SplashController> {
  const SplashView({Key? key}) : super(key: key);

  Widget _buildBackgroud() => Align(
        alignment: Alignment.topLeft,
        child: Assets.images.layerBackground2.image(scale: 2),
      );
  Widget _buildLogo(BuildContext context) => Center(
        child: Assets.images.logo.image(
          height: 0.3.sw,
        ),
      );

  @override
  Widget buildPage(BuildContext context) {
    return CommonScaffold(
      backgroundLayer: true,
      body: Stack(
        children: [_buildLogo(context), _buildBackgroud()],
      ),
    );
  }
}
