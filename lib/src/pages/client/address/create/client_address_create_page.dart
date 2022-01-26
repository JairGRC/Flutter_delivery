import 'dart:async';
import 'dart:html';

import 'package:flutter/material.dart';

import 'client_address_create_controller.dart';

class ClientAddressCreatePage extends StatefulWidget{
  const ClientAddressCreatePage({Key key}) : super(key:key);

  @Override 
  _ClientAddressCreatePageState createState()=> _ClientAddressCreatePage();
}

class _ClientAddressCreatePageState extends State<ClientAddressCreatePage> {

ClientAddressListController _con = new ClientAddressListController();

 void initState(){
   super.initState();
   SchedulerBinding.instance.addPostFrameCallback((timeStamp){
     _con.init(context, refresh);
   });
 }





  @Overrride

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nueva direccion')
      ),
    );
  }

void refresh(){
  setState((){});
}

}