import 'package:checkgasusage/constants/size.dart';
import 'package:checkgasusage/screens/auth_page/auth_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:checkgasusage/providers/firebase_auth_provider.dart';
import 'package:checkgasusage/screens/register_info/register_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:checkgasusage/screens/intro_page/intro_page.dart';
import 'package:checkgasusage/providers/shared_preferences_provider.dart';
class LandingPage extends StatefulWidget{
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {

  Future<SharedPreferences> init;

  initialize(BuildContext context) {
    // size
    sizeIsNotZero(Stream<double>.periodic(
        Duration(milliseconds: 100),
            (x) => MediaQuery.of(context).size.width));

    // SharedPreferences
    return SharedPreferences.getInstance();

  }
  @override
  void initState() {
    super.initState();
    init = initialize(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        builder: (context, snapshot) {
           return FutureBuilder(
                future: init,
                builder: (context, snapshot){
                  if(snapshot.connectionState == ConnectionState.done)
                    size = MediaQuery.of(context).size;
                    paddingTop = MediaQuery.of(context).padding.top;
                    paddingBottom = MediaQuery.of(context).padding.bottom;
                    availableHeight = size.height - paddingBottom - paddingBottom;
                  sharedPreferencesServiceProvider.overrideWithValue(
                      SharedPreferencesService(snapshot.data));
                    return Consumer(
                      builder : (context,watch,child){
                        final authStateChanges = watch(authStateChangesProvider);
                        return authStateChanges.when(
                          data: (user){
                            return data(context,user);
                          },
                            loading: () => IntroPage(),
                            error: (error, stackTrace){
                              print(error.toString());
                              print(stackTrace);
                              return Container();
                            });
                      },

                    );// 로그인 화면
                  return AuthPage();//애니메이션 화면

                });
          }
      ),
    );
  }
    Widget data(context, user){
  if(user != null)
    return RegisterPage();
  return AuthPage();
}
}