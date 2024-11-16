import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'bindings/initial_binding.dart';
import 'core/all.dart';

import 'presentation/resource/resource.dart';
import 'presentation/routing/routing.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Set the status bar icon color to black (dark mode)
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark, // Set the icon color to black
        statusBarBrightness:
            Brightness.light, // For iOS status bar background color
      ),
    );
    return ScreenUtilInit(
      designSize: const Size(
        DeviceConstants.designDeviceWidth,
        DeviceConstants.designDeviceHeight,
      ),
      builder: (context, _) {
        return GetMaterialApp(
          initialBinding: InitialBinding(),
          initialRoute: AppPages.initialRoute,
          getPages: AppPages.routes,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: LocaleConfig.supportedLocales,
          locale: Get.locale,
          fallbackLocale: LocaleConfig.defaultLocale,
          localeResolutionCallback: (locale, supportedLocales) {
            talkLanguage = locale!.languageCode;
            return null;
          },
          theme: ThemeData(
            visualDensity: VisualDensity.adaptivePlatformDensity,
            brightness: Brightness.light,
            primaryColor: AppColors.primary,
            textSelectionTheme:
                const TextSelectionThemeData(cursorColor: AppColors.text2),
            dividerTheme: const DividerThemeData(
              color: AppColors.text2,
              thickness: 1,
            ),
          ),
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.light,
          onReady: () async {
            await FirebaseConfig.firebaseMessagingRequestPermission();
          },
          onInit: () {},
        );
      },
    );
  }
}

class _AppWrapper extends StatefulWidget {
  final Widget child;

  const _AppWrapper({
    required this.child,
  });

  @override
  State<_AppWrapper> createState() => __AppWrapperState();
}

class __AppWrapperState extends State<_AppWrapper> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // disconnect socket when app is in background
    switch (state) {
      case AppLifecycleState.resumed:
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.hidden:
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context)
          .copyWith(textScaler: const TextScaler.linear(1.0)),
      child: ScrollConfiguration(
        behavior: const ScrollBehavior().copyWith(
          physics: const ClampingScrollPhysics(),
        ),
        child: widget.child,
      ),
    );
  }
}
