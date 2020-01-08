import 'package:firebase_admob/firebase_admob.dart';

class Config {

  /// Define your WordPress API url here
  static final apiEndpoint = 'https://insideoyo.com/wp-json/wp/v2';

  /// Define your default color (light or dark)
  // static final defaultColor = 'dark';
  static final defaultColor = 'light';

  /// Define category IDs which you want to exclude
  // static final excludeCategories = [1, 4, 5];
  static final excludeCategories = [];

  /// Enable push notifications
  static final pushNotificationsEnabled = true;

  /// AdMob settings
  static final adMobEnabled = true;
  static final adMobiOSAppID = 'ca-app-pub-7868270859526221~2024798504';
  static final adMobAndroidID='ca-app-pub-1154177750913084~3505528727'; //mine
  static final adMobPosition = 'bottom';
  static final interstitialAdUnitID='ca-app-pub-1154177750913084/5644606901';
  static final bannerAdUnitID='ca-app-pub-1154177750913084/8913768072';
  static final nativeAdUnitID='ca-app-pub-4032939027466706/4205983878';
  static final nativeTestAdUnitID='ca-app-pub-3940256099942544/2247696110';
}
