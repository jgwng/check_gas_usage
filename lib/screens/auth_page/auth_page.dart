import 'package:checkgasusage/constants/app_theme.dart';
import 'package:checkgasusage/screens/register_info/register_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kakao_flutter_sdk/all.dart';
import 'package:checkgasusage/screens/main_page.dart';

class AuthPage extends StatefulWidget{
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage>{
  bool _isKaKaoTalkInstalled = false;


  @override
  void initState(){
    super.initState();
    _initKaKaoTalkInstalled();
  }

  _initKaKaoTalkInstalled() async {
    final installed = await isKakaoTalkInstalled();
    setState(() {
      _isKaKaoTalkInstalled = installed;
    });
  }





  @override
  Widget build(BuildContext context) {
    List<String> iconList = ["kakao_talk.png","5733.png","123.png","6378.png"];
    List<String> iconNameList = ["카카오톡", "네이버","페이스북","구글"];

    isKakaoTalkInstalled();

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
            SizedBox(height: 32,),
            Text("가스 점검하러\n오신 것을\n환영합니다.",textAlign: TextAlign.center,
              style: AppThemes.textTheme.headline1,),
            SizedBox(height: 50,),
            Container(
              width: 190,
              padding: EdgeInsets.symmetric(vertical: 17.5),
              decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.white,width:1),
                  )),//
              child: Text("아래 계정으로 시작하기",
                  textAlign: TextAlign.center,style: AppThemes.textTheme.headline1.copyWith(fontSize: 12)),
            ),
            Container(
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
          ],
        ),
      ),
    );
  }


  Widget _loginItem(String assetName, String iconName){
    return GestureDetector(
      onTap:() {
        onPressed(iconName);
      },
    child: Container(
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
          Text(iconName,style: AppThemes.textTheme.headline1.copyWith(fontSize: 20),)
        ],
      ),
    ),
    );
  }


  void onPressed(String text){
    switch(text){
      case "카카오톡":
        print("카카오톡");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MainPage()),
        );
        break;
      case "네이버":
        print("네이버");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MainPage()),
        );
        break;
      case "페이스북":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MainPage()),
        );
        break;
      case "구글":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MainPage()),
        );
        break;
    }
  }
}