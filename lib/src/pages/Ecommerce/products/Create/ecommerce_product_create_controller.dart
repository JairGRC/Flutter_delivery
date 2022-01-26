import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_delivery_udemy/src/models/category.dart';
import 'package:flutter_delivery_udemy/src/models/product.dart';
import 'package:flutter_delivery_udemy/src/models/response_api.dart';
import 'package:flutter_delivery_udemy/src/models/user.dart';
import 'package:flutter_delivery_udemy/src/provider/categories_provider.dart';
import 'package:flutter_delivery_udemy/src/utils/my_snackbar.dart';
import 'package:flutter_delivery_udemy/src/utils/shared_pref.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:image_picker/image_picker.dart';

class EcommerceProductsCreateController{
  BuildContext context;
  Function refresh;
  TextEditingController nameController=new TextEditingController();
  TextEditingController descriptionController=new TextEditingController();
  MoneyMaskedTextController priceController=new MoneyMaskedTextController();
  CategoriesProvider _categoriesProvider=new CategoriesProvider();
  User user;
  List<Category> categories=[];
  String idCategory; // ALMACENAR EL ID DE LA CATEGORIA ALMACENADA

  //IMAGENES
  PickedFile pickedFile;
  File imageFile1;
  File imageFile2;
  File imageFile3;

  SharedPref sharedPref=new SharedPref();
  Future init(BuildContext context,Function refresh) async{
    this.context=context;
    this.refresh=refresh;
    user=User.fromJson(await sharedPref.read('user'));
    _categoriesProvider.init(context, user);
    getCategories();
  }
  void getCategories() async{
      categories=await _categoriesProvider.getAll();
      refresh();
  }
  void createProduct() async{
    String name=nameController.text;
    String description= descriptionController.text;
    double price=priceController.numberValue;
    if(name.isEmpty || description.isEmpty || price ==0){
      MySnackbar.show(context, 'Debe ingresar todos los campos');
      return;
    }
    if(imageFile1 ==null||imageFile2==null||imageFile3==null){
      MySnackbar.show(context, 'Selecciona las tres imagenes');
      return;
    }
    if(idCategory==null){
      MySnackbar.show(context, 'Selecciona categoria del producto');
      return;
    }
    Product product=new Product(
      name:name,
      description: description,

    );
  }

  Future selectImage(ImageSource imagesource,int numberFile) async{
    pickedFile = await ImagePicker().getImage(source: imagesource);
    if(pickedFile!= null){
      if(numberFile==1){
        imageFile1= File(pickedFile.path);
      }else if(numberFile==2){
        imageFile2= File(pickedFile.path);
      }else if(numberFile==3){
        imageFile3= File(pickedFile.path);
      }

    }
    Navigator.pop(context);
    refresh();
  }
  void showAlertDialog(int numberFile){
    Widget galleryButton=ElevatedButton(
        onPressed: (){
          selectImage(ImageSource.gallery,numberFile);
        },
        child: Text('GALERIA')
    );
    Widget camaraButton=ElevatedButton(
        onPressed: (){
          selectImage(ImageSource.camera,numberFile);
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