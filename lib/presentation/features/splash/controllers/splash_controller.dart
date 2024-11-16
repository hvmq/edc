import 'dart:async';

import 'package:get/get.dart';

import '../../../../data/preferences/app_preferences.dart';
import '../../../base/all.dart';
import '../../../common_controller.dart/all.dart';
import '../../../routing/routers/app_pages.dart';

class SplashController extends BaseController {
  final _appPreferences = Get.find<AppPreferences>();

  @override
  Future<void> onReady() async {
    final appController = Get.find<AppController>();

    await appController.restoreStateCompleter.future;

    final token = await _appPreferences.getAccessToken();
    if (appController.lastLoggedUser != null &&
        token != null &&
        token.isNotEmpty) {
      // unawaited(Get.offNamed(Routes.callGateway));

      await _getCurrentUser();
      if (currentUser.phone != null &&
          currentUser.nickname != null &&
          currentUser.phone!.isNotEmpty &&
          currentUser.nickname!.isNotEmpty) {
        unawaited(Get.offNamed(AppPages.afterAuthRoute));
      } else {
        await logout();
      }
    } else {
      unawaited(Get.offNamed(Routes.authOption));
    }

    super.onReady();
  }

  Future<void> _getCurrentUser() async {}
}
