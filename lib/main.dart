import 'dart:convert';
import 'package:deco_news/config.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io' show Platform;
import 'helpers/wordpress.dart';
import 'models/post_model.dart';
import 'models/category_model.dart';
import 'helpers/helpers.dart';
import 'screens/home_screen.dart';
import 'screens/single_post.dart';

void main() => runApp(DecoNews());

const String testDevice='';

class DecoNews extends StatefulWidget {
  static final navKey = new GlobalKey<NavigatorState>();
  static final scaffoldKey = new GlobalKey<ScaffoldState>();
  static _DecoNewsState of(BuildContext context) =>
      context.ancestorStateOfType(const TypeMatcher<_DecoNewsState>());
  const DecoNews({Key navKey}) : super(key: navKey);

  @override
  _DecoNewsState createState() => _DecoNewsState();
}

class _DecoNewsState extends State<DecoNews> {
  /// Keeps index of selected item from drawer
  int _selectedDrawerItem = 0;

  /// Theme brightness
  Brightness _brightness;
  String _message='Message';

  /// Firebase messaging
  static FirebaseMessaging firebaseMessaging = new FirebaseMessaging();

  @override
  void initState() {
    super.initState();

    /// set default app theme
    _setDefaultBrightness();
//in case of iOS --- see below

    /// init push notifications
    _initPushNotifications();

    /// init AdMob
    _initAdMob();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: DecoNews.navKey,
      title: 'Business Influx',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: _brightness,
        canvasColor: _brightness == Brightness.dark
            ? Color(0xFF282C39)
            : Color(0xFFFAFAFA),
        primaryColor: _brightness == Brightness.dark
            ? Color(0xFF1B1E28)
            : Color(0xFFFFFFFF),
      ),
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }

  /// Returns index of selected item in drawer
  int getSelected() {
    return _selectedDrawerItem;
  }

  /// Updates index of selected item in drawer
  void setSelected(int index) {
    _selectedDrawerItem = index;
  }

  /// On app launch set correct theme color
  void _setDefaultBrightness() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String brightness = (prefs.getString('brightness') ?? '');

    if (brightness != 'light' && brightness != 'dark') {
      brightness = Config.defaultColor == 'dark' ? 'dark' : 'light';
    }

    setBrightness(brightness == 'dark' ? Brightness.dark : Brightness.light);
  }

  /// Change theme color
  Future<void> setBrightness(Brightness brightness) async {
    setState(() {
      _brightness = brightness;
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('brightness', brightness == Brightness.dark ? 'dark' : 'light');
  }

  /// init push notifications
  Future<void> _initPushNotifications() async {
    //if (!Config.pushNotificationsEnabled) {
      //return;
    //}

    firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('on message $message');
      },
      onResume: (Map<String, dynamic> message) async {
        print('on resume $message');
        //_processPushNotification(message);
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('on launch $message');
        //_processPushNotification(message);
      },
    );

    /*if (Platform.isIOS) {
      iOSPermission();
    }*/

    SharedPreferences prefs = await SharedPreferences.getInstance();
    firebaseMessaging.getToken().then((token){
      if (prefs.getBool('isPushNotificationEnabled') ?? true) {
        //setSubscription(true);
      }
    });
  }

  /*void _processPushNotification(payload) async {
    // get context
    final context = DecoNews.navKey.currentState.overlay.context;

    // debug lines
    // print('Processing push notification. Payload:');
    // print(payload);
    // print(payload['data']);
    // print(payload['data']['post_id']);

    // show loading message
    showLoadingDialog(context);

    // get post id
    int postID = int.parse(payload['data']['post_id']);

    try {
      // get post data by id
      Response postResponse = await WordPress.fetchPost(postID);
      var postData = jsonDecode(postResponse.body);

      // get category data
      var categoryID = postData['categories'][0];
      Response categoryResponse = await WordPress.fetchCategory(categoryID);
      var categoryData = jsonDecode(categoryResponse.body);

      CategoryModel category = CategoryModel.fromJson(categoryData);
      PostModel post = PostModel.fromJson(postData, category);

      // close dialog and open article
      Navigator.of(context, rootNavigator: true).pop('dialog');
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => SinglePost(post),
        )
      );
    } catch(exception) {
      Navigator.of(context, rootNavigator: true).pop('dialog');
      DecoNews.scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text('An error occured loading post data!'),
          duration: Duration(seconds: 5),
        )
      );
    }
  }*/

  /// ask for permission on iOS
  /*void iOSPermission() {
    firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(sound: true, badge: true, alert: true)
    );
    firebaseMessaging.onIosSettingsRegistered.listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
  }*/

  static void _setSettingToStorage(value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isPushNotificationEnabled', value);
  }

  /// Init AdMob
  _initAdMob() {
    if (!Config.adMobEnabled) {
      return;
    }

    bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    FirebaseAdMob.instance.initialize(
      appId: isIOS ? Config.adMobiOSAppID : Config.adMobAndroidID
    );

    /*BannerAd myBanner = BannerAd(
      // Replace the testAdUnitId with an ad unit id from the AdMob dash.
      // https://developers.google.com/admob/android/test-ads
      // https://developers.google.com/admob/ios/test-ads
      adUnitId: BannerAd.testAdUnitId,
      size: AdSize.smartBanner,
      listener: (MobileAdEvent event) {
        print("BannerAd event is $event");
      },
    );*/

    InterstitialAd myInterstitial =InterstitialAd(
      //adUnitId: 'ca-app-pub-4032939027466706/3858252094',
      adUnitId: InterstitialAd.testAdUnitId,
      listener: (MobileAdEvent event) {
        print("IntAd event is $event");
        if(event==MobileAdEvent.loaded){

        }
      },
    );

    /// load banner
    /*myBanner
      ..load()
      ..show(anchorType: Config.adMobPosition != 'top' ? AnchorType.bottom : AnchorType.top);*/
    
    Future.delayed(const Duration(minutes: 4),(){
      myInterstitial
        ..load()
        ..show();
    });


  }


}
