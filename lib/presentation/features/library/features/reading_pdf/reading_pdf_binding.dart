import 'package:get/get.dart';

import '../../features/reading_pdf/reading_pdf_controller.dart';

class ReadingPdfBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ReadingPdfController>(ReadingPdfController());
  }
}
