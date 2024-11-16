import 'package:get/get.dart';

import '../../features/author/author_controller.dart';

class DetailAuthorBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<DetailAuthorController>(DetailAuthorController());
  }
}
