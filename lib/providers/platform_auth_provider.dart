import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk/all.dart' as KAKAO;
import 'package:checkgasusage/services/kakao_auth.dart';

class SignInViewModel with ChangeNotifier {
  SignInViewModel({@required this.auth});
  final FirebaseAuth auth;
  bool isLoading = false;
  dynamic error;

  Future<void> _signIn(String platform, dynamic token) async {
    try {
      isLoading = true;
      notifyListeners();
      switch(platform){
       case "google":
          auth.signInWithCredential(token);
          break;
        case "apple":
          auth.signInWithCredential(token);
          break;
      }
      error = null;
    } catch (e) {
      error = e;
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signInWithGoogle() async{
    try{
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
      if(googleSignInAccount != null){
        final GoogleSignInAuthentication googleAuth = await googleSignInAccount.authentication;
        if(googleAuth.accessToken != null && googleAuth.idToken != null) {
          _signIn("google", GoogleAuthProvider.credential(idToken: googleAuth.idToken, accessToken: googleAuth.accessToken));
        }
      }
    }catch(e){
      print("error : $e");
    }
  }

    // Future<void> signInWithNaver(BuildContext context)async{
    // String naver_url = "http://plan20.naverlogin.com";
    // String _nToken = await Navigator.of(context).push(
    //   MaterialPageRoute(builder: (BuildContext context){
    //     return WebView(
    //       initialUrl: naver_url,
    //       javascriptChannels: Set.from([JavascriptChannel(
    //         name: "clay",
    //         onMessageReceived: (JavascriptMessage result) async{
    //           if(result.message != null) return Navigator.of(context).pop(result.message);
    //           return Navigator.of(context).pop();
    //         }
    //       )]),
    //     );
    //   })
    // );
    //
    // print(_nToken);
    // NaverLogin naverLogin = NaverLogin();
    // await naverLogin.login();
    // await naverLogin.getToken();
    // await NaverLogin().buttonLogoutPressed();
    // HttpsCallable callable = CloudFunctions.instance.getHttpsCallable(functionName: "customAuth");
    // HttpsCallableResult result =  await callable.call(<String,dynamic>{
    //   "userId" : naverLogin.accesToken,
    //   "provider" : 'NAVER'});
    // print(result.data);
    // auth.User user = await signInWithCustomToken(result.data);
    // print(user.uid);
    // }

  Future<void> signInWithKakao() async{
    try {
      KakaoLogin kakaoLogin = KakaoLogin();
      await kakaoLogin.initKakaoInstalled();
      KAKAO.AccessTokenResponse token;
      if (kakaoLogin.kakaoInstalled) {
        token = await kakaoLogin.loginWithTalk();
      } else {
        token = await kakaoLogin.loginWithKakao();
      }
      HttpsCallable callable = FirebaseFunctions.instanceFor(region: 'asia-northeast3').httpsCallable("kakaoCustomAuth");
      HttpsCallableResult result =  await callable.call(<String,dynamic>{
          "userId" : token.accessToken,
          "provider" : 'KAKAO'});
      print("result : ${result.data}");
      await signInWithCustomToken(result.data);
    } catch(e){
      print("문제발생 : $e");
    }

  }

  signInWithCustomToken(token)async{
    return (await auth.signInWithCustomToken(token)).user;
  }
}