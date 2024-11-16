import 'package:get/get.dart';

import '../../features/library/library_controller.dart';
import '../../features/library/see_more/see_more_controller.dart';

class LibraryBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<LibraryController>(LibraryController());
    Get.put<SeeMoreController>(SeeMoreController());
  }
}
