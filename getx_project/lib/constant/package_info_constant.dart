import 'package:package_info_plus/package_info_plus.dart';

class PackageInformation {
  static final PackageInformation _instance = PackageInformation._internal();

  factory() {
    return _instance;
  }

  PackageInformation._internal();

  static String version = "";
  static String buildNumber = "";

  static getBuildInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version = packageInfo.version;
    buildNumber = packageInfo.buildNumber;

    print('package info .. $version $buildNumber');
  }
}
