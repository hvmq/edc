import 'package:get/get.dart';

import '../../features/rating/rating_controller.dart';

class RatingBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<RatingController>(RatingController());
  }
}
