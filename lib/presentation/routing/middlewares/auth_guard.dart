import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common_controller.dart/app_controller.dart';

class AuthGuard extends GetMiddleware {
  final AppController _appController = Get.find();

  @override
  RouteSettings? redirect(String? route) {
    return null;
  }
}
