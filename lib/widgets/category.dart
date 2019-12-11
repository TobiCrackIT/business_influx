import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/category_model.dart';

class Category extends StatelessWidget {
  final CategoryModel cat;
  final VoidCallback onTap;

  IconData categoryIcon;

  Category(this.cat, { this.onTap });

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    switch(cat.id){
      case 1: //Uncategorized News
        categoryIcon=Icons.category;
        break;
      case 2: //Business News
        categoryIcon=Icons.shopping_cart;
        break;
      case 3: //Entertainment
        categoryIcon=Icons.theaters;
        break;
      case 7: //Sports News
        categoryIcon=Icons.directions_run;
        break;
      case 11: //Health News
        categoryIcon=Icons.local_hospital;
        break;
      case 16: //Technology
        categoryIcon=Icons.phonelink;
        break;
      case 33: //Breaking
        categoryIcon=Icons.flash_on;
        break;
      case 34: //Education
        categoryIcon=Icons.school;
        break;
      case 35: //Global
        categoryIcon=Icons.public;
        break;
      case 36: //Local
        categoryIcon=Icons.home;
        break;
      case 37: //Opinion
        categoryIcon=Icons.question_answer;
        break;
      case 38: //Opportunities
        categoryIcon=Icons.stars;
        break;
      case 39: //State Government
        categoryIcon=Icons.home;
        break;
      case 40: //Crime Watch
        categoryIcon=Icons.security;
        break;
      case 41: //Executive
        categoryIcon=Icons.color_lens;
        break;
      case 42: //Legislative
        categoryIcon=Icons.perm_camera_mic;
        break;
      default:
        categoryIcon=Icons.add_circle;
        break;
    }

    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.15),
              blurRadius: 5,
              offset: Offset(0, 0),
            )
          ],
        ),
        child: AspectRatio(
          aspectRatio: 1.0,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(3)),
              color: isDark ? Color(0xFF1B1E28) : Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  cat.name,
                  style: TextStyle(
                    color: isDark ? Colors.white : Color(0xFF1B1E28),
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  cat.count.toString() + ' Posts',
                  style: TextStyle(
                    color: Color(0xFF7F7E96),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top:12.0),
                  child: Icon(categoryIcon,color: isDark?Colors.white:Color(0xFF1B1E28),),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
