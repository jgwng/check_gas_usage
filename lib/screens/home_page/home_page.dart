import 'package:checkgasusage/constants/app_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:checkgasusage/screens/ml_vision/practice_vision.dart';
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

        child:Column(
          mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height:46),
              Container(
                padding : EdgeInsets.only(left: 30),
                alignment: Alignment.centerLeft,
                child: Text("건웅님,\n환영합니다.",
                    style: AppThemes.textTheme.headline1),
              ),
              SizedBox(height:80),
              GestureDetector(
                  onTap: () =>
//
                      Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyHomePage()),
                  ),
                child:  CircleAvatar(
                  radius: 120, // 바깥원 반지름
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 118, // 안쪽원 반지름
                    child: Center(child: Text("가스 검침하기",style:AppThemes.textTheme.headline1),),
                    backgroundColor: AppThemes.mainColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
  }


}