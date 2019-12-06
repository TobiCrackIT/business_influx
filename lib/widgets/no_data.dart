import 'package:flutter/material.dart';

class NoData extends StatelessWidget {
  final String message;

  NoData(this.message);

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 30.0,left: 10,right: 10),
            child: Image.asset('images/bi_logo.png'),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: Text(
              'Oops, no data!',
              //'We\'re sorry, but you have not bookmarked any post(s).',
              style: TextStyle(
                color: isDark ? Colors.white : Color(0xFF1B1E28),
                fontSize: 18.0,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            width: 220.0,
            child: Text(
              message,
              style: TextStyle(
                color: Color(0xFF7F7E96),
                fontSize: 14.0,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}