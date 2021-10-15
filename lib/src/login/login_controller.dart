import 'package:flutter/material.dart';


class LoginController {
  BuildContext? context;

  Future? init(BuildContext context){
    this.context = context;
  }
  void gotoRegisterPage(){
    Navigator.pushNamed(context as BuildContext, 'register');
  }
  // Null Safety
}