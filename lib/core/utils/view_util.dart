import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../presentation/common_widgets/all.dart';
import '../../presentation/resource/resource.dart';
import '../all.dart';

class ViewUtil {
  const ViewUtil._();

  static void showAppSnackBar(
    BuildContext context,
    String message, {
    Duration? duration,
    Color? backgroundColor,
  }) {
    final messengerState = ScaffoldMessenger.maybeOf(context);
    if (messengerState == null) {
      return;
    }

    messengerState.hideCurrentSnackBar();
    messengerState.showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration ?? DurationConstants.defaultSnackBarDuration,
        behavior: SnackBarBehavior.floating,
        backgroundColor: backgroundColor,
        margin: AppSpacing.edgeInsetsH20,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Sizes.s8),
        ),
      ),
    );
  }

  static void hideKeyboard(BuildContext context) {
    final currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  static Future<void> setPreferredOrientations(
    List<DeviceOrientation> orientations,
  ) {
    return SystemChrome.setPreferredOrientations(orientations);
  }

  /// set status bar color & navigation bar color
  static void setSystemUIOverlayStyle(
    SystemUiOverlayStyle systemUiOverlayStyle,
  ) {
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }

  static Offset? getWidgetPosition(GlobalKey globalKey) {
    final renderBox =
        globalKey.currentContext?.findRenderObject() as RenderBox?;

    return renderBox?.localToGlobal(Offset.zero);
  }

  static double? getWidgetWidth(GlobalKey globalKey) {
    final renderBox =
        globalKey.currentContext?.findRenderObject() as RenderBox?;

    return renderBox?.size.width;
  }

  static double? getWidgetHeight(GlobalKey globalKey) {
    final renderBox =
        globalKey.currentContext?.findRenderObject() as RenderBox?;

    return renderBox?.size.height;
  }

  static Future<T?> showBottomSheet<T>({
    required Widget child,
    double? elevation,
    ShapeBorder? shape,
    Clip? clipBehavior,
    bool enableDrag = true,
    bool isDismissible = true,
    bool useRootNavigator = true,
    bool isScrollControlled = false,
    bool isFullScreen = false,
    double? heightFactor,
    RouteSettings? settings,
  }) {
    return Get.bottomSheet<T>(
      FractionallySizedBox(
        heightFactor: isFullScreen ? heightFactor ?? 0.9 : null,
        child: _bottomSheetWrapper(child: child),
      ),
      settings: settings,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black26,
      elevation: elevation,
      shape: shape ??
          RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
          ),
      clipBehavior: clipBehavior,
      enableDrag: enableDrag,
      isDismissible: isDismissible,
      useRootNavigator: useRootNavigator,
      isScrollControlled: isFullScreen || isScrollControlled,
    );
  }

  static Widget _bottomSheetWrapper({
    required Widget child,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: AppColors.background13,
            ),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 8,
                offset: Offset(0, -4),
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }

  static Future<void> copyToClipboard(String text) {
    return Clipboard.setData(ClipboardData(text: text));
  }

  static void showRawToast(String message) {
    final snackBar = GetSnackBar(
      messageText: Text(
        message,
        style: AppTextStyles.s14w400.text2Color,
      ),
      backgroundColor: AppColors.white,
      borderRadius: Sizes.s8,
      margin: AppSpacing.edgeInsetsH20,
      animationDuration: const Duration(milliseconds: 500),
      duration: const Duration(seconds: 2),
    );

    Get.showSnackbar(snackBar);
  }

  static void showToast({
    required String title,
    required String message,
    Color backgroundColor = AppColors.white,
    VoidCallback? onTapped,
  }) {
    if (title.isEmpty || message.isEmpty) {
      return;
    }

    Get.closeCurrentSnackbar();

    Get.snackbar(
      title,
      message,
      backgroundColor: backgroundColor,
      animationDuration: const Duration(milliseconds: 500),
      onTap: (_) {
        Get.closeCurrentSnackbar();
        onTapped?.call();
      },
      colorText: AppColors.text1,
    );
  }

  static Future<T?> showAppDialog<T>({
    required String title,
    required String message,
    Widget? icon,
    // negative
    String? negativeText,
    VoidCallback? onNegativePressed,
    Color? negativeColor,
    Color? negativeTextColor,
    // positive
    String? positiveText,
    VoidCallback? onPositivePressed,
    Color? positiveColor,
    Color? positiveTextColor,
    bool? barrierDismissible,
  }) {
    return Get.dialog<T>(
      Dialog(
        backgroundColor: AppColors.white,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Sizes.s24.w,
            vertical: Sizes.s40.h,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                icon,
                AppSpacing.gapH28,
              ],
              Text(
                title,
                style: AppTextStyles.s18w500.text1Color,
                textAlign: TextAlign.center,
              ),
              AppSpacing.gapH12,
              Text(
                message,
                style: AppTextStyles.s16w500.text1Color,
                textAlign: TextAlign.center,
              ),
              if (negativeText != null || positiveText != null) ...[
                AppSpacing.gapH28,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (negativeText != null)
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            onNegativePressed?.call();
                            Get.back();
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: negativeColor,
                          ),
                          child: Text(
                            negativeText,
                            style: AppTextStyles.s18w500.toColor(
                              negativeTextColor ?? AppColors.text1,
                            ),
                          ),
                        ),
                      ),
                    if (negativeText != null && positiveText != null)
                      AppSpacing.gapW12,
                    if (positiveText != null)
                      Expanded(
                        child: AppButton.secondary(
                          width: double.infinity,
                          color: AppColors.button5,
                          label: positiveText,
                          onPressed: () {
                            onPositivePressed?.call();
                            Get.back();
                          },
                        ),
                      ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
      barrierColor: Colors.black26,
      barrierDismissible: barrierDismissible ?? true,
    );
  }

  static Future<T?> showSuccessDialog<T>({
    required String message,
    String? title,
    String? buttonText,
    VoidCallback? onButtonPressed,
    bool barrierDismissible = true,
  }) {
    return showAppDialog<T>(
      title: title ?? Get.context!.l10n.global__success_title,
      message: message,
      barrierDismissible: barrierDismissible,
      icon: AppIcon(
        icon: AppIcons.checkBlur,
        size: Sizes.s56,
        color: AppColors.stoke,
      ),
      positiveText: buttonText ?? Get.context!.l10n.button__ok,
      onPositivePressed: onButtonPressed,
    );
  }

  static Future<T?> showActionSheet<T>({
    required List<ActionSheetItem> items,
    String? cancelText,
    Widget? title,
    Widget? message,
  }) {
    return showCupertinoModalPopup<T>(
      context: Get.context!,
      builder: (context) {
        return CupertinoActionSheet(
          title: title,
          message: message,
          actions: [
            for (final item in items)
              CupertinoActionSheetAction(
                onPressed: () {
                  Get.back();
                  item.onPressed?.call();
                },
                child: Text(
                  item.title,
                  style: AppTextStyles.s18w500.text1Color,
                ),
              ),
          ],
          cancelButton: CupertinoActionSheetAction(
            onPressed: Get.back,
            child: Text(
              cancelText ?? Get.context!.l10n.button__cancel,
              style: AppTextStyles.s18w500.negativeColor,
            ),
          ),
        );
      },
    );
  }

  static Future<T?> showAppCupertinoAlertDialog<T>({
    required String title,
    required String message,
    String? negativeText,
    VoidCallback? onNegativePressed,
    String? positiveText,
    VoidCallback? onPositivePressed,
    TextStyle? textStyleTitle,
  }) {
    return showCupertinoDialog<T>(
      context: Get.context!,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(
            title,
            style: textStyleTitle ?? AppTextStyles.s18w500,
          ),
          content: Text(
            message,
            style: AppTextStyles.s14w500.text1Color,
          ),
          actions: [
            if (negativeText != null)
              CupertinoDialogAction(
                onPressed: () {
                  onNegativePressed?.call();
                  Get.back();
                },
                child: Text(
                  negativeText,
                  style: AppTextStyles.s16w500,
                ),
              ),
            if (positiveText != null)
              CupertinoDialogAction(
                onPressed: () {
                  onPositivePressed?.call();
                  Get.back();
                },
                child: Text(
                  positiveText,
                  style: AppTextStyles.s16w500,
                ),
              ),
          ],
        );
      },
    );
  }

  static void showImageDialog({
    String? imageUrl,
    File? imageFile,
    VoidCallback? onLongPress,
  }) {
    assert(imageUrl != null || imageFile != null);

    Get.generalDialog(
      barrierColor: Colors.black87,
      barrierDismissible: true,
      barrierLabel: imageFile?.path ?? imageUrl!,
      pageBuilder: (context, animation, secondaryAnimation) {
        return ScaffoldMessenger(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Stack(
              children: [
                Builder(
                  builder: (context) {
                    final mediaWidget = Center(
                      child: imageFile != null
                          ? Image(
                              image: FileImage(imageFile),
                              fit: BoxFit.fitWidth,
                            )
                          : AppNetworkImage(
                              imageUrl,
                              fit: BoxFit.contain,
                              imageBuilder: (context, imageProvider) => Image(
                                image: imageProvider,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                    );

                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 1.sw,
                          height: 1.sh,
                        ).clickable(Get.back),
                        Dismissible(
                          key: Key(imageFile?.path ?? imageUrl!),
                          direction: DismissDirection.down,
                          onDismissed: (_) => Get.back(),
                          child: GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onLongPress: onLongPress,
                            child: mediaWidget,
                          ),
                        ),
                      ],
                    );
                  },
                ),
                Positioned(
                  bottom: Sizes.s48.h,
                  left: 0,
                  right: 0,
                  child: AppIcon(
                    icon: AppIcons.close,
                    onTap: Get.back,
                    isCircle: true,
                    padding: AppSpacing.edgeInsetsAll8,
                    backgroundColor: Colors.white70,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static void showVideoDialog(
    String videoUrl, {
    bool isFile = false,
    VoidCallback? onLongPress,
  }) {
    Get.generalDialog(
      barrierColor: Colors.black87,
      barrierDismissible: true,
      barrierLabel: videoUrl,
      pageBuilder: (context, animation, secondaryAnimation) {
        return ScaffoldMessenger(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Stack(
              children: [
                Builder(builder: (context) {
                  final video = Center(
                    child: AppVideoPlayer(
                      videoUrl,
                      fit: BoxFit.fitWidth,
                      isFile: isFile,
                    ),
                  );

                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 1.sw,
                        height: 1.sh,
                      ).clickable(Get.back),
                      Dismissible(
                        key: Key(videoUrl),
                        direction: DismissDirection.down,
                        onDismissed: (_) => Get.back(),
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onLongPress: onLongPress,
                          child: video,
                        ),
                      ),
                    ],
                  );
                }),
                Positioned(
                  bottom: Sizes.s48.h,
                  left: 0,
                  right: 0,
                  child: AppIcon(
                    icon: AppIcons.close,
                    onTap: Get.back,
                    isCircle: true,
                    padding: AppSpacing.edgeInsetsAll8,
                    backgroundColor: Colors.white70,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static Future<T?> showAlertDialog<T>({
    AssetGenImage? image,
    String? title,
    String? content,
    VoidCallback? onTapTopButton,
    VoidCallback? onTapBottomButton,
    String? textTopButton,
    String? textBottomButton,
    AlertDialogType? type,
  }) {
    final backgroundColor = type == AlertDialogType.success
        ? AppColors.background11
        : AppColors.background12;

    final borderDialogColor =
        type == AlertDialogType.success ? AppColors.button6 : AppColors.button8;

    final buttonColor =
        type == AlertDialogType.success ? AppColors.button5 : AppColors.button7;

    return Get.dialog<T>(
      Dialog(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            // border: Border.all(width: 6, color: borderDialogColor),
            borderRadius: BorderRadius.circular(
                Sizes.s20), // Adjust border radius if needed
          ),
          padding: const EdgeInsets.symmetric(
              horizontal: Sizes.s16, vertical: Sizes.s24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              image == null
                  ? const SizedBox()
                  : image.image(height: 100.h, width: 100.w),
              AppSpacing.gapH8,
              title == null
                  ? const SizedBox()
                  : Padding(
                      padding: const EdgeInsets.only(
                          right: Sizes.s16, left: Sizes.s16),
                      child: Text(
                        title,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.s18w600
                            .copyWith(color: AppColors.text1),
                      ),
                    ),
              AppSpacing.gapH8,
              content == null
                  ? const SizedBox()
                  : Padding(
                      padding: const EdgeInsets.only(
                          right: Sizes.s16, left: Sizes.s16),
                      child: Text(
                        content,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.s16Base
                            .copyWith(color: AppColors.text1),
                      ),
                    ),
              AppSpacing.gapH16,
              if (textTopButton == null || textBottomButton == null) ...[
                AppButton.secondary(
                  color: buttonColor,
                  onPressed: textTopButton == null
                      ? onTapBottomButton
                      : onTapTopButton,
                  width: double.infinity,
                  label: textTopButton ?? textBottomButton!,
                ),
              ] else ...[
                AppButton.secondary(
                  onPressed: onTapTopButton,
                  width: double.infinity,
                  label: textTopButton,
                  boderColor: const Color(0x9493AC80).withOpacity(0.5),
                  textStyleLabel: AppTextStyles.s18w500.copyWith(
                    color: const Color(0xff9493AC),
                    height: 1.2,
                  ),
                ),
                AppSpacing.gapH4,
                AppButton.secondary(
                  color: buttonColor,
                  onPressed: onTapBottomButton,
                  width: double.infinity,
                  label: textBottomButton,
                ),
              ],
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }
}

enum AlertDialogType { success, warning }

class ActionSheetItem {
  final String title;
  final VoidCallback? onPressed;

  const ActionSheetItem({
    required this.title,
    this.onPressed,
  });
}
