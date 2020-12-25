import 'package:checkgasusage/constants/size.dart';
import 'package:checkgasusage/screens/auth_page/auth_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LandingPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: sizeIsNotZero(Stream<double>.periodic(
            Duration(milliseconds: 100),
                (x) => MediaQuery.of(context).size.width)),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            size = MediaQuery.of(context).size;
            return FutureBuilder(
                future: Future.delayed(Duration(seconds: 3),),
                builder: (context, snapshot){
                  if(snapshot.connectionState == ConnectionState.done)
                    return AuthPage(); // 로그인 화면


                  return AuthPage();//애니메이션 화면

                });
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}