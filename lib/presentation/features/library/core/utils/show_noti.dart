import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/utils/color.dart';

void showError(String message) {
  Get.snackbar(
    'error'.tr,
    "${message.tr} ${'try_again'.tr}",
    backgroundColor: AppColor.redColor,
    colorText: AppColor.textColor,
    duration: const Duration(seconds: 5),
  );
}

void showErrorWithTitle(String title, String message, {int duration = 5}) {
  Get.snackbar(
    title,
    message,
    backgroundColor: AppColor.redColor,
    colorText: AppColor.textColor,
    duration: Duration(seconds: duration),
  );
}

void showSuccess(String message) {
  Get.snackbar(
    'success'.tr,
    message.tr,
    backgroundColor: Colors.green,
    colorText: Colors.white,
    duration: const Duration(seconds: 5),
  );
}

void showInfo(String title, String message, {int duration = 3}) {
  Get.snackbar(
    title,
    message,
    backgroundColor: Colors.white,
    colorText: Colors.black,
    duration: Duration(seconds: duration),
  );
}

void showSuccessWithTitle(String title, String message, {int duration = 5}) {
  Get.snackbar(
    title,
    message,
    backgroundColor: Colors.green,
    colorText: Colors.white,
    duration: Duration(seconds: duration),
  );
}

void showCommonDialog({
  required BuildContext context,
  required String title, // Title of the dialog
  required String content, // Description or content of the dialog
  String? actionButtonText =
      'Close', // Text for the action button (default: 'Pay')
  Function()? onActionPressed, // Function to call when action button is pressed
  Widget? customContent, // Optional custom widget content
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: AppColor.textWhileColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              alignment: Alignment.center,
              child: Text(
                title.tr,
                style: TextStyle(
                    color: AppColor.textColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Text(
              content.tr,
              style: TextStyle(color: AppColor.textColor, fontSize: 14),
            ),
            if (customContent != null) ...[
              const SizedBox(height: 16),
              customContent,
            ],
          ],
        ),
        actions: [
          GestureDetector(
            onTap: () {
              if (onActionPressed != null) {
                onActionPressed();
              }
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 12),
              width: Get.width,
              decoration: BoxDecoration(
                color: AppColor.blueColor_3.withOpacity(0.8),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Text(
                actionButtonText!.tr,
                style: TextStyle(color: AppColor.textColor),
              ),
            ),
          ),
        ],
      );
    },
  );
}

void showFilterOrSortDialog({
  required BuildContext context,
  required bool isFilter,
  required List<String> items,
  required Function(String) onItemSelected,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: AppColor.textWhileColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        title: Center(
          child: Text(
            isFilter ? 'Filter by Status' : 'Sort by',
            style: TextStyle(
              color: AppColor.textColor,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: items.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  onItemSelected(items[index]); // Callback to handle selection
                  Navigator.of(context).pop();
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: AppColor.blueColor_3.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  child: Center(
                    child: Text(
                      items[index].tr,
                      style: TextStyle(color: AppColor.textColor, fontSize: 16),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      );
    },
  );
}
