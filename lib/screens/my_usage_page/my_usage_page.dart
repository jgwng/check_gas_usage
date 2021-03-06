import 'dart:math';
import 'package:checkgasusage/screens/my_usage_page/my_usage_graph.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:checkgasusage/constants/app_theme.dart';
class MyGasUsage extends StatefulWidget{
  @override
  _MyGasUsageState createState() => _MyGasUsageState();
}

class _MyGasUsageState extends State<MyGasUsage>{
  var list = [];
  int index;
  List<int> realChartItem = [75,77,76,78,79,80,72,74,71,70,65,73];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    index =0;
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppThemes.mainColor,
      child: Column(
        children: [
          SizedBox(height: 37.5,),
          CheckGasUsageGraph(chartContent: realChartItem,),
        ],
      ),
    );
  }

}