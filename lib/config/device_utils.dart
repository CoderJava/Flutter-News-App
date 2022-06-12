import 'package:device_info_plus/device_info_plus.dart';

enum BuildMode {
  debug,
  profile,
  release,
}

class DeviceUtils {
  static BuildMode currentBuildMode() {
    if (const bool.fromEnvironment('dart.vm.product')) {
      return BuildMode.release;
    }
    var result = BuildMode.profile;
    assert(() {
      result = BuildMode.debug;
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