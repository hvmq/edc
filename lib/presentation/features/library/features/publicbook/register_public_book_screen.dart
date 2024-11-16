import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/routes/app_routes.dart';
import '../../core/utils/color.dart';
import '../../core/utils/resource/assets_constant/image_constant.dart';
import '../../features/publicbook/public_book_controller.dart';

class RegisterPublicBookScreen extends GetView<PublicBookController> {
  const RegisterPublicBookScreen({super.key});

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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Row(
                    children: [
                      Icon(
                        Icons.arrow_back,
                        color: AppColor.textColor,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Back'.tr,
                        style: TextStyle(
                          color: AppColor.textColor,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Image.asset(ImageConstants.register),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              alignment: Alignment.bottomCenter,
              height: Get.height - 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Register Public Book',
                    style: TextStyle(
                        color: AppColor.textColor,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 12),
                    child: Text(
                      'allows users to upload and share books publicly with the community. Users can provide book details such as title, author, and category, making the content accessible for others to browse, read, or download. This feature promotes collaborative sharing and building a public library.',
                      style: TextStyle(color: AppColor.greyColor),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.TermsAndPrivacyPolicy);
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 12),
                      alignment: Alignment.center,
                      width: Get.width,
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 32),
                      decoration: BoxDecoration(
                        color: AppColor.blueColor_2,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Text(
                        'Register now'.tr,
                        style: TextStyle(color: AppColor.textColor),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
