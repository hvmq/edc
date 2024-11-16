import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/routes/app_routes.dart';
import '../../core/utils/color.dart';
import '../../features/revenue_statistics/revenueStatisticsController.dart';

class RevenueByBookScreen extends GetView<RevenuestatisticsController> {
  const RevenueByBookScreen({super.key});
  @override
  Widget build(BuildContext context) {
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
          'Revenue by Book',
          style: TextStyle(
              color: Colors.white, fontSize: 18), // Adjusted font size
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          // Observe changes in the books list
          return ListView.builder(
            itemCount: controller.revenueByBook.length,
            itemBuilder: (context, index) {
              final book = controller.revenueByBook[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              book.title,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: AppColor.blueColor_4, // Title color
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Total Revenue: ${book.totalRevenue}',
                              style: TextStyle(
                                  fontSize: 14, color: AppColor.greyColor),
                            ),
                            Text(
                              'Total Books Sold: ${book.quantity}',
                              style: TextStyle(
                                  fontSize: 14, color: AppColor.greyColor),
                            ),
                            Text(
                              'Unit price: ${book.price}',
                              style: TextStyle(
                                  fontSize: 14, color: AppColor.greyColor),
                            ),
                            const SizedBox(height: 8),
                          ],
                        ),
                        Align(
                          child: GestureDetector(
                            onTap: () async {
                              await controller.loadRevenueByABook(book.id).then(
                                (value) {
                                  Get.toNamed(AppRoutes.DetailRevenueStatistics,
                                      arguments: {
                                        'total': book.quantity,
                                        'revenueOfABook':
                                            controller.revenueOfABook,
                                        'totalRevenue':
                                            book.price * book.quantity,
                                      });
                                },
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: AppColor.secondaryColor,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.more_horiz,
                                color: AppColor.textColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Divider(
                        color: AppColor.greyColor
                            .withOpacity(0.1)), // Divider between books
                  ],
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
