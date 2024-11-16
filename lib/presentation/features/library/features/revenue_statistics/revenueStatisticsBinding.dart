import 'package:get/get.dart';

import '../../features/revenue_statistics/revenueStatisticsController.dart';

class Revenuestatisticsbinding extends Bindings {
  @override
  void dependencies() {
    Get.put<RevenuestatisticsController>(RevenuestatisticsController());
  }
}
