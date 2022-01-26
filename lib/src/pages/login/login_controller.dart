import 'package:flutter/material.dart';
import 'package:flutter_delivery_udemy/src/models/response_api.dart';
import 'package:flutter_delivery_udemy/src/models/user.dart';
import 'package:flutter_delivery_udemy/src/provider/users_provider.dart';
import 'package:flutter_delivery_udemy/src/utils/my_snackbar.dart';
import 'package:flutter_delivery_udemy/src/utils/shared_pref.dart';


class LoginController {
   BuildContext context;
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  UsersProvider usersProvider=new UsersProvider();
  SharedPref _sharedPref=new SharedPref();
  Future init(BuildContext context) async {
    this.context = context;
    await usersProvider.init(context);
    User user=User.fromJson(await _sharedPref.read('user')?? {});

    if (user?.sessionToken !=null){
      if(user.roles.length>1){
        print(user.roles.length);
        Navigator.pushNamedAndRemoveUntil(context, 'roles', (route) => false);
      }else{
        Navigator.pushNamedAndRemoveUntil(context, user.roles[0].route, (route) => false);
      }
    }
  }
  void gotoRegisterPage(){
    Navigator.pushNamed(context as BuildContext, 'register');
  }
  void login() async{
    String email=emailController.text.trim();
    String password=passwordController.text.trim();

    ResponseApi responseApi=await usersProvider.login(email, password);
    print('Respuesta: ${responseApi?.toJson()}');
    print(responseApi?.success.toString());
    if(responseApi?.success.toString()=='true'){

      User user=User.fromJson(responseApi?.data);
      _sharedPref.save('user',user.toJson());
      print('Usuairo logueafo: ${user.toJson()}');

      if(user.roles.length>1){
        print(user.roles.length);
        Navigator.pushNamedAndRemoveUntil(context, 'roles', (route) => false);
      }else{
        Navigator.pushNamedAndRemoveUntil(context, user.roles[0].route, (route) => false);
      }
      //Navigator.pushNamedAndRemoveUntil(context, 'client/products/list', (route) => false);
    }else{
      MySnackbar.show(context, responseApi.mesagge.toString());
    }


  }
  // Null Safety
}