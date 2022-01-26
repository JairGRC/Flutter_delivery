import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_delivery_udemy/src/models/category.dart';
import 'package:flutter_delivery_udemy/src/pages/Ecommerce/Categories/create/ecommerce_categories_create_controller.dart';
import 'package:flutter_delivery_udemy/src/pages/Ecommerce/products/Create/ecommerce_product_create_controller.dart';
import 'package:flutter_delivery_udemy/src/utils/my_colors.dart';
class EcommerceProductsCreatePage extends StatefulWidget {
  const EcommerceProductsCreatePage({Key key}) : super(key: key);

  @override
  _EcommerceProductsCreatePageState createState() => _EcommerceProductsCreatePageState();
}

class _EcommerceProductsCreatePageState extends State<EcommerceProductsCreatePage> {
  EcommerceProductsCreateController _con=new EcommerceProductsCreateController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nueva Producto'),
      ),
      body: ListView(
          children: [
            SizedBox(height: 30),
            _textFieldName(),
            _textdescription(),
            _textFieldPrice(),
            Container(
              height: 100,
              margin: EdgeInsets.symmetric(horizontal: 30,vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _cardImage(_con.imageFile1,1),
                  _cardImage(_con.imageFile2,2),
                  _cardImage(_con.imageFile3,3)
                ],
              ),
            ),
            _dropDownCategories(_con.categories),
          ],
        ),

      bottomNavigationBar: _buttonCreate(),
    );
  }
  Widget _buttonCreate(){
    return  Container(
      height: 50,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
      child: ElevatedButton(
        onPressed: _con.createProduct,
        child: Text('CREAR PRODUCTO'),
        style: ElevatedButton.styleFrom(
            primary: Colors.red,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30)
            ),
            padding: EdgeInsets.symmetric(vertical: 15)
        ),
      ),
    );
  }
  Widget _textFieldName(){
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacituColor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: _con.nameController,
        maxLines: 1,
        maxLength: 180,
        decoration: InputDecoration(
            hintText: 'Nombre de la categoria',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(
                color: MyColors.primaryColorDark
            ),
            suffixIcon: Icon(
              Icons.local_pizza,
              color: Colors.red,
            )
        ),
      ),
    );
  }
  Widget _textdescription(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacituColor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: _con.descriptionController,
        maxLines: 3,
        maxLength: 255,
        decoration: InputDecoration(
            hintText: 'Descripcion de la categoria',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(
                color: MyColors.primaryColorDark
            ),
            suffixIcon: Icon(
              Icons.description,
              color: Colors.red,
            )
        ),
      ),
    );
  }
  Widget _textFieldPrice(){
    return Container(
      //padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacituColor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: _con.priceController,
        keyboardType: TextInputType.phone,
        maxLines: 1,
        decoration: InputDecoration(
            hintText: 'Precio',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(
                color: MyColors.primaryColorDark
            ),
            suffixIcon: Icon(
              Icons.monetization_on,
              color: Colors.red,
            )
        ),
      ),
    );
  }
  Widget _dropDownCategories(List<Category> categories){
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 33),
        child: Material(
          elevation: 2.0,
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5)),
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.search,
                      color:MyColors.primaryColor,
                    ),
                    SizedBox(width: 15),
                    Text(
                      'Categorias',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16
                      )
                    )
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: DropdownButton(
                    underline: Container(
                      alignment: Alignment.centerRight,
                      child: Icon(
                        Icons.arrow_drop_down_circle,
                        color:MyColors.primaryColor
                      ),
                    ),
                    elevation: 3,
                    isExpanded: true,
                    hint: Text(
                      'Seleccionar categoria',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16
                      ),
                    ),
                    items: _dropDownItems(categories),
                    value: _con.idCategory,
                    onChanged: (option){
                      setState(() {
                        print('Categoria selecciona $option');
                        _con.idCategory=option;
                      });
                    },

                  ),
                )
              ],
            ),
          ),
        ),
      );
  }
  List<DropdownMenuItem<String>> _dropDownItems(List<Category>categories){
    List<DropdownMenuItem<String>> list=[];
    categories.forEach((category) {
      list.add(DropdownMenuItem(
        child: Text(category.name),
        value:category.id,
      ));
    });
    return list;
  }
  Widget _cardImage(File imageFile, int numberFile){
    return GestureDetector(
      onTap: (){
        _con.showAlertDialog(numberFile);
      },
      child: imageFile !=null
          ? Card(
        elevation: 3.0,
        child: Container(
          height: 100,
          width: MediaQuery.of(context).size.width*0.26,
          child: Image.file(
            imageFile,
            fit: BoxFit.cover,
          ),
        ),
      ):Card(
        elevation: 3.0,
        child: Container(
          height: 140,
          width: MediaQuery.of(context).size.width*0.26,
          child: Image(
          image: AssetImage('assets/img/add_image.png'),
          ),
        ),
      ),
    );
  }
  void refresh(){
    setState(() {

    });
  }
}