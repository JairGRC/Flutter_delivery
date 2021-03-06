import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_delivery_udemy/src/pages/Ecommerce/Categories/create/ecommerce_categories_create_controller.dart';
import 'package:flutter_delivery_udemy/src/utils/my_colors.dart';
class EcommerceCategorieCreatePage extends StatefulWidget {
  const EcommerceCategorieCreatePage({Key key}) : super(key: key);

  @override
  _EcommerceCategorieCreatePageState createState() => _EcommerceCategorieCreatePageState();
}

class _EcommerceCategorieCreatePageState extends State<EcommerceCategorieCreatePage> {
  EcommerceCategoriesCreateController _con=new EcommerceCategoriesCreateController();
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
        title: Text('Nueva categoria'),
      ),
      body: Column(
        children: [
          SizedBox(height: 30),
          _textFieldName(),
          _textdescription()
        ],
      ),
      bottomNavigationBar: _buttonCreate(),
    );
  }
  Widget _buttonCreate(){
    return  Container(
      height: 50,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 30),
      child: ElevatedButton(
        onPressed: _con.createCategory,
        child: Text('CREAR CATEGORIA'),
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
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacituColor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: _con.nameController,

        decoration: InputDecoration(
            hintText: 'Nombre de la categoria',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(
                color: MyColors.primaryColorDark
            ),
            suffixIcon: Icon(
              Icons.list_alt,
              color: Colors.red,
            )
        ),
      ),
    );
  }
  Widget _textdescription(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
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
  void refresh(){
    setState(() {

    });
  }
}
