import 'dart:io';

class AdHelper {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-9006686949223192/4960140849";
    } else if (Platform.isIOS) {
      return "ca-app-pub-9006686949223192/6676547195";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return "";
    } else if (Platform.isIOS) {
      return "ca-app-pub-9006686949223192/8798698526";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }
}
