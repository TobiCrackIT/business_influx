import 'package:flutter/material.dart';

class DecoNewsAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool centerTitle;
  final double elevation;
  final PreferredSizeWidget bottom;

  DecoNewsAppBar({
    Key key,
    this.title = 'BUSINESS INFLUX',
    this.centerTitle = true,
    this.elevation = 2.0,
    this.bottom
  })
    : preferredSize = Size.fromHeight(kToolbarHeight + (bottom?.preferredSize?.height ?? 0.0)),
      super(key: key);

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: centerTitle,
      elevation: elevation,
      iconTheme: IconThemeData(color: Color(0xFFAAB2B7)),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w600,
        ),
      ),
      bottom: bottom,
    );
  }
}