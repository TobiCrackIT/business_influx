import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../screens/home_screen.dart';
import '../screens/categories_screen.dart';
import '../screens/bookmarks_screen.dart';
import '../screens/about_screen.dart';
import '../screens/settings_screen.dart';
import '../deco_news_icons.dart';
import '../main.dart';


class DrawerItem {
  final String title;
  final Function page;
  final IconData icon;

  DrawerItem(this.title, this.icon, this.page);
}

class DecoNewsDrawer extends StatelessWidget {
  /// This is the list of items that will be shown in drawer
  static final List<DrawerItem> drawerItems = [
    DrawerItem('Home', DecoNewsIcons.home_icon, () => HomeScreen()),
    DrawerItem(
        'Categories', DecoNewsIcons.categories_icon, () => CategoriesScreen()),
    DrawerItem(
        'Bookmarks', DecoNewsIcons.add_to_bookmark, () => BookmarksScreen()),
    //DrawerItem('About app', DecoNewsIcons.about_icon, () => AboutScreen()),
    DrawerItem('Settings', Icons.settings, () => SettingsScreen()),
  ];

  @override
  Widget build(BuildContext context) {
    int selectedIndex = DecoNews.of(context).getSelected();

    return Theme(
      data: Theme.of(context).copyWith(canvasColor: Color(0xFF1B1E28)),
      child: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            /// Header
            Container(
              padding: EdgeInsets.only(top: 120.0,),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                //width: 80.0,
                child: Image.asset('images/bi_logo.png',fit: BoxFit.cover,height: 120,),
              ),
            ),

            /// Drawer items
            Expanded(
              child: Center(
                child: ListView(
                  shrinkWrap: true,
                  children: drawerItems.map((DrawerItem item) {
                    int index = drawerItems.indexOf(item);

                    return Container(
                      height: 50.0,
                      margin: EdgeInsets.only(right: 50.0),
                      decoration: BoxDecoration(
                        color: index == selectedIndex
                            ? Color(0xFF282C39)
                            : Color(0x00282C39),
                        borderRadius:
                            BorderRadius.horizontal(right: Radius.circular(25)),
                      ),
                      child: ListTile(
                        leading: Icon(
                          item.icon,
                          size: 20.0,
                          color: index == selectedIndex
                              ? Colors.white
                              : Color(0xFF7F7E96),
                        ),
                        title: Text(
                          item.title,
                          style: TextStyle(
                            color: index == selectedIndex
                                ? Colors.white
                                : Color(0xFF7F7E96),
                            fontSize: 16.0,
                          ),
                        ),
                        onTap: () {
                          Navigator.pop(context);

                          DecoNews.of(context).setSelected(index);

                          Navigator.pushReplacement(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (context, anim1, anim2) =>
                                    item.page(),
                                transitionsBuilder:
                                    (context, anim1, anim2, child) =>
                                        FadeTransition(
                                            opacity: anim1, child: child),
                                transitionDuration: Duration(milliseconds: 200),
                              ));
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),

            /*Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: drawerItems.map((DrawerItem item) {
                int index = drawerItems.indexOf(item);

                return Container(
                  height: 50.0,
                  margin: EdgeInsets.only(right: 50.0),
                  decoration: BoxDecoration(
                    color: index == selectedIndex
                        ? Color(0xFF282C39)
                        : Color(0x00282C39),
                    borderRadius:
                    BorderRadius.horizontal(right: Radius.circular(25)),
                  ),
                  child: ListTile(
                    leading: Icon(
                      item.icon,
                      size: 20.0,
                      color: index == selectedIndex
                          ? Colors.white
                          : Color(0xFF7F7E96),
                    ),
                    title: Text(
                      item.title,
                      style: TextStyle(
                        color: index == selectedIndex
                            ? Colors.white
                            : Color(0xFF7F7E96),
                        fontSize: 16.0,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);

                      DecoNews.of(context).setSelected(index);

                      Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, anim1, anim2) =>
                                item.page(),
                            transitionsBuilder:
                                (context, anim1, anim2, child) =>
                                FadeTransition(
                                    opacity: anim1, child: child),
                            transitionDuration: Duration(milliseconds: 200),
                          ));
                    },
                  ),
                );
              }).toList(),
            ),*/

            /// Footer
            Container(
              padding: EdgeInsets.only(bottom: 20.0),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 20.0, 0.0, 0.0),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(50),
                      onTap: () {
                        _launchURL('https://www.instagram.com/insideoyo/');
                      },
                      child: Icon(
                        DecoNewsIcons.instagram,
                        color: Color(0xFF7F7E96),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 20.0, 0.0, 0.0),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(50),
                      onTap: () {
                        _launchURL('https://www.facebook.com/insideoyo/');

                      },
                      child: Icon(
                        DecoNewsIcons.facebook,
                        color: Color(0xFF7F7E96),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 20.0, 0.0, 0.0),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(50),
                      onTap: () {
                        _launchURL('https://twitter.com/insideoyo');
                      },
                      child: Icon(
                        DecoNewsIcons.twitter,
                        color: Color(0xFF7F7E96),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 20.0, 0.0, 0.0),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(50),
                      onTap: () {
                        _launchURL('https://www.youtube.com/insideoyo');
                      },
                      child: Icon(
                        DecoNewsIcons.youtube,
                        color: Color(0xFF7F7E96),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
