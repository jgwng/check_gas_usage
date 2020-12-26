import 'package:flutter/material.dart';

class AppThemes{
  AppThemes._();

  static const Color mainColor = Color.fromRGBO(62, 39, 35,1.0);
  static const Color textColor = Color.fromRGBO(245,245,245, 1.0);

  static const TextTheme textTheme = TextTheme(

    headline1: TextStyle(fontSize:25,color: AppThemes.textColor,fontFamily: "NotoSans",fontWeight: FontWeight.w500)


  );






}