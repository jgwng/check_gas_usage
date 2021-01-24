import 'dart:io';

import 'package:checkgasusage/constants/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:checkgasusage/providers/user_state_provider.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:checkgasusage/screens/ml_vision/practice_vision.dart';
import 'package:checkgasusage/models/user.dart';
import 'package:checkgasusage/services/bottom_sheet.dart';
class HomePage extends StatefulWidget{
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{

  User user;





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
      body:Consumer(builder : (context,watch,child){
        return buildBody(context,watch(userStateProvider));
      }),
      );
  }

  Widget buildBody(BuildContext context,UserState userState){

    return Container(

      child:Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height:46),
          Container(
            padding : EdgeInsets.only(left: 30),
            alignment: Alignment.centerLeft,
            child: Text("${userState.currentUser.name}님,\n환영합니다.",
                style: AppThemes.textTheme.headline1),
          ),
          SizedBox(height:80),
          GestureDetector(
            onTap: () async{
             File _image = await onImagePickerBottomSheet(context, "이번달 가스 검침하기");
             if(_image != null){
               print("AAAA");
               Navigator.push(
                 context,
                 MaterialPageRoute(builder: (context) => MyHomePage(file: _image)),
               );
             }
            },
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
    );
  }


}