import 'dart:convert';
import 'dart:io';
import 'package:deco_news/config.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/home_screen.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:animated_splash/animated_splash.dart';

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
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin=new FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();

    /// set default app theme
    _setDefaultBrightness();
//in case of iOS --- see below

    /// init push notifications
    _initPushNotifications();
    configLocalNotifications();

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
        print('On message : $message');
        showNotification(message);
        return;
        /*setState(() {

          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              content: ListTile(
                title: Text(message['notification']['title']),
                subtitle: Text(message['notification']['body']),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text('Ok'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          );

        });*/


      },
      onResume: (Map<String, dynamic> message) async {
        print('On Resume $message');
        //_processPushNotification(message);
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('On Launch $message');
        //_processPushNotification(message);
      },
    );

    /*if (Platform.isIOS) {
      iOSPermission();
    }*/

    SharedPreferences prefs = await SharedPreferences.getInstance();
    firebaseMessaging.getToken().then((token){
      print('FCM Token: ${token.toString()}');
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
  /// Init AdMob
  _initAdMob() {
    if (!Config.adMobEnabled) {
      return;
    }

    bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    FirebaseAdMob.instance.initialize(
        appId: isIOS ? Config.adMobiOSAppID : Config.adMobAndroidID
    );

    BannerAd myBanner = BannerAd(
      adUnitId: Config.bannerAdUnitID,
      //adUnitId: BannerAd.testAdUnitId,
      size: AdSize.smartBanner,
      listener: (MobileAdEvent event) {
        print("BannerAd event is $event");
        //if(event==MobileEv)
      },
    );

    InterstitialAd myInterstitial =InterstitialAd(
      adUnitId: Config.interstitialAdUnitID,
      //adUnitId: InterstitialAd.testAdUnitId,
      listener: (MobileAdEvent event) {
        print("InterstitialAd event is $event");
        if(event==MobileAdEvent.loaded){

        }
      },
    );




    /// load banner
    myBanner
      ..load()
      ..show(anchorType: Config.adMobPosition != 'top' ? AnchorType.bottom : AnchorType.top);

    Future.delayed(const Duration(minutes: 2),(){
      myInterstitial
        ..load()
        ..show();
    });


  }

  void configLocalNotifications(){
    var initializeAndroidSettings=new AndroidInitializationSettings('app_icon');
    var initializeIOSSettings=new IOSInitializationSettings();
    var initializationSettings=new InitializationSettings(initializeAndroidSettings, initializeIOSSettings);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void showNotification(message) async{
    var androidPlatformChannelSpecifics=new AndroidNotificationDetails(
        Platform.isAndroid?"com.businessinflux.business_influx":"com.businessinflux.business_influx",
        'Business Influx News',
        'Business Influx News Notification',
        playSound: true,
        enableVibration: true,
        //enableLights: true,
        importance: Importance.Max,
        priority: Priority.High
    );

    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics =
    new NotificationDetails(androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, message['notification']['title'].toString(), message['notification']['body'].toString(), platformChannelSpecifics,
        payload: json.encode(message));
  }

  void initializeOneSignal() async{
    OneSignal.shared.init('0581e55f-862c-402a-a5cb-43e66cec5b73');



    bool allowed = await OneSignal.shared.promptUserForPushNotificationPermission();
    if(allowed==false){
      OneSignal.shared.promptUserForPushNotificationPermission();
    }

    OneSignal.shared.setInFocusDisplayType(OSNotificationDisplayType.notification);
  }


}
