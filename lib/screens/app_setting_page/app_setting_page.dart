import 'package:checkgasusage/screens/app_setting_page/widgets/faq.dart';
import 'package:checkgasusage/screens/app_setting_page/widgets/one_on_one_question.dart';
import 'package:checkgasusage/screens/app_setting_page/widgets/terms_of_use.dart';
import 'package:checkgasusage/screens/app_setting_page/widgets/user_info_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:checkgasusage/constants/app_theme.dart';
import 'package:checkgasusage/constants/size.dart';


class SettingPage extends StatefulWidget{
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage>{
  List<String> imageAddressList = ["8739.png","6384.png","6383.png", "6387.png","6388.png","6389.png"];
  List<String> itemTitleList = ["개인정보","제품 등록","앱 설정","이용약관","자주하는 질문","1:1 문의"];


  TextStyle textStyle = AppThemes.textTheme.headline1.copyWith(fontSize: 20);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppThemes.mainColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          elevation: 0,
          backgroundColor: AppThemes.mainColor,
          centerTitle: true,
          leading: Container(),
          title: Text("설정",style:AppThemes.textTheme.headline1.copyWith(fontSize: 20)),),),
      body:Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child:Center(
          child: Column(
            children: [
              SizedBox(height: size.height*0.05),
              Flexible(
                child: gradeList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget gradeList(){
    return Container(
        child: ListView.separated(
          itemCount: imageAddressList.length,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: false,
          separatorBuilder: (context, index) =>
              Divider(height: 2.0, color: Colors.white),
          itemBuilder: (BuildContext context, int index) {
            return gradeItem(imageAddressList[index],itemTitleList[index]);
          },
        )
    );
  }

  Widget gradeItem(String imageAddress,String itemText){
    return GestureDetector(
      onTap: (){
        onPressed(itemText);
      },
      child: Container(
        padding: EdgeInsets.only(left: 24),
        height: 80,
        child: Row(
          children: [
            SizedBox(
              width: 50,
              height: 50,
              child: Image.asset("assets/image/setting_page/$imageAddress"),
            ),
            SizedBox(width: 18.4,),
            Text(itemText,style:textStyle)
          ],
        ),
      ),
    );
  }

  void onPressed(String itemText){
    switch (itemText){
      case "개인정보":
        Navigator.push(context,MaterialPageRoute(builder: (context) => UserInformation()));
        break;
      case "이용약관":
        Navigator.push(context,MaterialPageRoute(builder: (context) => TermsOfUse()));
        break;
      case "자주하는 질문":
        Navigator.push(context,MaterialPageRoute(builder: (context) => FAQ()));
        break;
      case "1:1 문의":
        Navigator.push(context,MaterialPageRoute(builder: (context) => OneOnOneQuestion()));
        break;
    }
  }


}