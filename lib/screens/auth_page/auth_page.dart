import 'package:checkgasusage/constants/app_theme.dart';
import 'package:checkgasusage/screens/register_info/register_info.dart';
import 'file:///C:/Users/gwjun/AndroidStudioProjects/check_gas_usage/lib/screens/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AuthPage extends StatelessWidget{
  final TextStyle textStyle =TextStyle(
      fontSize:25,color: AppThemes.textColor,fontFamily: "NotoSans",fontWeight: FontWeight.w500
  );
  @override
  Widget build(BuildContext context) {
    List<String> iconList = ["kakao_talk.png","5733.png","123.png","6378.png"];
    List<String> iconNameList = ["카카오톡", "네이버","페이스북","구글"];



    return Scaffold(
      backgroundColor: AppThemes.mainColor,
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 100,),
            SizedBox(
              height: 100,
              width: 100,
              child: Image.asset("assets/logo/gas.png",fit: BoxFit.fill,),
            ),
            SizedBox(height: 32.1,),
            Text("가스 점검하러\n오신 것을\n환영합니다.",textAlign: TextAlign.center,
              style: textStyle,),
            SizedBox(height: 50,),
            Container(
              width: 190,
              padding: EdgeInsets.symmetric(vertical: 17.5),
              decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.white,width:1),
                  )),//
              child: Text("아래 계정으로 시작하기",
                  textAlign: TextAlign.center,style: textStyle.copyWith(fontSize: 12)),
            ),
            GestureDetector(
              onTap:(){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RootPage()),
                );
              },
              child: Container(
                height: 200,
                width: 190,
                child: ListView.builder(
                    itemCount: 4,
                    padding: EdgeInsets.only(top: 0),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return _loginItem(iconList[index],iconNameList[index]);
                    }),
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget _loginItem(String assetName, String iconName){
    return Container(
      height: 50,
      padding: EdgeInsets.symmetric(horizontal: 35.5),
      decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.white,width:1),
          )),
      child:Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 20,
            height: 20,
            child: Image.asset("assets/image/auth_page/$assetName"),
          ),
          SizedBox(width:11.3,),
          Text(iconName,style: textStyle.copyWith(fontSize: 20),)
        ],
      ),
    );
  }
}