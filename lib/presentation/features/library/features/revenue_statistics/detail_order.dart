import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../api/repos/impl/revenue_api.swagger.dart';
import '../../core/utils/color.dart';
import '../../features/revenue_statistics/revenueStatisticsController.dart';
import 'detail_revenue_statistics.dart';

class OrderDetailStatistics extends GetView<RevenuestatisticsController> {
  const OrderDetailStatistics({super.key});
  @override
  Widget build(BuildContext context) {
    List<RevenueOfABook> revenueOfABook =
        Get.arguments["orders"] as List<RevenueOfABook>;
    return Scaffold(
      backgroundColor:
          AppColor.primaryColor, // Matches the dark background from the image
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Order details',
          style: TextStyle(
              color: Colors.white, fontSize: 18), // Adjusted font size
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Revenue Section
              // Text(
              //   'Revenue',
              //   style: TextStyle(
              //     color: AppColor.blueColor_3, // Updated to white text to match the image
              //     fontSize: 16,
              //     fontWeight: FontWeight.w400,
              //   ),
              // ),
              // const SizedBox(height: 8),
              Obx(() {
                return Column(
                  children: controller.revenueOfABook.map((order) {
                    return OrderItem(
                      orderNumber: 'Order-${order.orderId}',
                      date: DateFormat('dd-MM-yyyy hh:mm:ss')
                          .format(order.createdAt),
                      nftNumber: 'no data',
                      price: order.price.toString(),
                      bookId: '${order.bookId}',
                    );
                  }).toList(),
                );
              }),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
