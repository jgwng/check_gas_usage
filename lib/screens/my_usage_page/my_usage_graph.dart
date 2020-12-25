import 'dart:math';
import 'dart:ui';
import 'package:checkgasusage/constants/app_theme.dart';
import 'package:checkgasusage/constants/size.dart';
import 'package:flutter/material.dart';
import 'package:rect_getter/rect_getter.dart';

class CheckGasUsageGraph extends StatefulWidget {
  CheckGasUsageGraph({this.chartContent});
  final List<int> chartContent;



  @override
  _CheckGasUsageGraphState createState() => new _CheckGasUsageGraphState();
}

class _CheckGasUsageGraphState extends State<CheckGasUsageGraph> with AutomaticKeepAliveClientMixin {
  var _keys = {};
  ScrollController scrollController = ScrollController();
  int secondItemIndex;
  double itemWidth = 60.0;
  double targetLine = 120;
  static List<int> frontChartItem = [0,0];
  static List<int> behindChartItem =[0,0,0];
  List<int> chartItem;

  List<bool> starVisibility;
  int largestChartValue;
  int smallestChartValue;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    scrollController = ScrollController(initialScrollOffset: (widget.chartContent.length+1)*itemWidth);
    secondItemIndex = widget.chartContent.length+1;

    starVisibility= List.generate(widget.chartContent.length+5,(i)=> false);
    print(starVisibility);

  }

  getVisible(listViewKey) {
    var rect = RectGetter.getRectFromKey(listViewKey);
    var _items = <int>[];
    _keys.forEach((index, key) {
      var itemRect = RectGetter.getRectFromKey(key);
      if (itemRect != null &&
          !(itemRect.left > rect.right || itemRect.right < rect.left))
        _items.add(index);
    });

    Future.delayed(Duration(milliseconds: 300), () {
      if ((scrollController.offset - itemWidth) < 0) {
        scrollController.jumpTo(0.1);
        secondItemIndex = 2;
      }

      else if(scrollController.offset >= scrollController.position.maxScrollExtent-0.1){

        scrollController.jumpTo(scrollController.position.maxScrollExtent-0.1);
        secondItemIndex = widget.chartContent.length+1;
      }
      else if ((scrollController.offset - itemWidth) % itemWidth >= 0.5) {
        scrollController.jumpTo(_items[0] * itemWidth);
        secondItemIndex = _items[2];
      }

      else if ((scrollController.offset - itemWidth) % itemWidth == 0) {
      }

      else {
        scrollController.jumpTo(_items[1] * itemWidth);
        secondItemIndex = _items[2];
      }

    });
    setState(() {});
  }

  /// so all visible item's index are in this _items.
  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    List<int> realChartItem = widget.chartContent;
    List<int> chartItem = [...frontChartItem,...realChartItem,...behindChartItem];
    print(chartItem);
    largestChartValue = realChartItem.reduce(max);
    smallestChartValue = realChartItem.reduce(min);



    /// Make the entire ListView have the ability to get rect.

    var listViewKey = RectGetter.createGlobalKey();
    var listView = RectGetter(
      key: listViewKey,
      child: Container(

        width: itemWidth * 6,
        height: 300,
        child: ListView.builder(
          key: PageStorageKey<String>('WeightChart'),
          itemCount: chartItem.length,
          addAutomaticKeepAlives: true,
          physics: BouncingScrollPhysics(),
          controller: scrollController,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            /// Make every item have the ability to get rect,
            /// and save keys for RectGetter and its index into _keys.
            _keys[index] = RectGetter.createGlobalKey();
            return RectGetter(
                key: _keys[index],
                child: graphContent(index,chartItem[index]));
          },
        ),
      ),
    );
    return Container(
        width: size.width,

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: AppThemes.mainColor,
        ),
        padding: EdgeInsets.only(left: 30),
        child: Column(
          children: [
            NotificationListener<ScrollEndNotification>(
              onNotification: (notification) {
                /// print all visible item's index when scroll updated.
                getVisible(listViewKey);
                return true;
              },
              child: listView,
            ),
            SizedBox(height: 37.5,),
            chartInfo("사용량", (chartItem[secondItemIndex]~/3).toString()),
            SizedBox(height: 17.5,),
            chartInfo("전월 대비",(chartItem[secondItemIndex]*2).toString()+"원")
          ],
        )
    );
  }

  Widget graphContent(int index,int content){
    if((index<2) | (index>widget.chartContent.length+1)){
      return Container(
        width: itemWidth,
        color: Colors.transparent,
      );
    }
    else{
      return GestureDetector(
        onTap: (){
          setState(() {
            starVisibility[index] = !starVisibility[index];
          });
        },
        child:graphItem(index,content),
      );
    }
  }


  Widget graphItem(int index, int chartItem){
    return Container(
        width: itemWidth,
        color: AppThemes.mainColor,
        child:
        Column(
          children: [
            SizedBox(
              height: 20,
              child:  Visibility(
                visible: starVisibility[index] ? true : false,
                child: Image.asset("assets/icon/8712.png"),
              ),
            ),
            SizedBox(
              width: itemWidth,
              /// random height
              height: 215,
              child: Center(
                child: WeightProgress(
                    firstVisibleItem: secondItemIndex,
                    currentIndex: index,
                    chartCurrentValue: chartItem,
                    chartMaxValue: largestChartValue,
                    chartMinValue: smallestChartValue
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Container(
              height: 25,
              child: Text(
                (index-1).toString() + ("월") ,
                style: TextStyle(
                    color: (index == secondItemIndex) ?  AppThemes.mainColor : Colors.white,
                    fontSize: 14,
                    fontFamily: "NotoSans",
                    fontWeight: FontWeight.w400),
              ),
            )
          ],
        ));
  }
  Widget chartInfo(String title,String content){
    return Container(
      padding: EdgeInsets.only(left: 30,right: 55),
      child: Container(
        padding:EdgeInsets.only(bottom: 5),
        decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Color.fromRGBO(238, 238, 238, 1),width:1),
            )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title,style: TextStyle( color: Colors.white,fontSize: 20,fontFamily: "Notosans",fontWeight: FontWeight.w500),),
            Text(content,style: TextStyle( color: AppThemes.mainColor,fontSize: 20,fontFamily: "Notosans",fontWeight: FontWeight.w700))
          ],
        ),
      ),
    );
  }



  @override
  bool get wantKeepAlive => true;
}



class WeightProgress extends StatelessWidget {
  const WeightProgress({this.firstVisibleItem, this.currentIndex,this.chartMaxValue,this.chartCurrentValue,this.chartMinValue});
  final int firstVisibleItem;
  final int currentIndex;
  final int chartMaxValue;
  final int chartMinValue;
  final int chartCurrentValue;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return weightProgressBar(context, firstVisibleItem, currentIndex,
        chartCurrentValue,chartMaxValue,chartMinValue);
  }

  Widget weightProgressBar(BuildContext context, int firstItem, int itemIndex,int chartCurrentValue,
      int chartMaxValue,int chartMinValue) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      child: CustomPaint(
        size: Size(0.35 * width, 10),
        child: Center(),
        foregroundPainter:
        (chartCurrentValue==0)? null : WeightPainter(coloredItem: firstItem, currentItemIndex: itemIndex,
            currentValue: chartCurrentValue,chartMaxValue: chartMaxValue,chartMinValue: chartMinValue),
      ),
    );
  }
}

class WeightPainter extends CustomPainter {
  int coloredItem;
  int currentItemIndex;
  int currentValue;
  int chartMaxValue;
  int chartMinValue;
  WeightPainter({
    this.coloredItem,
    this.currentItemIndex,
    this.currentValue,
    this.chartMaxValue,
    this.chartMinValue
  });

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();

    if (coloredItem == (currentItemIndex)) {
      paint.color = AppThemes.mainColor;
    } else {
      paint.color = Color.fromRGBO(141, 146, 145, 0.5);
    }


    double percentage = ((currentValue-chartMinValue)/(chartMaxValue-chartMinValue));

    paint.strokeWidth = 8;
    paint.strokeCap = StrokeCap.round;
    canvas.drawLine(
      Offset(size.width / 2, 117-percentage*107),
      Offset(size.width / 2, 205),//max value
      paint,
    );
  }
  // 완료선의 마지막 점 표시

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}