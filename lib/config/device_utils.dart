import 'package:device_info/device_info.dart';

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
    var deviceInfoPlugin = DeviceInfoPlugin();
    return deviceInfoPlugin.androidInfo;
  }

  static Future<IosDeviceInfo> iosDeviceInfo() async {
    var deviceInfoPlugin = DeviceInfoPlugin();
    return deviceInfoPlugin.iosInfo;
  }

}