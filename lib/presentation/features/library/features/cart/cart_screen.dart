import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../../api/repos/impl/order_api.swagger.dart';
import '../../core/routes/app_routes.dart';
import '../../core/utils/color.dart';
import '../../core/utils/resource/assets_constant/icon_constatnt.dart';
import '../../core/utils/show_noti.dart';
import 'cart_controller.dart';

class CartScreen extends GetView<CartController> {
  const CartScreen({super.key});

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
              Obx(
                () => Text(
                  '${'Cart'.tr} (${controller.cartItems.length})',
                  style: TextStyle(
                    color: AppColor.textColor,
                    fontSize: 20,
                  ),
                ),
              ),
              const Spacer(flex: 3),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        child: Obx(() {
          return Column(
            children: controller.cartItems.map((item) {
              final int index = controller.cartItems.indexOf(item);
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 4),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColor.textOppositeColor,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 5,
                        spreadRadius: 2,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      // Checkbox for selecting product
                      Container(
                        padding: EdgeInsets.zero,
                        child: Checkbox(
                          value: controller.selectedIndices.contains(index),
                          onChanged: (value) {
                            controller.toggleSelection(index);
                          },
                        ),
                      ),
                      // Product image
                      SizedBox(
                        width: Get.width * 0.28,
                        height: 100,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child:
                              (item['image'] != null && item['image'].isNotEmpty
                                  ? Image.network(
                                      item['image'],
                                      height: 220,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      'lib/core/utils/resource/image/default-book.png', // Path to your placeholder image
                                      height: 220,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    )),
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Product details and quantity controls
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              controller.shortenString(item['name'], 22),
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColor.textColor,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              "${item['author']} - Book(${item['category'] == null || item['category'] == '' ? 'Unknown' : item['category']})",
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColor.greyColor,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Container(
                              margin: const EdgeInsets.only(top: 4),
                              child: GradientText(
                                controller.getPriceFormatter(item['price']),
                                style: const TextStyle(fontSize: 12.0),
                                gradientType: GradientType.radial,
                                radius: 2.5,
                                colors: const [
                                  Color(0xFF0E81FC), // Starting color
                                  Color(0xFF369C09), // Ending color
                                ],
                              ),
                            ),
                            // Text(
                            //   'Price: \$${item['price'].toStringAsFixed(2)}',
                            //   style: TextStyle(
                            //     fontSize: 14,
                            //     color: AppColor.blueColor_3,
                            //   ),
                            // ),
                            const SizedBox(height: 4),
                          ],
                        ),
                      ),
                      // Delete button
                      IconButton(
                        icon: Icon(Icons.delete, color: AppColor.blueColor_4),
                        onPressed: () => controller.removeItem(index),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        }),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColor.textOppositeColor,
        ),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: RichText(
                      text: TextSpan(children: [
                        WidgetSpan(
                            child: Container(
                          margin: const EdgeInsets.only(right: 12),
                          width: 20,
                          height: 16,
                          child: Image.asset(IconConstants.voucher),
                        )),
                        TextSpan(
                          text: 'Voucher',
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColor.textColor,
                          ),
                        ),
                      ]),
                    )),
                Obx(() => GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.Voucher);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Text(
                          controller.voucherCode.value.isNotEmpty
                              ? controller.voucherCode.value
                              : 'No voucher applied', // Display the selected voucher code or a default message
                          style: TextStyle(
                            fontSize: 16,
                            color: controller.voucherCode.value.isNotEmpty
                                ? Colors.green
                                : Colors
                                    .red, // Change color based on whether a voucher is applied
                          ),
                        ),
                      ),
                    )),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Obx(() => Checkbox(
                          value: controller.selectedIndices.length ==
                              controller.cartItems.length,
                          onChanged: (value) {
                            if (value == true) {
                              controller.selectAllItems();
                            } else {
                              controller.clearSelections();
                            }
                          },
                        )),
                    Text(
                      'Check All',
                      style: TextStyle(color: AppColor.textColor),
                    ),
                  ],
                ),
                Obx(() => Container(
                      margin: const EdgeInsets.only(top: 4),
                      child: Row(children: [
                        Text(
                          'Total: ',
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColor.textColor,
                          ),
                        ),
                        GradientText(
                          controller
                              .getPriceFormatter(controller.getTotalPrice()),
                          style: const TextStyle(fontSize: 16.0),
                          gradientType: GradientType.radial,
                          radius: 2.5,
                          colors: const [
                            Color(0xFF0E81FC), // Starting color
                            Color(0xFF369C09), // Ending color
                          ],
                        ),
                      ]),
                    ))
              ],
            ),
            GestureDetector(
              onTap: () async {
                // Proceed to payment logic
                if (controller.selectedIndices.isNotEmpty) {
                  // Display payment confirmation
                  // showInfo('Payment',
                  //     'You are about to pay for ${controller.selectedIndices.length} items.');
                  // Clear selections after payment
                  // controller.clearSelections();
                  final MakeOrderResponse? order = await controller.makeOrder();
                  showPopup(context, order);
                } else {
                  showInfo(
                      'Warning', 'Please select at least one item to pay.');
                }
              },
              child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                      color: AppColor.blueColor_2,
                      borderRadius: BorderRadius.circular(50)),
                  child: Text(
                    'Buy now',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColor.textOppositeColor,
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }

// Hàm để hiển thị popup với TextField
  // Hàm để hiển thị popup
  void showPopup(BuildContext context, MakeOrderResponse? order) {
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
                  'Select a payment method'.tr,
                  style: TextStyle(
                      color: AppColor.textColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Text(
                'Experience the values ​​that books will bring to you with Educhain.',
                style: TextStyle(color: AppColor.textColor, fontSize: 14),
              ),
              Container(
                  decoration: BoxDecoration(
                    color: AppColor.blueColor_3.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(top: 16),
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Buy with Loyalty point',
                            style: TextStyle(color: AppColor.textColor),
                          ),
                          Obx(() {
                            return Text(
                              'Current balance: ${controller.totalLoyaltyPoint.value}',
                              style: TextStyle(
                                color: AppColor.textColor,
                                fontWeight: FontWeight.w100,
                                fontSize: 12,
                              ),
                            );
                          })
                        ],
                      ),
                      Stack(
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                                color: AppColor.blueColor,
                                shape: BoxShape.circle),
                          ),
                          Positioned(
                              left: 4,
                              top: 4,
                              child: Container(
                                width: 12,
                                height: 12,
                                decoration: BoxDecoration(
                                    color:
                                        AppColor.blueColor_3.withOpacity(0.5),
                                    shape: BoxShape.circle),
                              ))
                        ],
                      )
                    ],
                  ))
            ],
          ),
          actions: [
            GestureDetector(
              onTap: () async {
                // Xử lý thanh toán
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Processing payment...')),
                );

                Navigator.of(context).pop();
                if (order != null) {
                  final PayOrderResponse? payOrderResponse =
                      await controller.payOrder(order.data.id);
                  // Navigate to Payment screen if order is successful
                  if (payOrderResponse != null &&
                      payOrderResponse.orderStatus == 'Completed') {
                    Get.toNamed(AppRoutes.Payment, arguments: order);
                  } else {
                    Get.toNamed(AppRoutes.Payment, arguments: order);
                  }
                } else {
                  Get.toNamed(AppRoutes.Payment);
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
                  'Pay'.tr,
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
