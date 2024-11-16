import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/routes/app_routes.dart';
import '../../core/utils/color.dart';
import '../../features/revenue_statistics/revenueStatisticsController.dart';

class RevenueStatisticsScreen extends GetView<RevenuestatisticsController> {
  const RevenueStatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Total revenue',
          style: TextStyle(color: Colors.black, fontSize: 18),
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
                  color: AppColor.blueColor_3,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 8),
              Column(
                children: [
                  Obx(() => SizedBox(
                        width: Get.width,
                        child: Text(
                          'Total Revenue: ${controller.getTotalRevenue().toStringAsFixed(0)} Loyalty Points',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      )),
                  Obx(() => SizedBox(
                        width: Get.width,
                        child: Text(
                          'Total Books Sold: ${controller.getTotalBooksSold()}',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      )),
                ],
              ),
              const SizedBox(height: 24),
              Text(
                'Revenue by Book',
                style: TextStyle(
                  color: AppColor.blueColor_3,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 8),

              // Make RevenueList internally reactive
              const RevenueList(),

              const SizedBox(height: 24),

              // Details Button
              Center(
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoutes.RevenuesByBook);
                  },
                  child: Container(
                    width: Get.width - 40,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 10),
                    decoration: BoxDecoration(
                      color: AppColor.blueColor_4,
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: Text(
                      'Details',
                      style:
                          TextStyle(color: AppColor.primaryColor, fontSize: 16),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Chart Section
              const Text(
                'Chart',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 12),

              // Remove Obx here, and handle reactivity inside RevenueChart
              const RevenueChart(),
            ],
          ),
        ),
      ),
    );
  }
}

// Custom Widget for Revenue List with Obx inside
class RevenueList extends StatelessWidget {
  const RevenueList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Access the controller
    final controller = Get.find<RevenuestatisticsController>();

    // Use Obx inside the widget to observe changes in revenueByBook
    return Obx(() {
      if (controller.revenueByBook.isEmpty) {
        return const Center(
          child: Text(
            'No data available.',
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
        );
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: controller.revenueByBook
            .map((book) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    '${book.title}: ${book.quantity} sold, ${book.price * book.quantity} LP',
                    style: TextStyle(
                      color: AppColor.greyColor,
                      fontSize: 14,
                    ),
                  ),
                ))
            .toList(),
      );
    });
  }
}

// Custom Widget for Chart with internal Obx for reactivity
class RevenueChart extends StatelessWidget {
  const RevenueChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Access the controller
    final controller = Get.find<RevenuestatisticsController>();

    // Observe chartData inside Obx here
    return Obx(() {
      if (controller.chartData.isEmpty) {
        return const Center(
          child: Text(
            'No chart data available.',
            style: TextStyle(color: Colors.grey),
          ),
        );
      }

      return Container(
        height: 300,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: BarChart(
          BarChartData(
            alignment: BarChartAlignment.spaceAround,
            backgroundColor: Colors.white,
            barTouchData: BarTouchData(
              touchTooltipData: BarTouchTooltipData(
                getTooltipItem: (group, groupIndex, rod, rodIndex) {
                  final String month = getMonthLabel(group.x.toInt());
                  return BarTooltipItem(
                    '$month\n',
                    const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 9,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: '${rod.toY.round()}',
                        style: const TextStyle(
                          color: Colors.yellowAccent,
                          fontSize: 9,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            barGroups: controller.chartData.asMap().entries.map((entry) {
              final int index = entry.key;
              final double value = entry.value;
              return BarChartGroupData(
                x: index,
                barRods: [
                  BarChartRodData(
                    toY: value,
                    color: Colors.blue,
                    width: 10,
                  ),
                ],
              );
            }).toList(),
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    return Text(
                      '${value.toInt()}',
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    );
                  },
                ),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    return Padding(
                      // Add padding to reduce overlap
                      padding: const EdgeInsets.only(
                          top: 10), // Adjust the top padding
                      child: Text(
                        getMonthLabel(value.toInt()),
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 10,
                          // Reduced font size
                        ),
                      ),
                    );
                  },
                ),
              ),
              topTitles: const AxisTitles(),
              rightTitles: const AxisTitles(),
            ),
          ),
        ),
      );
    });
  }

  String getMonthLabel(int month) {
    const months = [
      'JAN',
      'FEB',
      'MAR',
      'APR',
      'MAY',
      'JUN',
      'JUL',
      'AUG',
      'SEP',
      'OCT',
      'NOV',
      'DEC'
    ];
    return months[month];
  }
}
