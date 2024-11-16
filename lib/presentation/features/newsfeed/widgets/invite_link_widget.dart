import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';

import '../../../../../core/all.dart';
import '../../../common_widgets/all.dart';
import '../../../resource/resource.dart';

class InviteLinkWidget extends StatelessWidget {
  final String link;
  final String name;
  final ScreenshotController screenshotController =
      ScreenshotController(); // Controller cho screenshot

  InviteLinkWidget({required this.link, required this.name, super.key});

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      appBar: CommonAppBar(
        titleType: AppBarTitle.none,
        titleWidget: Text(
          context.l10n.text_back,
          style: AppTextStyles.s16w700.copyWith(color: AppColors.text1),
        ).clickable(() => Get.back()),
        centerTitle: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Screenshot(
            controller: screenshotController,
            child: Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 0.15.sw),
                    padding: EdgeInsets.all(0.07.sw).copyWith(bottom: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: AppColors.white,
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(0, 3),
                          color: Colors.black.withOpacity(0.25),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        AppQrCodeView(
                          link,
                          size: 0.5.sw,
                        ),
                        Text(
                          name,
                          style:
                              AppTextStyles.s14w700.toColor(AppColors.button5),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 0,
                    child: Container(
                      height: 0.2.sw,
                      width: 0.2.sw,
                      padding: AppSpacing.edgeInsetsAll16,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.25),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: Assets.images.logo.image(),
                    ),
                  ),
                ],
              ).paddingOnly(bottom: 20),
            ),
          ),
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xff2388F9)),
                  borderRadius: BorderRadius.circular(100)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    context.l10n.text_download_qr_code,
                    style:
                        AppTextStyles.s14w600.toColor(const Color(0xff2388F9)),
                  ),
                  AppSpacing.gapW8,
                  AppIcon(
                    icon: Assets.icons.download,
                    color: const Color(0xff2388F9),
                    size: 20,
                  )
                ],
              ),
            ).clickable(() {
              _captureAndSaveQR();
            }),
          ),
          AppSpacing.gapH28,
          Text(
            context.l10n.conversation_details__invite_link,
            style: AppTextStyles.s16w700.text1Color,
          ).paddingOnly(left: 20),
          AppSpacing.gapH12,
          Container(
            margin: AppSpacing.edgeInsetsH20,
            padding: AppSpacing.edgeInsetsAll16,
            decoration: BoxDecoration(
                color: AppColors.grey11,
                borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    link,
                    style: AppTextStyles.s14Base.text1Color,
                  ),
                ),
                Text(
                  context.l10n.button__copy,
                  style: AppTextStyles.s16Base.toColor(AppColors.button5),
                ).clickable(() {
                  ViewUtil.copyToClipboard(link).then((_) {
                    ViewUtil.showAppSnackBar(
                      context,
                      context.l10n.global__copied_to_clipboard,
                    );
                  });
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _captureAndSaveQR() async {
    final PermissionStatus status;

    if (Platform.isAndroid) {
      status = await Permission.manageExternalStorage.request();
      if (status != PermissionStatus.granted) {
        ViewUtil.showToast(
            title: Get.context!.l10n.text_permission_denied,
            message: Get.context!.l10n.text_please_grant_storage_permission);
      }
    } else {
      status = await Permission.storage.request();
      if (status != PermissionStatus.granted) {
        ViewUtil.showToast(
            title: Get.context!.l10n.text_permission_denied,
            message: Get.context!.l10n.text_please_grant_storage_permission);
      }
    }

    if (status.isGranted) {
      try {
        // Chụp ảnh bằng ScreenshotController
        final image = await screenshotController.capture();

        if (image != null) {
          // Tạo file tạm thời trong thư mục ứng dụng
          final directory = await getTemporaryDirectory();
          final List<String> parts = link.split('/');

          final filePath = '${directory.path}/${parts[3]}.png';
          final file = File(filePath);
          await file.writeAsBytes(image);

          // Lưu ảnh vào thư viện bằng GallerySaver
          final success = await GallerySaver.saveImage(filePath);
          if (success == true) {
            ViewUtil.showToast(
                title: Get.context!.l10n.text_success,
                message: Get.context!.l10n.text_qr_code_saved_to_gallery);
          } else {
            ViewUtil.showToast(
                title: Get.context!.l10n.global__error_title,
                message: Get.context!.l10n.text_cannot_save_image_to_gallery);
          }
        }
      } catch (error) {
        Get.snackbar('Lỗi', 'Không thể chụp ảnh mã QR: $error');
      }
    } else {
      ViewUtil.showToast(
          title: Get.context!.l10n.text_permission_denied,
          message: Get.context!.l10n.text_please_grant_storage_permission);
    }
  }
}
