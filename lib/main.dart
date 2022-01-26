import 'package:flutter/material.dart';
import 'package:flutter_delivery_udemy/src/pages/Delivery/orders/list/delivery_orders_list_page.dart';
import 'package:flutter_delivery_udemy/src/pages/Ecommerce/Categories/create/ecommerce_categories_create_page.dart';
import 'package:flutter_delivery_udemy/src/pages/Ecommerce/orders/list/ecommerce_orders_list_page.dart';
import 'package:flutter_delivery_udemy/src/pages/Ecommerce/products/Create/ecommerce_product_create_page.dart';
import 'package:flutter_delivery_udemy/src/pages/client/products/list/client_products_list_page.dart';
import 'package:flutter_delivery_udemy/src/pages/client/update/client_update_page.dart';
import 'package:flutter_delivery_udemy/src/pages/login/login_page.dart';
import 'package:flutter_delivery_udemy/src/pages/register/register_page.dart';
import 'package:flutter_delivery_udemy/src/pages/roles/roles_pages.dart';

import 'package:flutter_delivery_udemy/src/utils/my_colors.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Delivery App Flutter',
      debugShowCheckedModeBanner: false,
      //Ruta
      initialRoute: 'login',
      theme: ThemeData(
          //fontFamily: 'NimbusSans',
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.red
          )
      ),
      routes: {
        'login' : (BuildContext context)=> LoginPage(),
        'register' : (BuildContext context)=> RegisterPage(),
        'client/products/list':(BuildContext context)=> ClienteProductListPage(),
        'client/update':(BuildContext context)=> ClientUpdatePage(),
        'ecommerce/orders/list':(BuildContext context)=> EcommerceOrderListPage(),
        'delivery/orders/list':(BuildContext context)=> DeliveryOrdersListPage(),
        'delivery/categories/create':(BuildContext context)=> EcommerceCategorieCreatePage(),
        'delivery/products/create':(BuildContext context)=> EcommerceProductsCreatePage(),
        'roles':(BuildContext context)=> RolesPage(),
      },

    );
  }
}
