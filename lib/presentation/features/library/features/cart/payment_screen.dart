import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../api/repos/impl/order_api.swagger.dart';
import '../../core/utils/color.dart';
import '../../core/utils/resource/assets_constant/image_constant.dart';
import 'cart_controller.dart';

class PaymentScreen extends GetView<CartController> {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Variables for order data
    List<OrderItem>? orderItems;
    String? paymentMethod;
    double? totalPrice;

    // Check if Get.arguments is available
    if (Get.arguments != null) {
      final MakeOrderResponse order = Get.arguments as MakeOrderResponse;
      final OrderData orderData = order.data;
      orderItems = orderData.orderItems;
      paymentMethod = orderData.paymentMethod;
      totalPrice = orderData.totalPrice;
    } else {
      // Handle case when arguments are missing
      orderItems = [];
      paymentMethod = 'Unknown';
      totalPrice = 0.0;
    }

    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Stack(
                children: [
                  Obx(
                    () => Container(
                      alignment: Alignment.center,
                      height: Get.height * 0.6,
                      margin: const EdgeInsets.only(top: 12),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                          image: AssetImage(controller.isStatus.value == true
                              ? ImageConstants.bgBook
                              : ImageConstants.flare),
                          fit: BoxFit.none,
                        ),
                        color: AppColor.primaryColor,
                      ),
                    ),
                  ),
                  Obx(() => Container(
                        height: Get.height * 0.6,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(
                            vertical: 24, horizontal: 32),
                        child: Image.asset(controller.isStatus.value == true
                            ? ImageConstants.payment
                            : ImageConstants.payment1),
                      )),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              alignment: Alignment.bottomCenter,
              height: Get.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Obx(
                    () => Column(
                      children: [
                        Text(
                          controller.isStatus.value == true
                              ? 'Payment Success!'
                              : 'Payment Fail!',
                          style: TextStyle(
                            color: controller.isStatus.value == true
                                ? AppColor.greenColor
                                : AppColor.redColor,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // const SizedBox(
                        //     height:
                        //         4), // Add space between title and description
                        Text(
                          controller.descriptionResponse.value,
                          style: TextStyle(
                            color: AppColor.textColor,
                            fontSize: 15,
                          ),
                          textAlign: TextAlign
                              .center, // Align the description to center
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                      height: 0), // Space before the book list starts
                  _buildBookList(orderItems),
                  _buildPriceDetails(controller.getPriceFormatter(totalPrice)),

                  GestureDetector(
                    onTap: () async {
                      if (controller.isStatus.value == true) {
                        // Clear order
                        await controller.clearCartItems();

                        Get.back();
                      } else {
                        Get.back();
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 12),
                      width: Get.width,
                      decoration: BoxDecoration(
                        color: AppColor.blueColor_3,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Text(
                        'Back',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: AppColor.textColor),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBookList(List<OrderItem>? orderItems) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.withOpacity(0.2),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start, // Align all children to the left
        children: [
          Text(
            'Books:',
            style: TextStyle(color: AppColor.text, fontSize: 16),
          ),
          const SizedBox(
              height: 8), // Add some spacing between label and book list
          ...orderItems!.map((item) {
            return FutureBuilder<String>(
              future: controller
                  .getBookName(item.bookId), // Fetch book name asynchronously
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Align(
                      alignment:
                          Alignment.centerRight, // Align text to the left
                      child: Text(
                        'Loading...',
                        style: TextStyle(
                          color: AppColor.greyColor,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Align(
                      alignment:
                          Alignment.centerRight, // Align text to the left
                      child: Text(
                        'Error loading book',
                        style: TextStyle(
                          color: AppColor.redColor,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Align(
                      alignment:
                          Alignment.centerRight, // Align text to the left
                      child: Text(
                        snapshot.data ?? 'Unknown Book',
                        style: TextStyle(
                          color: AppColor.textColor,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  );
                }
              },
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildPriceDetails(String? totalPrice) {
    return Column(
      children: [
        _buildPriceRow('Price:', '${totalPrice ?? 0}'),
        _buildPriceRow('Discount:', controller.getVoucherPercent()),
        _buildPriceRow(
          'Total:',
          '${totalPrice ?? 0}',
          isTotal: true,
        ),
      ],
    );
  }

  Widget _buildPriceRow(String? label, String? value, {bool isTotal = false}) {
    return Container(
      margin: const EdgeInsets.only(top: 4),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.withOpacity(0.2),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label ?? '',
            style: TextStyle(
              color: AppColor.text,
              fontSize: 16,
            ),
          ),
          Text(
            value ?? '',
            style: TextStyle(
              color: isTotal ? AppColor.greenColor : AppColor.textColor,
              fontSize: 16,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
            textAlign: TextAlign.end,
          ),
        ],
      ),
    );
  }
}
