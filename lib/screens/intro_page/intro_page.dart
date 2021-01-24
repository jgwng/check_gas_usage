import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:checkgasusage/constants/app_theme.dart';

class IntroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      backgroundColor: AppThemes.pointColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/logo/gas.png'),
            SizedBox(height: 12.5,),
          ],
        ),
      ),
    );
  }
}
