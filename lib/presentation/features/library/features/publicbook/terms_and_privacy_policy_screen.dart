import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/routes/app_routes.dart';
import '../../core/utils/color.dart';
import '../../features/publicbook/public_book_controller.dart';

class TermsAndPrivacyPolicyScreen extends GetView<PublicBookController> {
  const TermsAndPrivacyPolicyScreen({super.key});

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
                        'Register Public Book'.tr,
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
        child: Column(
          children: [
            Text(
              'Terms and Privacy Policy',
              style: TextStyle(
                  color: AppColor.textColor,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            buildTitle(title: '1. Introduction'.tr),
            buildContent(
                content:
                    'We are committed to protecting your privacy. This privacy policy explains how we collect, use, and protect your personal information when you access and use our services.'),
            buildTitle(title: '2. Information Collection'.tr),
            buildContent(
                content:
                    'We collect personal information you provide when registering, placing an order, or contacting us. This information may include your name, email address, phone number, and shipping address. We may also collect technical information about your use of our services, such as IP address, browser type, and access times.'),
            buildTitle(title: '3. Use of Information'.tr),
            buildContent(content: '''Your personal information is used to:
. Provide and improve our services.
. Process orders and fulfill deliveries.
. Send information about products, services, and promotions.
. Respond to requests and provide customer support.'''),
            buildTitle(title: '4. Information Sharing'.tr),
            buildContent(
                content:
                    'We do not sell, trade, or transfer your personal information to third parties without your consent, except as required by law or to provide necessary services (such as delivery service providers).'),
            buildTitle(title: '5. Information Security'.tr),
            buildContent(
                content:
                    'We implement reasonable security measures to protect your personal information from unauthorized access, alteration, disclosure, or destruction. However, no method of data transmission over the internet or electronic storage is completely secure.'),
            buildTitle(title: '6. Your Rights'.tr),
            buildContent(
                content:
                    'You have the right to request access to, correction of, or deletion of your personal information. To exercise these rights, please contact us using the information provided below.'),
            buildTitle(title: '7. Policy Changes'.tr),
            buildContent(
                content:
                    'We may update this privacy policy from time to time. Changes will be posted on our website. You should review this policy periodically for the latest information.'),
            buildTitle(title: '8. Contact Us'.tr),
            buildContent(
                content:
                    'If you have any questions or requests related to this privacy policy, please contact us at [email@example.com].'),
            const SizedBox(
              height: 12,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(
                  () => Checkbox(
                    value: controller.isAgree.value,
                    onChanged: (bool? value) {
                      controller.isAgree.value = value ?? false;
                    },
                  ),
                ),
                Text(
                  'I agree to the terms and policies above.',
                  style: TextStyle(color: AppColor.textColor),
                ),
              ],
            ),
            Obx(() => GestureDetector(
                  onTap: () {
                    if (controller.isAgree.value) {
                      showPopup(context);
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 12),
                    alignment: Alignment.center,
                    width: Get.width,
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 32),
                    decoration: BoxDecoration(
                      color: controller.isAgree.value
                          ? AppColor.blueColor_2
                          : AppColor.blueColor_4,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Text(
                      'Register'.tr,
                      style: TextStyle(color: AppColor.textColor),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget buildTitle({required String title}) {
    return Container(
      width: Get.width,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      child: Text(
        textAlign: TextAlign.start,
        title,
        style: TextStyle(
            color: AppColor.textColor,
            fontSize: 18,
            fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget buildContent({required String content}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        content,
        style: TextStyle(color: AppColor.greyColor),
      ),
    );
  }

  void showPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColor.blueColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: Get.width - 40,
                margin: const EdgeInsets.only(bottom: 16),
                alignment: Alignment.center,
                child: Text(
                  'Register successful!'.tr,
                  style: TextStyle(
                      color: AppColor.textColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Text(
                'The request for book registration has been sent and is awaiting system approval.',
                style: TextStyle(color: AppColor.textColor, fontSize: 14),
              ),
            ],
          ),
          actions: [
            GestureDetector(
              onTap: () async {
                Navigator.of(context).pop();

                final bool check = await controller.registerPublicBook();
                if (check) {
                  Get.toNamed(AppRoutes.Main);
                }
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
                  'Continue'.tr,
                  style: TextStyle(color: AppColor.textColor),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
