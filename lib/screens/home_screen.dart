import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../helpers/wordpress.dart';
import '../widgets/deco_appbar.dart';
import '../models/category_model.dart';
import '../widgets/loading.dart';
import '../widgets/deco_news_drawer.dart';
import 'single_category_slider_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = true;
  List<CategoryModel> categories = [];

  @override
  void initState() {
    super.initState();

    /// load list of categories
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    /// show loading message
    if (isLoading) {
      return Scaffold(appBar: DecoNewsAppBar(), body: Loading());
    }

    /// show tabs
    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
        drawer: DecoNewsDrawer(),
        appBar: DecoNewsAppBar(
          bottom: TabBar(
            isScrollable: true,
            labelPadding: EdgeInsets.symmetric(horizontal: 20),
            labelColor: isDark ? Colors.white : Color(0xFF1B1E28),
            indicatorColor: isDark ? Colors.white : Color(0xFF1B1E28),
            tabs: categories.map((category) => Tab(text: category.name)).toList(),
          ),
        ),
        body: TabBarView(
          children: categories.map((category) => SingleCategorySliderScreen(category)).toList()
        ),
      ),
    );
  }

  /// load list of categories
  _loadData() async {
    Response response = await WordPress.fetchCategories();

    if (response.statusCode == 200) {
      if (mounted) {
        setState(() {

          /// set list of categories
          categories = (json.decode(response.body) as List)
            .map((data) => new CategoryModel.fromJson(data))
            .toList();

          categories.sort((a,b)=>b.count.compareTo(a.count));
          for(var item in categories){
            print("ID: "+item.id.toString()+" NAME: "+item.name+" COUNT "+item.count.toString());
          }
          /// disable loading
          isLoading = false;
        });
      }
    } else {
      throw Exception('Failed to load data');
    }
  }

}
