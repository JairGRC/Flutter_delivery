

import 'dart:convert';
import 'dart:io';
import 'package:flutter_delivery_udemy/src/models/category.dart';
import 'package:path/path.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter_delivery_udemy/src/api/environment.dart';

import 'package:flutter_delivery_udemy/src/models/product.dart';

import 'package:flutter_delivery_udemy/src/models/user.dart';
import 'package:http/http.dart' as http;

class ProductsProvider{
  String _url=Environment.API_DELIVERY;
  String _api='api/products';
  BuildContext context;
  User sessionUser;

  Future init(BuildContext context,User sessionUser){
    this.context=context;
    this.sessionUser=sessionUser;
  }
  Future<List<Product>> getByCategory (String idCategory) async{
    try{
      Uri url=Uri.http(_url, '$_api/findByCategory/$idCategory');

      Map<String,String> headers= {
        'Content-type':'application/json',

      };
      final res= await http.get(url,headers: headers);

      final data=json.decode(res.body); // CATEGORIAS
      Product product = Product.fromJsonList(data);
      return product.toList;

    }catch(e){
      print('Error: $e');
      return null;
    }
  }
  Future <Stream> create(Product product, List<File> images) async{
    try{
      Uri url= Uri.http(_url,'$_api/create');
      final request= http.MultipartRequest('POST',url);

      for(int i=0;i<images.length;i++){
        request.files.add(http.MultipartFile(
            'image',
            http.ByteStream(images[i].openRead().cast()),
            await images[i].length(),
            filename: basename(images[i].path)
        ));
      }

      request.fields['product']=json.encode(product);
      final response = await request.send();  // ENVIAR PETICION
      return response.stream.transform(utf8.decoder);
    }catch(e){
      print('Error: $e');
      return null;
    }
  }

}