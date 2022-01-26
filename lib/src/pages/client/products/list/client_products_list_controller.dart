
import 'package:flutter/material.dart';
import 'package:flutter_delivery_udemy/src/models/category.dart';
import 'package:flutter_delivery_udemy/src/models/product.dart';
import 'package:flutter_delivery_udemy/src/models/user.dart';
import 'package:flutter_delivery_udemy/src/pages/client/products/detail/client_products_detail_page.dart';
import 'package:flutter_delivery_udemy/src/provider/categories_provider.dart';
import 'package:flutter_delivery_udemy/src/provider/products_provider.dart';
import 'package:flutter_delivery_udemy/src/utils/shared_pref.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
class ClientProductsController {
  BuildContext context;
  SharedPref _sharedPref=new SharedPref();
  GlobalKey<ScaffoldState> key=new GlobalKey<ScaffoldState>();
  Function refresh;
  User user;
  ProductsProvider _productsProvider=new ProductsProvider();
  List<Category> categories=[];
  CategoriesProvider _categoriesProvider=new CategoriesProvider();
  Future init(BuildContext context,Function refresh) async {
    this.context=context;
    this.refresh=refresh;
    user= User.fromJson(await _sharedPref.read('user'));
    _categoriesProvider.init(context, user);
    _productsProvider.init(context, user);
    getCategories();
    refresh();
  }

  Future<List<Product>> getProducts(String idCategory)async{
    return await _productsProvider.getByCategory(idCategory);
  }
  void openBottomSheet(Product product){
    showMaterialModalBottomSheet(
      context:context,
      builder:(context)=> ClientProductsDetailPage(product: product)
    );
  }
  void getCategories()async{
    categories=await _categoriesProvider.getAll();
    refresh();
  }
  void logout(){
    _sharedPref.logout(context);
  }
  void openDrawer(){
    key.currentState.openDrawer();
  }
  void goToRoles(){
    Navigator.pushNamedAndRemoveUntil(context, 'roles', (route) => false);
  }
  void goToUpdatePage(){
    Navigator.pushNamed(context, 'client/update');
  }
  void goToOrderCreatePage(){
    Navigator.pushNamed(context, 'client/orders/create');
  }
}