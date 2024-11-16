import 'package:get/get.dart';

import '../../features/bookopen/book_open_controller.dart';

class BookOpenBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<BookOpenController>(BookOpenController());
  }
}
