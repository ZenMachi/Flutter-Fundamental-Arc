import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:submission_restaurant_app/ui/restaurant_list_page.dart';
import 'package:submission_restaurant_app/ui/restaurant_search_page.dart';
import 'package:submission_restaurant_app/ui/settings_page.dart';

class RestaurantHomePage extends StatefulWidget {
  static const routeName = '/';

  const RestaurantHomePage({super.key});

  @override
  State<RestaurantHomePage> createState() => _RestaurantHomePageState();
}

class _RestaurantHomePageState extends State<RestaurantHomePage> {
  int _bottomNavIndex = 0;

  @override
  void initState() {
    FlutterNativeSplash.remove();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _listWidget[_bottomNavIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomNavIndex,
        items: _bottomNavBarItems,
        onTap: (selected) {
          setState(() {
            _bottomNavIndex = selected;
          });
        },
      ),
    );
  }

  final List<BottomNavigationBarItem> _bottomNavBarItems = [
    const BottomNavigationBarItem(
        icon: Icon(Icons.home), label: 'Home'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.search), label: 'Search'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.settings), label: 'Settings'),
  ];

  final List<Widget>_listWidget = [
    const RestaurantListPage(),
    const RestaurantSearchPage(),
    const SettingsPage()
  ];
}
