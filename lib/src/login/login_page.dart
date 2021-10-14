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
        body: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                  'assets/img/delivery.png',
                width: 200,
                height: 200,
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Correo electronico'
                ),
              ),
              TextField(
                decoration: InputDecoration(
                    hintText: 'Contraseña'
                ),
              ),
              ElevatedButton(
                  onPressed: (){},
                  child: Text('INGRESAR')
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                      '¿No tienes cuentas?',
              style: TextStyle(
                  color: Colors.red
              ),
                  ),
                  SizedBox(width: 7),
                  Text(
                      'Registrate',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red
                    ),
                  ),
                ],
              )
            ],
          ),
        )
    );
  }
}
