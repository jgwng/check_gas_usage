
import 'package:flutter/material.dart';

class AskQuestion with ChangeNotifier{
  bool privacySelect;
  String question;
  String content;

  void setPrivacy(bool secret){
    privacySelect = secret;
    notifyListeners();
  }

  AskQuestion(this.question,this.content,this.privacySelect);
}
