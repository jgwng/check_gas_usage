import 'package:checkgasusage/constants/app_theme.dart';
import 'package:checkgasusage/constants/size.dart';
import 'package:checkgasusage/screens/app_setting_page/model/question_model.dart';
import 'package:checkgasusage/widgets/custom_checkbox.dart';
import 'package:flutter/material.dart';


class OneOnOneQuestion extends StatefulWidget {
  @override
  _OneOnOneQuestionState createState() => _OneOnOneQuestionState();
}

class _OneOnOneQuestionState extends State<OneOnOneQuestion> {
  FocusNode questionFocusNode = FocusNode();
  FocusNode mailFocusNode = FocusNode();
  FocusNode contentFocusNode = FocusNode();
  bool isFocused = false;
  AskQuestion question;
  double _inputHeight = 170;
  final questionController = TextEditingController(); // 질문 제목 textfield 컨트롤러
  final mailController = TextEditingController(); // 질문 제목 textfield 컨트롤러
  final contentController = TextEditingController(); //  질문 내용 textfield 컨트롤러

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    question = AskQuestion("", "", false);
    contentController.addListener(_checkInputHeight);
    contentController.addListener(_onFocusChange);// 엔터 여부 확인 위해 설정
  }
  @override
  void dispose() {
    questionController.dispose();
    mailController.dispose();
    contentController.dispose();
    super.dispose();
  }


  void _onFocusChange() async{
    setState(() {
      isFocused =!isFocused;

    });
  }

  void _checkInputHeight() async {
    int count = contentController.text.split('\n').length; // 사용자의 엔터 입력 확인
    if (count == 0 && _inputHeight == 170.0) {
      return;
    }
    if (count <= 5) {  // use a maximum height of 6 rows
      // height values can be adapted based on the font size
      var newHeight = count == 0 ? 170.0 : 28.0 + (count * 28.0);
      setState(() {
        _inputHeight = newHeight;
      });
    }// 사용자의 엔터 입력에 따른 질문 내용의 textfield 크기 증가 & 감소
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppThemes.mainColor,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Image.asset('assets/icon/back.png'),
          ),
          title: Text("1:1 문의",),
          centerTitle: true,
        ),
        body: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: (){
            FocusScopeNode currentFocus = FocusScope.of(context);
            if(!currentFocus.hasPrimaryFocus){
              currentFocus.unfocus();
            }
          },
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: <Widget>[
                  SizedBox(height: (0.01)*size.height,),
                  contentTitle("제목",questionController,questionFocusNode),
                  contentTitle("메일",mailController,mailFocusNode),//Text "제목" & 일대일 질문 제목
                  Container(
                      padding: EdgeInsets.only(top: 22.5,bottom: 25.5),
                      decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Color.fromRGBO(238, 238, 238, 1),width:1),
                          )),// 박스 아래 보조선
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Color.fromRGBO(204,204,204,1.0),width: 1),
                          borderRadius: BorderRadius.circular(10.0),
                        ),//내용부분 UI
                        child:TextField(
                          focusNode: contentFocusNode,
                          style: TextStyle(fontSize: 16,height: 1.5,
                              fontFamily: "NotoSans",
                              fontWeight: FontWeight.w300,color: Colors.black),
                          keyboardType: TextInputType.multiline,
                          textInputAction: TextInputAction.newline,
                          minLines: 7,//
                          maxLines: 10,//최대 줄수 설정을 통한 줄바꿈 횟수 제한
                          controller: contentController,
                          decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              contentPadding: EdgeInsets.only(left: 15,top: 10,right:15,bottom:10)
                          ),
                        ),
                      )
                  ), // 일대일 질문 내용
                  SizedBox(height: 0.01*size.height,),
                  Container(
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: 24,height: 24,

                          child: CustomCheckBox(
                            radius: Radius.circular(3),
                            borderColor: Colors.white,
                            value: question.privacySelect,
                            checkColor:Colors.black,
                            activeColor: AppThemes.mainColor,
                            onChanged: (value){
                              setState(() {
                                question.setPrivacy(value);
                              });
                            }, //체크시 개인정보 수집 및 이용 동의
                          ),
                        ),
                        SizedBox(width: 0.03*size.width,),
                        Text("개인정보 수집 및 이용 동의",style:
                        TextStyle(
                          color:Colors.white,
                          fontSize: 14,
                          fontFamily: "NotoSans",
                          fontWeight: FontWeight.w400,
                        )),
                      ],),
                  ),//개인정보 수집 및 이용동의 체크 부분
                  SizedBox(height: (0.25)*size.height,),
                  Container(
                    width: size.width,
                      height: 72,
                    decoration: BoxDecoration(
                        border: Border.all(color: Color.fromRGBO(204,204,204,1.0),width: 1),
                        borderRadius: BorderRadius.circular(5.0),
                        color: Color.fromRGBO(174, 174, 174, 1.0)
                    ),
                    padding: EdgeInsets.only(left:11,top: 14,bottom: 14),
                    child: Text("답변은 가입하실 때 사용하신 이메일 주소로 휴일 제외\n영업일 5일 이내에 답변 발송예정입니다.",
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: "NotoSans",
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(42,42,42,1.0),
                        )
                    )),
                  SizedBox(height: (0.03)*size.height,),
                  Container(
                    width: 157,
                    height: 48,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.0),
                        color: Colors.grey
                    ),
                    child: RaisedButton(

                      onPressed:((questionController.text != "") && (contentController.text != "") && (question.privacySelect)) ? () {} : null,
                      color: ((questionController.text != "") && (contentController.text != "") && (question.privacySelect)) ? AppThemes.mainColor : Color.fromRGBO(238, 238, 238, 1.0),
                      child: Text("보내기",style: AppThemes.textTheme.button),
                    ),
                  ) // 작성한 질문 회사로 보내는 버튼
                ],
              ),
            ),
          ),
        )

    );
  }

  Widget contentTitle(String frontText,TextEditingController controller,FocusNode focusNode){
    return Container(
      child: Row(
        children: <Widget>[
          Text(frontText,style: AppThemes.textTheme.subtitle1.copyWith(
              color: Colors.white
          ),),
          SizedBox(width: 0.06*size.width,),
          Flexible(
              child: TextField(
                  focusNode: focusNode,
                  controller: controller,
                  style: AppThemes.textTheme.bodyText1,
                  decoration: InputDecoration(
                      hintStyle: AppThemes.textTheme.subtitle1.copyWith(
                          color: Colors.white
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      hintText: (frontText == "제목") ? "트로피 반영 관련 문의" : ""
                  )
              )
          )
        ],
      ),
    );
  }





}
