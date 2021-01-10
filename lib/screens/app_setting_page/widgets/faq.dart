import 'package:checkgasusage/widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:checkgasusage/constants/app_theme.dart';
import 'package:checkgasusage/constants/size.dart';


class FAQ extends StatefulWidget {
  @override
  _FAQstate createState() => _FAQstate();
}

class _FAQstate extends State<FAQ> {
  static final List<String> questionList = ["트로피는 어떻게 올릴 수 있나요?","트로피 반영은 언제 이루어지나요?",
    "기기를 구매하고 싶어요","로그인이 안돼요","회원탈퇴는 어디서 하나요?"];

  TextEditingController faqSearchController = TextEditingController();
  static String questionAnswer = "사용하시는 채의 종류, 스피드와 성실도에 따라 각각\n다른 종류의 트로피가 부여됩니다.\n자세한 설명은\n\n 등급정보 페이지에서 확인 가능합니다.\n\n 메인 - 하단의 '트로피'탭을 눌러보세요.";
  static final List<FaqListItem> faqList = List.generate(questionList.length,(e)=> FaqListItem(questionList[e],questionAnswer,false));


  List<FaqListItem> _question = List<FaqListItem>();
  List<FaqListItem> _questionForDisplay = List<FaqListItem>();

  FocusNode faqFocusNode = FocusNode();
  bool isFocused = false;


  @override
  void initState() {
    super.initState();
    faqSearchController.addListener(_onFocusChange);
    setState(() {
      _question = faqList;
      _questionForDisplay = faqList;
    });
  }

  void _onFocusChange() async{
    setState(() {
      isFocused =!isFocused;
    });
  }

  void onTap(){
    setState((){
      faqSearchController.clear();
      _question = faqList;
      _questionForDisplay = faqList;
    });
  }
  void onChange(String text){
    setState(() {
      _questionForDisplay = _question.where((questions) {
        return questions.question.contains(text);
      }).toList();
    });
  }

  @override
  void dispose() {
    faqSearchController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppThemes.mainColor,

        body:GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: (){
            FocusScopeNode currentFocus = FocusScope.of(context);
            if(!currentFocus.hasPrimaryFocus){
              currentFocus.unfocus();
            }
          },
          child:SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(height: (0.08)*size.height,),
                SearchBar(onChange: onChange, height: size.height,controller: faqSearchController,onTap: onTap,),
                SizedBox(height:(0.03)*size.height),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: _questionForDisplay.length,
                  itemBuilder: (context, index) {
                    return _faqItem(_questionForDisplay[index]);
                  },),
                SizedBox(height: 0.03*size.height,),
              ],
            ),
          ),
        )
    );
  }

  Widget _faqItem(FaqListItem faq){
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
            children: <Widget>[
              Container(
                  height: 0.08*size.height,
                  decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Color.fromRGBO(238, 238, 238, 1),width:1),
                      )),
                  child: ListTile(
                    title: Text(faq.question,style: AppThemes.textTheme.subtitle1.copyWith(
                        color:Colors.white
                    )),
                    trailing: IconButton(icon: faq.isSelected ? Icon(Icons.keyboard_arrow_up) : Icon(Icons.keyboard_arrow_down),
                      color: AppThemes.pointColor,
                      onPressed: (){
                        setState(() {
                          faq.isSelected = !faq.isSelected;
                        });
                      },),
                  )),
              Visibility(visible: faq.isSelected ? true : false,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(142, 142, 147, 0.24),
                    borderRadius: BorderRadius.all(
                      Radius.circular(5.0),
                    ),
                  ),
                  child: Container(
                      padding: EdgeInsets.only(left: 15,top: 15,right:9,bottom: 16),
                      child: Text(faq.answer,style: AppThemes.textTheme.bodyText1.copyWith(
                          color:Color.fromRGBO(42, 42, 42, 1.0)
                      ),
                      )),
                ),),
            ]
        )
    );
  }
}

class FaqListItem {
  String question;
  String answer;
  bool isSelected;

  FaqListItem(this.question,this.answer,this.isSelected);
}