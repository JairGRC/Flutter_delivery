import 'package:flutter/material.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  @override
  //CORRE CODIGO QUE SE MUESTRA EN PANTALLA
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Flutter delivery App'),
        ),

        body: Stack(
          children: [
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                  color: Colors.red
              ),
            ),
            Container(
                margin: EdgeInsets.only(top: 60, left: 50),
                child: Text('LOGIN')
            )
          ],
        )
    );
  }
}
