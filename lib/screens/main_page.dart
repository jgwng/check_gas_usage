import 'package:checkgasusage/screens/app_setting_page/app_setting_page.dart';
import 'package:checkgasusage/screens/home_page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:checkgasusage/constants/app_theme.dart';
import 'package:checkgasusage/screens/my_usage_page/my_usage_page.dart';


class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  final List<BottomNavigationBarItem> _bNBItems = [
    BottomNavigationBarItem(
      label: "홈",
      icon: ImageIcon(AssetImage('assets/image/bnb_items/home.png')),
      activeIcon: ImageIcon(AssetImage('assets/image/bnb_items/home.png')),
    ),
    BottomNavigationBarItem(
      label: "내사용량",
      icon: ImageIcon(AssetImage('assets/image/bnb_items/my_usage.png')),
      activeIcon: ImageIcon(AssetImage('assets/image/bnb_items/my_usage.png')),
    ),
    BottomNavigationBarItem(
      label: "설정",
      icon: ImageIcon(AssetImage('assets/image/bnb_items/setting.png')),
      activeIcon: ImageIcon(AssetImage('assets/image/bnb_items/setting.png')),
    ),
  ];

  final List<Widget> _pageList = [
    HomePage(),
    MyGasUsage(),
    SettingPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        children: _pageList,
        index: _currentIndex,
      ),

      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          onTap: (newValue) {
            setState(() {
              _currentIndex = newValue;
            });
          },
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          selectedItemColor: AppThemes.mainColor,
          items: _bNBItems),
    );
  }
}