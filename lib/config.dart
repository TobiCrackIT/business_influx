
class Config {

  /// Define your WordPress API url here
  static final apiEndpoint = 'https://businessinflux.com/wp-json/wp/v2';

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
  //static final adMobAndroidID = 'ca-app-pub-7868270859526221~7198068286';
  static final adMobAndroidID='ca-app-pub-8950463783824302~2542988770';
  //static final adMobAdUnitID = 'ca-app-pub-4032939027466706/3858252094';
  static final adMobPosition = 'bottom';
  //static final bannerAdUnitID='ca-app-pub-4032939027466706/6923399138';
  static final bannerAdUnitID='ca-app-pub-8950463783824302/6211960411';
  static final interstitialAdUnitID='ca-app-pub-8950463783824302/7844606286';
  static final nativeAdUnitID='ca-app-pub-8950463783824302/2535249918';
  static final nativeTestAdUnitID='ca-app-pub-3940256099942544/2247696110';
}
