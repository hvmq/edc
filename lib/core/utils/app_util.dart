import 'package:package_info_plus/package_info_plus.dart';

class AppUtil {
  static Future<String> getVersion() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();

    return packageInfo.version;
  }
}
