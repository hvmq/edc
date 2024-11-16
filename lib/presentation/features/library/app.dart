import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'core/bindings/app_binding.dart';
import 'core/routes/app_pages.dart';
import 'core/routes/app_routes.dart';
import 'core/utils/langs/localization.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _AppState();
}

class _AppState extends State<MyApp> {
  void initialization() async {
    print('ready in 1...');
    print('go!');
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Demo app',
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.fade,
      theme: ThemeData(primaryColor: Colors.blue),
      translations: MyTranslations(),
      locale: MyTranslations.locale,
      fallbackLocale: MyTranslations.fallbackLocaleVi,
      initialRoute: AppRoutes.Splash,
      getPages: pages,
      initialBinding: AppBinding(),
      smartManagement: SmartManagement.keepFactory,
      builder: EasyLoading.init(builder: (context, widget) {
        return MediaQuery(
            data: MediaQuery.of(context)
                .copyWith(textScaler: const TextScaler.linear(1.0)),
            child: Navigator(
              onGenerateRoute: (settings) => MaterialPageRoute(
                builder: (context) => Container(
                  child: widget!,
                ),
              ),
            ));
      }),
    );
  }
}
