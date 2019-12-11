import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/deco_appbar.dart';
import '../widgets/deco_news_drawer.dart';
import '../main.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;

  @override
  void initState() {
    super.initState();

    _areNotificationsEnabled();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DecoNewsAppBar(),
      drawer: DecoNewsDrawer(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[

            /*Container(
              margin: EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.black.withOpacity(0.13)
                  )
                )
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[

                  Text('Enable push notifications'),

                  Switch(
                    onChanged: (bool enabled) {
                      setState(() {
                        _notificationsEnabled = enabled;
                        _updateNotifications(enabled);
                      });
                    },
                    value: _notificationsEnabled,
                  ),
                ],
              ),
            ),*/

            Container(
              width: double.infinity,
              child: OutlineButton(
                onPressed: () {
                  DecoNews.of(context).setBrightness(Brightness.light);
                },

                child: Text('Light Mode', style: TextStyle(color: Colors.blue),),
                borderSide: BorderSide(
                  color: Colors.blue
                ),
              ),
            ),

            Container(
              width: double.infinity,
              child: OutlineButton(
                onPressed: () {
                  DecoNews.of(context).setBrightness(Brightness.dark);
                },

                child: Text('Dark Mode', style: TextStyle(color: Colors.blue),),
                borderSide: BorderSide(
                  color: Colors.blue
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Checks are notifications enabled
  Future<void> _areNotificationsEnabled() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      _notificationsEnabled = (prefs.getBool('isPushNotificationEnabled') ?? true);
    });
  }

  /// Enables or disables notifications
  Future<void> _updateNotifications(bool enabled) async {
    //DecoNews.of(context).setSubscription(enabled);
  }
}