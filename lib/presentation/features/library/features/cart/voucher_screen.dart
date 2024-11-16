import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../resource/resource.dart';
import '../../core/utils/color.dart';
import '../../core/utils/resource/assets_constant/icon_constatnt.dart';
import 'cart_controller.dart';

class VoucherScreen extends GetView<CartController> {
  const VoucherScreen({super.key});

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
              const Spacer(),
              Text(
                'Choose Voucher'.tr,
                style: TextStyle(
                  color: AppColor.textColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(flex: 3),
            ],
          ),
        ),
      ),
      body: Obx(() {
        // Check if the vouchers list is empty
        if (controller.vouchers.isEmpty) {
          return Center(
            child: Text(
              'No vouchers available'.tr,
              style: TextStyle(
                color: AppColor.textColor,
                fontSize: 18,
              ),
            ),
          );
        } else {
          // Display the list of vouchers if available
          return ListView.builder(
            itemCount: controller.vouchers.length,
            itemBuilder: (context, index) {
              final voucher = controller.vouchers[index];
              return GestureDetector(
                onTap: () {
                  controller
                      .selectVoucher(index); // Update the selected voucher
                },
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.grey7,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: controller.selectedVoucherIndex.value == index
                          ? AppColor.blueColor
                          : Colors.transparent,
                      width: 2,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0, 4),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      // Left side: Voucher icon or label
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: const BoxDecoration(
                          color: AppColors.grey7,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            bottomLeft: Radius.circular(12),
                          ),
                        ),
                        child: SizedBox(
                          width: 100,
                          height: 100,
                          child: Image.asset(IconConstants.discount),
                        ),
                      ),
                      // Right side: Voucher details
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                voucher.title,
                                style: TextStyle(
                                  color: AppColor.textColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Expiring soon: ${voucher.expiration}',
                                style: TextStyle(
                                  color: AppColor.greyColor,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Rightmost: Radio button
                      Obx(() => Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: Checkbox(
                              value: controller.selectedVoucherIndex.value ==
                                  index,
                              onChanged: (value) {
                                if (value == true) {
                                  controller.selectVoucher(
                                      index); // Update selected voucher index
                                } else {
                                  controller.selectVoucher(
                                      -1); // Deselect if clicked again
                                }
                              },
                              activeColor: AppColor.blueColor_4,
                            ),
                          ))
                    ],
                  ),
                ),
              );
            },
          );
        }
      }),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: AppColor.blueColor_2,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Text(
                  'Confirm'.tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColor.primaryColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
