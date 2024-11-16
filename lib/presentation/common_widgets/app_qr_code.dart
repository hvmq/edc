import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../resource/resource.dart';

class AppQrCodeView extends StatelessWidget {
  final String data;
  final double size;

  const AppQrCodeView(
    this.data, {
    super.key,
    this.size = 160, // here
  });

  @override
  Widget build(BuildContext context) {
    return QrImageView(
      data: data,
      size: size,
      backgroundColor: Colors.white,
      eyeStyle: const QrEyeStyle(
        color: AppColors.button5,
      ),
      dataModuleStyle: const QrDataModuleStyle(
        color: AppColors.button5,
      ),
      // embeddedImage: Assets.images.iconLauncher.provider(),
      embeddedImageStyle: const QrEmbeddedImageStyle(
        size: Size(40, 40), //here
      ),
    );
  }
}
