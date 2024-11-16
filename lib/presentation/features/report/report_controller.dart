import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/all.dart';
import '../../base/base_controller.dart';

enum ReportType { post, comment, message }

class ReportArgs {
  final ReportType type;
  final dynamic data;

  ReportArgs({
    required this.type,
    required this.data,
  });
}

class ReportController extends BaseController {
  RxList<CategoryReport> categories = <CategoryReport>[].obs;

  TextEditingController reportController = TextEditingController();
  late ReportType type;
  late int postId;
  late dynamic data;

  @override
  Future<void> onInit() async {
    final args = Get.arguments as ReportArgs;
    type = args.type;
    data = args.data;

    getCategoriesReport();
    super.onInit();
  }

  void getCategoriesReport() {}

  void changeSelectedCategory(int index) {
    categories[index].isSelected = !categories[index].isSelected;
    categories.refresh();
  }

  void report() {
    switch (type) {
      case ReportType.post:
        reportPost();
        break;
      case ReportType.comment:
        reportComment();
        break;
      case ReportType.message:
        reportMessage();
        break;
    }
  }

  void reportPost() {}

  void reportComment() {}

  void reportMessage() {}
}
