import 'package:checkgasusage/widgets/custom_title_text_appbar.dart';
import 'package:flutter/material.dart';
import 'package:checkgasusage/constants/app_theme.dart';
import 'package:checkgasusage/widgets/drag_scroll_bar.dart';

class TermsOfUse extends StatefulWidget {
  @override
  _TermsOfUseState createState() => _TermsOfUseState();
}

class _TermsOfUseState extends State<TermsOfUse> with SingleTickerProviderStateMixin{

  final ScrollController agreeController = ScrollController();
  final ScrollController infoController = ScrollController();
  TabController tabController;

  Color pointColor = AppThemes.pointColor;
  TextStyle  indexStyle = AppThemes.textTheme.headline1.copyWith(fontWeight: FontWeight.w400,fontSize: 15,);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(vsync: this, length: 2);
    tabController.addListener(_handleTabSelection);
  }


  void _handleTabSelection() {
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppThemes.mainColor,
        appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: TextTitleAppBar("이용 약관"),),
        body: DefaultTabController(
          length: 2,
          child: Column(
              children: <Widget>[
                Container(constraints: BoxConstraints.expand(height: 50),
                  child: TabBar(
                      controller: tabController,
                      indicatorColor: pointColor,
                      indicatorWeight: 2,
                      labelPadding: EdgeInsets.symmetric(vertical: 10.0),// 2번째 Tab Text길이 조정을 위해 적용
                      tabs:[
                        Tab(
                          child: Container(
                            alignment: Alignment.center,
                            child: Text("이용약관 동의",style: indexStyle.copyWith(
                                color: (tabController.index ==0) ? Colors.red[300] : pointColor)
                            ),),
                          ),
                        Tab(
                          child: Container(
                            alignment: Alignment.center,
                            child: Text("개인정보처리 방침",style:
                            indexStyle.copyWith(color: (tabController.index ==1) ? Colors.red[300] : pointColor)
                              ,),
                          ),
                        ),
                      ]),// TabBar 관련 내용 설정
                ),//TabBar 아래부분 선 스타일 조정
                Expanded(
                    child: Container(
                        child: TabBarView(
                          physics: NeverScrollableScrollPhysics(),
                          controller: tabController,
                          children: [
                            DraggableScrollbar(
                              child: _buildContent(agreeController),
                              heightScrollThumb: 70.0,
                              controller: agreeController,
                            ), //이용약관동의 관련 Text 부분
                            DraggableScrollbar(
                              child: _buildContent(infoController),
                              heightScrollThumb: 70.0,
                              controller: infoController,
                            ),// 개인정보처리 방침 부분
                          ],)// 개인정보처리 방침 부분
                    )
                )
              ]),
        )
    );
  }

  Widget _buildContent(ScrollController controller) {
    return Container(
        margin: EdgeInsets.only(bottom:14.5,left: 24,top:14.5),
        child: ListView(
            controller: controller,
            children: [for (var i = 0; i < 100; ++i) Text('item #$i',style:
            AppThemes.textTheme.headline1.copyWith(fontSize: 12,color: Colors.white)
            )])
      // Listview 안에 Text 내용 작성 (listview안에 적어줘야 scroll과 연결하여 사용 가능하다)
    );
  }
}

