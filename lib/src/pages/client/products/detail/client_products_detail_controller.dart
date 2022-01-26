import 'package:flutter/material.dart';
import 'package:flutter_delivery_udemy/src/models/product.dart';
import 'package:flutter_delivery_udemy/src/utils/shared_pref.dart';
import 'package:fluttertoast/fluttertoast.dart';
class ClientProductsDetailController{
  BuildContext context;
  Function refresh;

  Product product;
  int counter=1;
  double productPrice;
  SharedPref _sharedPref=new SharedPref();
  List<Product> selectedProduct=[];

  Future init(BuildContext context,Function refresh,Product product) async {
    this.context=context;
    this.refresh=refresh;
    this.product=product;
    productPrice=product.price;
   // _sharedPref.remove('order');
    selectedProduct=Product.fromJsonList(await _sharedPref.read('order')).toList;
    selectedProduct.forEach((p) {
      print('Producto seleccionado: ${p.toJson()}');
    });
    refresh();
  }
  void addItem(){
    counter=counter+1;
    productPrice=product.price*counter;
    product.quantity=counter;
    refresh();
  }
  void removeItem(){
    if(counter>1){
      counter=counter-1;
      productPrice=product.price*counter;
      product.quantity=counter;
      refresh();
    }
  }
  void addToBag(){
    int index=selectedProduct.indexWhere((p) => p.id==product.id);
    if(index==-1){
      //PRODUCTOS SELECCIONADOS NO EXISTE ESE PRODUCTO
      if(product.quantity==null){
        product.quantity=1;
      }
      selectedProduct.add(product);
    }else{
      selectedProduct[index].quantity=counter;
    }


    _sharedPref.save('order', selectedProduct);
    Fluttertoast.showToast(msg: 'Producto agregado');
  }
  void close(){
    Navigator.pop(context);
  }
}