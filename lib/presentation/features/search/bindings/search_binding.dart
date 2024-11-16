import 'package:get/get.dart';

import '../controllers/search_controller.dart';

class SearchInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchInfoController>(() => SearchInfoController());
  }
}
