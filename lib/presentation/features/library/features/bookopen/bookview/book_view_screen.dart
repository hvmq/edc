import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/color.dart';
import '../../../features/bookopen/book_open_controller.dart';

class BookViewScreen extends GetView<BookOpenController> {
  const BookViewScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: AppBar(
        leadingWidth: 0,
        titleSpacing: 0.0,
        automaticallyImplyLeading: false,
        backgroundColor: AppColor.primaryColor,
        centerTitle: true,
        title: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                          child: Icon(
                            Icons.arrow_back,
                            color: AppColor.textColor,
                          ),
                          alignment: PlaceholderAlignment.middle,
                        ),
                        const WidgetSpan(
                            child: SizedBox(
                          width: 12,
                        )),
                        TextSpan(
                          text: 'Back'.tr,
                          style: TextStyle(
                            color: AppColor.textColor,
                            fontSize: 18,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
