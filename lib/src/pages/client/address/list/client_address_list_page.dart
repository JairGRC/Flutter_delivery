import 'dart:async';
import 'dart:html';

import 'package:flutter/material.dart';

import 'client_address_list_controller.dart';

class ClientAddressListPage extends StatefulWidget{
  const ClientAddressListPage({Key key}) : super(key:key);

  @Override 
  _ClientAddressListPageState createState()=> _ClientAddressListPageState();
}

class _ClientAddressListPageState extends State<ClientAddressListPage> {

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
        title: Text('Direcciones')
      ),
    );
  }

void refresh(){
  setState((){});
}

}