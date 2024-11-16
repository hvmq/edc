import 'package:event_bus/event_bus.dart';
import 'package:get/get.dart';

import '../data/api/clients/all.dart';
import '../data/api/clients/mana_mission_api_client.dart';
import '../data/preferences/app_preferences.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    _bindDatasource();
  }

  void _bindDatasource() {
    Get.put<AppPreferences>(AppPreferences(), permanent: true);
    Get.put<EventBus>(EventBus(), permanent: true);
    Get.put<UnAuthenticatedRestApiClient>(UnAuthenticatedRestApiClient());
    Get.put<AuthenticatedRestApiClient>(AuthenticatedRestApiClient());
    Get.put<AuthenticatedGraphQLApiClient>(
      AuthenticatedGraphQLApiClient(),
    );
    Get.put<ChatApiClient>(ChatApiClient());

    Get.put<ManaMissionApiClient>(ManaMissionApiClient());
  }
}
