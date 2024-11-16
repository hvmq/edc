import 'package:get/get.dart';

import '../../features/bookdetail/book_detail_controller.dart';

class BookDetailBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<BookDetailController>(BookDetailController());
  }
}
