import 'package:device_info_plus/device_info_plus.dart';

enum BuildMode {
  DEBUG,
  PROFILE,
  RELEASE,
}

class DeviceUtils {
  static BuildMode currentBuildMode() {
    if (const bool.fromEnvironment('dart.vm.product')) {
      return BuildMode.RELEASE;
    }
    var result = BuildMode.PROFILE;
    assert(() {
      result = BuildMode.DEBUG;
      return true;
    }());
    return result;
  }

  static Future<AndroidDeviceInfo> androidDeviceInfo() async {
    final deviceInfoPlugin = DeviceInfoPlugin();
    return deviceInfoPlugin.androidInfo;
  }

  static Future<IosDeviceInfo> iosDeviceInfo() async {
    final deviceInfoPlugin = DeviceInfoPlugin();
    return deviceInfoPlugin.iosInfo;
  }
}