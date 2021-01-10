import 'package:checkgasusage/constants/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget{
  final controller;
  final double height;
  final onChange;
  final  VoidCallback onTap;
  final VoidCallback suffixIconOnTab;
  final FocusNode focusNode;
  SearchBar({Key key, this.height,this.onChange,this.controller,this.focusNode,this.onTap, this.suffixIconOnTab}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Container(
          height: 36,
          // padding: EdgeInsets.all(24),
          child : TextField(
            onTap: onTap,
            textAlignVertical: TextAlignVertical.bottom,
            style: AppThemes.textTheme.subtitle1,
            textInputAction: TextInputAction.done,
            focusNode: focusNode,
            decoration: InputDecoration(
              hintStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                fontFamily: "NotoSans",
                color: Color.fromRGBO(102, 102, 102, 1.0)
              ),

                hintText: '검색하세요.',
                prefixIcon: Image.asset('assets/icon/search_glyph.png',),
                suffixIcon: GestureDetector(
                    onTap: suffixIconOnTab,
                    child: Image.asset('assets/icon/x.png',)
                ),
                filled: true,
                fillColor: Color.fromRGBO(174, 174, 174, 1.0),
                border: OutlineInputBorder(
                    borderSide:BorderSide.none,
                    borderRadius: BorderRadius.circular(10.0)
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide:BorderSide.none,
                    borderRadius: BorderRadius.circular(10.0))
            ),
            controller: controller,
            onChanged: onChange,
          )
      ),
    );
  }
}