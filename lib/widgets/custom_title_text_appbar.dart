import 'package:checkgasusage/constants/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextTitleAppBar extends StatelessWidget{
  TextTitleAppBar(this.titleText);
  final String titleText;

  @override
  Widget build(BuildContext context) {
   return AppBar(
      elevation: 0,
      backgroundColor: AppThemes.mainColor,
      leading: IconButton(
       onPressed: (){
         Navigator.of(context).pop();
       },
       icon: Image.asset('assets/icon/back.png',color: AppThemes.pointColor,),
     ),
     centerTitle: true,
     title: Text(titleText,style:AppThemes.textTheme.headline1.copyWith(fontSize: 15),),
   );
  }
}