import 'package:flutter/material.dart';

class ClientAddressListController{
  BuildContext context;
  Function refresh;

  Future init(BuilContext context, Function refresh){
    this.context=context;
    this.refresh=refresh;
  }
}