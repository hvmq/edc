import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../api/repos/impl/revenue_api.swagger.dart';
import '../../core/routes/app_routes.dart';
import '../../core/utils/color.dart';
import '../../features/revenue_statistics/revenueStatisticsController.dart';
import '../../features/revenue_statistics/revenueStatisticsScreen.dart';

class DetailRevenueStatistics extends GetView<RevenuestatisticsController> {
  const DetailRevenueStatistics({super.key});
  @override
  Widget build(BuildContext context) {
    final List<RevenueOfABook> revenueOfABook =
        Get.arguments['revenueOfABook'] as List<RevenueOfABook>;
    final String total = Get.arguments['total'].toString();
    final String totalRevenue = Get.arguments['totalRevenue'].toString();
    return Scaffold(
      backgroundColor:
          AppColor.primaryColor, // Matches the dark background from the image
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Detail',
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
              Text(
                'Revenue',
                style: TextStyle(
                  color: AppColor
                      .blueColor_3, // Updated to white text to match the image
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 8),
              Column(
                children: [
                  SizedBox(
                    width: Get.width,
                    child: Text(
                      'Total: $totalRevenue Loyalty Points',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: Get.width,
                    child: Text(
                      'Number of units sold: $total',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // Chart Section
              const Text(
                'Chart',
                style: TextStyle(
                  color: Colors.white, // Change to white to match the image
                  fontSize: 18, // Adjusted font size to make it smaller
                ),
              ),
              const SizedBox(height: 12),
              const RevenueChart(), // Custom widget to show the chart
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
              // Show More Button
              Center(
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoutes.OrderDetailStatistics, arguments: {
                      'orders': controller.revenueOfABook,
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: Get.width,
                    decoration: BoxDecoration(
                      color: AppColor.blueColor_2,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24.0, vertical: 8.0),
                    child: const Text(
                      'Show more',
                      style: TextStyle(
                        color: Colors.white, // Button text color
                        fontSize: 14,
                      ),
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

class OrderItem extends StatefulWidget {
  final String orderNumber;
  final String date;
  final String nftNumber;
  final String price;
  final String bookId;

  const OrderItem({
    required this.orderNumber,
    required this.date,
    required this.nftNumber,
    required this.price,
    required this.bookId,
    Key? key,
  }) : super(key: key);

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  late RevenuestatisticsController controller;

  @override
  void initState() {
    super.initState();
    // Initialize controller from GetX
    controller = Get.find<RevenuestatisticsController>();
  }

  Future<void> _handleOrderDetails() async {
    // Fetching order details and navigating to the receipt screen
    try {
      final orderDetails = await controller.loadOrderDetailsBook(
          int.tryParse(widget.bookId),
          int.tryParse(widget.orderNumber.replaceAll('Order-', '')));

      if (orderDetails != null) {
        Get.toNamed(AppRoutes.ReceiptScreen,
            arguments: {'orders': orderDetails});
      } else {
        Get.snackbar('Error', 'Failed to load order details.');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Order: ${widget.orderNumber}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                widget.date,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
              Text(
                'NFT Number: ${widget.nftNumber}',
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                widget.price,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.more_horiz, color: Colors.grey),
                onPressed: _handleOrderDetails,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
