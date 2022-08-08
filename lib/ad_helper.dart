import 'dart:io';

class AdHelper {
  static const eCPM = 4.13;

  static String convertAdImpressionToRevenue(final int count) {
    return (count / 1000 * eCPM).toStringAsFixed(4);
  }

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/6300978111';
    } else if (Platform.isIOS) {
      //return 'ca-app-pub-3940256099942544/2934735716';
      return 'ca-app-pub-8937919014515378/4231007324';
    } else {
      throw new UnsupportedError('Unsupported platform');
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-3940256099942544/1033173712";
    } else if (Platform.isIOS) {
      return "ca-app-pub-3940256099942544/4411468910";
      //return "ca-app-pub-3940256099942544/4411468910";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get rewardedAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-3940256099942544/5224354917";
    } else if (Platform.isIOS) {
      //return "ca-app-pub-3940256099942544/1712485313";
      return "ca-app-pub-8937919014515378/4517684450";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }
}
