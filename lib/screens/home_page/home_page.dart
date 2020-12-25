import 'package:checkgasusage/constants/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
class HomePage extends StatefulWidget{
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{

  TextStyle gradeStyle = TextStyle(fontSize: 25,fontFamily: "NotoSans",color: Colors.black,
      fontWeight: FontWeight.w500);

  String formattedDate = DateFormat('yyyy년 MM월 dd일').format(
      DateTime.now().subtract(Duration(days: 0)));

  bool delay = false;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
      }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppThemes.mainColor,
      appBar: AppBar(
        backgroundColor: AppThemes.mainColor,
        elevation: 0,
        title: Image.asset("assets/logo/gas.png"),
        centerTitle: true,
        leading: Container(),
      ),
      body: Container(

        child:Center(
          child: Column(
            children: [
              SizedBox(height:46),
              InkWell(
                child: Stack(
                  overflow: Overflow.visible,
                  children: [
                    Container(
                      child: Image.asset("assets/image/home_page/6213.png"),
                    ),
                    Positioned(
                        right: -16,
                        bottom: -10,
                        child: Container(
                            child: Image.asset("assets/image/home_page/6415.png")
                        )

                    )
                  ],
                ),
              ),
              SizedBox(height:17.2),
            ],
          ),
        ),
      ),
    );
  }


}