import 'dart:async';

import 'package:get/get.dart';

import '../../core/controllers/app_controller.dart';
import '../../core/routes/app_routes.dart';

class SplashController extends AppController {
  @override
  Future<void> onInit() async {
    super.onInit();
    await loadInitSplashScreen();
  }

  Future<void> loadInitSplashScreen() async {
    Timer(const Duration(seconds: 2), () {
      Get.toNamed(AppRoutes.Main);
    });
  }
}
