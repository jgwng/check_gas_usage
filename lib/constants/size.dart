import 'package:flutter/material.dart';

Size size;
double _baseHeight = 812;
double _baseWidth = 375;
double availableHeight;
double paddingTop;
double paddingBottom;

double widgetHeight(double v){
  return v / _baseHeight * availableHeight;
}

double widgetWidth(double v){
  return v / _baseWidth * size.width;
}
Future<double> sizeIsNotZero(Stream<double> source) async {
  await for (double value in source) {
    if (value > 0) return value;
  }
}
