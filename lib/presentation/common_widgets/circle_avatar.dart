import 'package:flutter/material.dart';

import '../resource/resource.dart';
import 'all.dart';

class AppCircleAvatar extends StatefulWidget {
  final String url;
  final double? size;
  final Color? backgroundColor;
  final bool clickToSeeFullImage;

  const AppCircleAvatar({
    required this.url,
    this.size,
    this.backgroundColor,
    super.key,
    this.clickToSeeFullImage = false,
  });

  @override
  State<AppCircleAvatar> createState() => _AppCircleAvatarState();
}

class _AppCircleAvatarState extends State<AppCircleAvatar> {
  // var controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // try {
    //   controller = Get.find<HomeController>();
    // } catch (e) {
    //   LogUtil.e(e);
    //   controller = Get.find<LoginController>();
    // }
  }

  @override
  Widget build(BuildContext context) {
    final finalSize = widget.size ?? Sizes.s48;

    return Stack(
      children: [
        AppNetworkImage(
          widget.url,
          radius: finalSize / 2,
          width: finalSize,
          height: finalSize,
          clickToSeeFullImage: widget.clickToSeeFullImage,
          imageBuilder: (context, imageProvider) => CircleAvatar(
            backgroundImage: ResizeImage(
              imageProvider,
              width: finalSize.toInt().cacheSize(context),
            ),
          ),
          errorWidget: _buildFallbackWidget(finalSize),
        ),
        // if (homeController != null)
        //   Obx(
        //     () => Positioned(
        //       right: 0,
        //       child: Visibility(
        //         visible: homeController.currentUser.premium == 'pro',
        //         child: AppIcon(
        //           icon: Assets.images.crown,
        //           size: finalSize / 4,
        //         ),
        //       ),
        //     ),
        //   ),
      ],
    );
  }

  Widget _buildFallbackWidget(double finalSize) {
    return CircleAvatar(
      radius: finalSize / 2,
      backgroundImage: const AssetImage('assets/images/default-avatar.png'),
    );
  }
}
