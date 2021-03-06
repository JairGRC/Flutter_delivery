import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_delivery_udemy/src/models/response_api.dart';
import 'package:flutter_delivery_udemy/src/models/user.dart';
import 'package:flutter_delivery_udemy/src/provider/users_provider.dart';
import 'package:flutter_delivery_udemy/src/utils/my_snackbar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';


class RegisterController{
  BuildContext context;
  TextEditingController emailController=new TextEditingController();
  TextEditingController nameController=new TextEditingController();
  TextEditingController lastnameController=new TextEditingController();
  TextEditingController phoneController=new TextEditingController();
  TextEditingController passwordController=new TextEditingController();
  TextEditingController confirPasswordController=new TextEditingController();
  PickedFile pickedFile;
  File imageFile;
  Function refresh;

  ProgressDialog _progressDialog;
  bool isEnable=true;


  UsersProvider usersProvider=new UsersProvider();
  Future init(BuildContext context, Function refresh)  async {
    this.context=context;
    this.refresh=refresh;
    await usersProvider.init(context);
    _progressDialog = ProgressDialog(context: context);
    //refresh();
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

    if(imageFile == null){
      MySnackbar.show(context, 'Selecciona una imagen');
      return;
    }
    _progressDialog.show(max: 100, msg: 'Espere un momento...');
    isEnable=false;

    User user=new User(
      email: email,
      name:name,
      lastname: lastname,
      phone: phone,
      password: password,

    );

    Stream stream = await usersProvider.createWithImage(user, imageFile);
    stream.listen((res) {

      _progressDialog.close();
     // ResponseApi responseApi=await usersProvider.create(user);
      ResponseApi responseApi= ResponseApi.fromJson(json.decode(res));
      print('Respuesta1: ${responseApi.toJson()}');
      MySnackbar.show(context, responseApi.mesagge.toString());
      if(responseApi.success){
        Future.delayed(Duration(seconds: 3),(){
          Navigator.pushReplacementNamed(context, 'login');
        });
      }else{
        isEnable=true;
      }

    });

    print('Email: $email');
    print('Passoword: $password');
    print('name: $name');
    print('lastname: $lastname');
    print('phone: $phone');
    print('confirPassword: $confirPassword');
  }
  void back(){
    Navigator.pop(context);
  }
  Future selectImage(ImageSource imagesource) async{
    pickedFile = await ImagePicker().getImage(source: imagesource);
    if(pickedFile!= null){
      imageFile= File(pickedFile.path);
    }
    Navigator.pop(context);
    refresh();
  }
  void showAlertDialog(){
    Widget galleryButton=ElevatedButton(
        onPressed: (){
          selectImage(ImageSource.gallery);
        },
        child: Text('GALERIA')
    );
    Widget camaraButton=ElevatedButton(
        onPressed: (){
          selectImage(ImageSource.camera);
        },
        child: Text('CAMARA')
    );
    AlertDialog alertDialog = AlertDialog(
      title: Text('Selecciona tu imagen'),
      actions: [
        galleryButton,
        camaraButton
      ],
    );
    showDialog(
        context: context,
        builder: (BuildContext context){
          return alertDialog;
        }
    );
  }

}