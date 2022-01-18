import 'package:flutter/material.dart';
import 'package:flutter_delivery_udemy/src/models/response_api.dart';
import 'package:flutter_delivery_udemy/src/provider/users_provider.dart';
import 'package:flutter_delivery_udemy/src/utils/my_snackbar.dart';


class LoginController {
  late BuildContext context;
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  UsersProvider usersProvider=new UsersProvider();
  Future? init(BuildContext context) async {
    this.context = context;
    await usersProvider.init(context);
  }
  void gotoRegisterPage(){
    Navigator.pushNamed(context as BuildContext, 'register');
  }
  void login() async{
    String email=emailController.text.trim();
    String password=passwordController.text.trim();

    ResponseApi? responseApi=await usersProvider.login(email, password);
    MySnackbar.show(context, responseApi!.mesagge.toString());
    print('Respuesta: ${responseApi.toJson()}');
  }
  // Null Safety
}