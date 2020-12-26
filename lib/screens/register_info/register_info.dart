import 'package:checkgasusage/constants/app_theme.dart';
import 'package:checkgasusage/constants/size.dart';
import 'package:checkgasusage/screens/main_page.dart';
import 'package:flutter/material.dart';
import 'package:kopo/kopo.dart';

class RegisterInfo extends StatefulWidget {
  @override
  _RegisterInfoState createState() => _RegisterInfoState();
}

class _RegisterInfoState extends State<RegisterInfo> {

  TextEditingController nameController = TextEditingController();
  FocusNode nameFocusNode = FocusNode();

  TextEditingController phoneNumberController = TextEditingController();
  FocusNode phoneNumberFocusNode = FocusNode();

  TextEditingController secondAddressController = TextEditingController();
  FocusNode secondAddressFocusNode = FocusNode();

  TextStyle textStyle = AppThemes.textTheme.headline1.copyWith(
      fontSize: 15, color: Colors.white70);

  final _infoFormKey = GlobalKey<FormState>();
  String postNumber = '우편번호';
  String firstAddress = '검색을 통해 주소를 입력하세요';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppThemes.mainColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.arrow_back_ios, color: Colors.white,),
        ),
      ),
      body:GestureDetector(
          onTap: (){
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Form(
              key: _infoFormKey,
              child:Column(
                children: <Widget>[
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: Image.asset(
                      "assets/image/register_info/gas_pipe.png", fit: BoxFit.fill,),
                  ),
                  SizedBox(height: 10),
                  Text("정보 입력", textAlign: TextAlign.center,
                    style: AppThemes.textTheme.headline1.copyWith(fontSize: 25),),
                  SizedBox(height: 20),
                  infoField(nameController,nameFocusNode,"이름",validateName),
                  infoField(phoneNumberController,phoneNumberFocusNode,"핸드폰 번호((-) 없이)",validatePhoneNumber),
                  SizedBox(height: 10,),
                  //주소 입력
                  Container(
                      child: Row(
                        children: [
                          Text(postNumber,style : textStyle),
                          SizedBox(width: 10,),
                          RaisedButton(
                            onPressed: () async {
                              KopoModel model = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Kopo(),
                                  ));
                              if (model != null) {
                                setState(() {
                                  postNumber = model.zonecode;
                                  firstAddress = model.address;
//                            addressJSON =
//                            '${model.address} ${model.buildingName}${model
//                                .apartment == 'Y' ? '아파트' : ''} ${model
//                                .zonecode} ';
                                });
                              }
                            },
                            child: Text("주소 검색"),
                          )
                        ],
                      )
                  ),
                  SizedBox(height: 10,),
                  Container(
                    width: size.width,
                    height: 60,
                    alignment : Alignment.centerLeft,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    color: Colors.brown[800],
                    child: Text(firstAddress,style: textStyle,textAlign: TextAlign.left,),
                  ),
                  SizedBox(height: 10,),
                  infoField(secondAddressController,secondAddressFocusNode,"남은 주소를 입력해주세요",validateSecondAddress),
                  SizedBox(height: 30,),
                  SizedBox(
                    width: 200,
                    height: 40,
                    child: RaisedButton(
                      color: Colors.grey[800],
                      onPressed: onPressed,
                      child: Text("정보 입력",style: textStyle,),
                    ),
                  )
                ],
              ),
            ),
        )
      ),
    );
  }


  Widget infoField(TextEditingController textEditingController,
      FocusNode focusNode,String hintText,Function(String number) function){
    return Column(
      children: [
        Container(
            height: 60,
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.brown[800],
            ),

            //이름
            child: TextFormField(
                controller: textEditingController,
                focusNode: focusNode,
                validator: function,
                style: textStyle,
                decoration: InputDecoration(

                  hintText: hintText,
                  hintStyle: textStyle,
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromRGBO(238, 238, 238, 1.0))),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromRGBO(238, 238, 238, 1.0))),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromRGBO(238, 238, 238, 1.0))),
                )
            )
        ),
        SizedBox(height: 10,),
      ],
    );
  }

  String validateName(String value){
    if(value != ""){
      return null;
    }else{
      return '이름을 입력해주세요';
    }
  }

  String validatePhoneNumber(String value){
    if(value.length != 11){
      return '전화번호를 확인해주세요';
    }
    return null;
  }

  String validateSecondAddress(String value){
    if(value != ""){
      return null;
    }else{
      return '주소를 입력해주세요';
    }
  }


  void onPressed(){
    if(_infoFormKey.currentState.validate()){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MainPage()),
      );
    }
  }




}