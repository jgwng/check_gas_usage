import 'package:kakao_flutter_sdk/auth.dart';

class KakaoLogin{
  bool _installed = false;
  bool get kakaoInstalled => _installed ;
  initKakaoInstalled() async{
    _installed = await isKakaoTalkInstalled();
    print(_installed);
  }

  Future<AccessTokenResponse> issueAccessToken(String authCode) async{
    AccessTokenResponse token = await AuthApi.instance.issueAccessToken(authCode);
    AccessTokenStore.instance.toStore(token);
    return token;
  }

  // ignore: missing_return
  Future<AccessTokenResponse> loginWithKakao() async{
    try{
      var code = await AuthCodeClient.instance.request();
      print(code);
      return await issueAccessToken(code);
    }catch(e){
      print(e);
    }

  }

  // ignore: missing_return
  Future<AccessTokenResponse> loginWithTalk() async {
    try{
      var code = await AuthCodeClient.instance.requestWithTalk();
      print(code);
      return await issueAccessToken(code);
    }catch(e){
      print(e);
    }
  }
}