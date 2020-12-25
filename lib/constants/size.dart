import 'package:flutter/material.dart';

Size size;

Future<double> sizeIsNotZero(Stream<double> source) async {
  await for (double value in source) {
    if (value > 0) return value;
  }
}
