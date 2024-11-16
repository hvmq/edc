import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../api/repos/impl/revenue_api.swagger.dart';
import '../../features/revenue_statistics/revenueStatisticsController.dart';

class ReceiptScreen extends GetView<RevenuestatisticsController> {
  const ReceiptScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final OrderDetailOfBook orderDetailOfBook =
        Get.arguments['orders'] as OrderDetailOfBook;

    // Define common text styles
    const TextStyle headerStyle = TextStyle(
        color: Colors.blueAccent, fontSize: 16, fontWeight: FontWeight.bold);
    const TextStyle contentStyle = TextStyle(color: Colors.white, fontSize: 14);
    const TextStyle labelStyle =
        TextStyle(color: Colors.white, fontWeight: FontWeight.bold);

    // A helper method to create a row with label and content
    Widget buildInfoRow(String label, String content) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$label: ', style: labelStyle),
          Expanded(
            child: Text(content, style: contentStyle),
          ),
        ],
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Back',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Buyer Information Section
              const Text('Buyer Information', style: headerStyle),
              const SizedBox(height: 8),
              buildInfoRow('User', 'User-${orderDetailOfBook.userId}'),
              const SizedBox(height: 3),
              buildInfoRow('Email', orderDetailOfBook.email),
              const SizedBox(height: 3),
              buildInfoRow('NFT Number', 'no-data'),
              const SizedBox(height: 20),

              // Bill Information Section
              const Text('Bill Information', style: headerStyle),
              const SizedBox(height: 8),
              buildInfoRow('Order', '${orderDetailOfBook.orderId}'),
              const SizedBox(height: 3),
              buildInfoRow('Date',
                  orderDetailOfBook.orderCreatedAt), // Format date properly
              const SizedBox(height: 3),
              buildInfoRow('Payment method', orderDetailOfBook.paymentMethod),
              const SizedBox(height: 20),

              // Book Information Section
              const Text('Book Information', style: headerStyle),
              const SizedBox(height: 8),
              buildInfoRow(
                  'Book',
                  orderDetailOfBook
                      .bookTitle), // Dynamic content for book title
              const SizedBox(height: 3),
              buildInfoRow('Author', orderDetailOfBook.authorName),
              const SizedBox(height: 3),
              buildInfoRow('Price', '${orderDetailOfBook.bookPrice}'),
              const SizedBox(height: 3),
              buildInfoRow('Voucher', 'no data'),
              const SizedBox(height: 3),
              buildInfoRow('Total cost', '${orderDetailOfBook.bookPrice}'),
            ],
          ),
        ),
      ),
    );
  }
}
