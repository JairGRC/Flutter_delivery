import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_delivery_udemy/src/models/response_api.dart';
import 'package:flutter_delivery_udemy/src/models/user.dart';
import 'package:flutter_delivery_udemy/src/provider/users_provider.dart';
import 'package:flutter_delivery_udemy/src/utils/my_snackbar.dart';
import 'package:flutter_delivery_udemy/src/utils/shared_pref.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';


class ClientUpdateController{
  BuildContext context;

  TextEditingController nameController=new TextEditingController();
  TextEditingController lastnameController=new TextEditingController();
  TextEditingController phoneController=new TextEditingController();
  PickedFile pickedFile;
  File imageFile;
  Function refresh;

  ProgressDialog _progressDialog;
  bool isEnable=true;
  User user;
  SharedPref _sharedPref=new SharedPref();

  UsersProvider usersProvider=new UsersProvider();
  Future init(BuildContext context, Function refresh)  async {
    this.context=context;
    this.refresh=refresh;
    await usersProvider.init(context);
    _progressDialog = ProgressDialog(context: context);
    user = User.fromJson(await _sharedPref.read('user'));
    nameController.text=user.name;
    lastnameController.text=user.lastname;
    phoneController.text=user.phone;
    refresh();
  }

  void update() async{

    String name=nameController.text.trim();
    String lastname=lastnameController.text.trim();
    String phone=phoneController.text.trim();


    if(name.isEmpty||lastname.isEmpty||phone.isEmpty){
      MySnackbar.show(context, 'Debes ingresar todos los campos');
      return;
    }

    _progressDialog.show(max: 100, msg: 'Espere un momento...');
    isEnable=false;

    User myuser=new User(
      id: user.id,
      name:name,
      lastname: lastname,
      phone: phone,
      image: user.image

    );

    Stream stream = await usersProvider.update(myuser, imageFile);
    stream.listen((res) async{

      _progressDialog.close();
      // ResponseApi responseApi=await usersProvider.create(user);
      ResponseApi responseApi= ResponseApi.fromJson(json.decode(res));
      Fluttertoast.showToast(msg: responseApi.mesagge.toString());
      if(responseApi.success){
        user= await usersProvider.getById(myuser.id); // Otieniendo el usuario de la BD
        _sharedPref.save('user', user.toJson());
        Navigator.pushNamedAndRemoveUntil(context, 'client/products/list', (route) => false);
      }else{
        isEnable=true;
      }

    });


    print('name: $name');
    print('lastname: $lastname');
    print('phone: $phone');

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