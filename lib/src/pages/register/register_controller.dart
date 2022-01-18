import 'package:flutter/material.dart';
import 'package:flutter_delivery_udemy/src/models/response_api.dart';
import 'package:flutter_delivery_udemy/src/models/user.dart';
import 'package:flutter_delivery_udemy/src/provider/users_provider.dart';
import 'package:flutter_delivery_udemy/src/utils/my_snackbar.dart';

class RegisterController{
  late BuildContext context;
  TextEditingController emailController=new TextEditingController();
  TextEditingController nameController=new TextEditingController();
  TextEditingController lastnameController=new TextEditingController();
  TextEditingController phoneController=new TextEditingController();
  TextEditingController passwordController=new TextEditingController();
  TextEditingController confirPasswordController=new TextEditingController();

  UsersProvider usersProvider=new UsersProvider();
  Future init(BuildContext context)  async {
    this.context=context;
    await usersProvider.init(context);
  }

  void Register() async{
    String email=emailController.text.trim();
    String password=passwordController.text.trim();
    String name=nameController.text.trim();
    String lastname=lastnameController.text.trim();
    String phone=phoneController.text.trim();
    String confirPassword=confirPasswordController.text.trim();

    if(email.isEmpty ||password.isEmpty||name.isEmpty||lastname.isEmpty||phone.isEmpty||confirPassword.isEmpty){
      MySnackbar.show(context, 'Debes ingresar todos los campos');
      return;
    }
    if(confirPassword!=password){
      MySnackbar.show(context, 'Las contraseñas no coinciden');
      return;
    }
    if(password.length<6){
      MySnackbar.show(context, 'Las contraseña debe tener al menos 6 caracteres');
      return;
    }


    User user=new User(
      email: email,
      name:name,
      lastname: lastname,
      phone: phone,
      password: password
    );

    ResponseApi? responseApi=await usersProvider.create(user);

    MySnackbar.show(context, responseApi!.mesagge.toString());
    print('Respuesta: ${responseApi.toJson()}');
    print('Email: $email');
    print('Passoword: $password');
    print('name: $name');
    print('lastname: $lastname');
    print('phone: $phone');
    print('confirPassword: $confirPassword');
  }
}