import 'package:flutter/material.dart';
import '../widgets/deco_appbar.dart';
import '../widgets/deco_news_drawer.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: DecoNewsAppBar(),
      drawer: DecoNewsDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60.0, bottom: 30.0),
              child: Image.asset('images/deco_logo.png'),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: Text(
                'Deco News',
                style: TextStyle(
                  color: isDark ? Colors.white : Color(0xFF1B1E28),
                  fontSize: 20.0,
                ),
              ),
            ),
            Container(
              width: 220.0,
              padding: EdgeInsets.only(
                bottom: 60.0,
              ),
              child: Text(
                'WordPress to Flutter News App',
                style: TextStyle(
                  color: Color(0xFF7F7E96),
                  fontSize: 14.0,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              margin: EdgeInsets.all(10.0),
              padding: EdgeInsets.symmetric(
                vertical: 15.0,
                horizontal: 10.0,
              ),
              decoration: BoxDecoration(
                color: isDark ? Color(0xFF1B1E28) : Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.15),
                    blurRadius: 5,
                    offset: Offset(0, 0),
                  )
                ],
                borderRadius: BorderRadius.all(Radius.circular(3)),
              ),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          'Amazing list of features',
                          style: TextStyle(
                            color: isDark ? Colors.white : Color(0xFF1B1E28),
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.check_box,
                          color: Color(0xFFCCCBDA),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Expanded(
                          child: Text(
                            'No need for development skills',
                            style: TextStyle(
                              color: isDark ? Colors.white : Color(0xFF1B1E28),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.check_box,
                          color: Color(0xFFCCCBDA),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Expanded(
                          child: Text(
                            'Wordpress as Backend',
                            style: TextStyle(
                              color: isDark ? Colors.white : Color(0xFF1B1E28),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.check_box,
                          color: Color(0xFFCCCBDA),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Expanded(
                          child: Text(
                            'Amazing Documentation & Support',
                            style: TextStyle(
                              color: isDark ? Colors.white : Color(0xFF1B1E28),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.check_box,
                          color: Color(0xFFCCCBDA),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Expanded(
                          child: Text(
                            'Firebased Push Notifications',
                            style: TextStyle(
                              color: isDark ? Colors.white : Color(0xFF1B1E28),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.check_box,
                          color: Color(0xFFCCCBDA),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Expanded(
                          child: Text(
                            'AdMob Integration',
                            style: TextStyle(
                              color: isDark ? Colors.white : Color(0xFF1B1E28),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.check_box,
                          color: Color(0xFFCCCBDA),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Expanded(
                          child: Text(
                            'Light & Dark theme',
                            style: TextStyle(
                              color: isDark ? Colors.white : Color(0xFF1B1E28),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.check_box,
                          color: Color(0xFFCCCBDA),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Expanded(
                          child: Text(
                            'Design files (Sketch, Adobe Xd & Photoshop)',
                            style: TextStyle(
                              color: isDark ? Colors.white : Color(0xFF1B1E28),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.check_box,
                          color: Color(0xFFCCCBDA),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Expanded(
                          child: Text(
                            'Flutter 1.7',
                            style: TextStyle(
                              color: isDark ? Colors.white : Color(0xFF1B1E28),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.check_box,
                          color: Color(0xFFCCCBDA),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Expanded(
                          child: Text(
                            'Compatible with Android & iOS',
                            style: TextStyle(
                              color: isDark ? Colors.white : Color(0xFF1B1E28),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          width: double.infinity,
          height: 55.0,
          margin: EdgeInsets.fromLTRB(10.0, 0, 10.0, 10.0),
          child: RaisedButton(
            onPressed: () {},
            padding: EdgeInsets.all(0),
            color: isDark ? Colors.white : Color(0xFF1B1E28),
            textColor: isDark ? Color(0xFF1B1E28) : Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(3.0)),
            child: Text('Purchase Now'),
          ),
        ),
      ),
    );
  }
}
