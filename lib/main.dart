import 'package:flutter/material.dart';
import 'package:flutter_delivery_udemy/src/login/login_page.dart';
import 'package:flutter_delivery_udemy/src/utils/my_colors.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

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
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.red
          )
      ),
      routes: {
        'login' : (BuildContext context)=> LoginPage()
      },

    );
  }
}
