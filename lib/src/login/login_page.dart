import 'package:flutter/material.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // String _name; //Variable privada - Sin raya al piso Variable publica

  @override
  //CORRE CODIGO QUE SE MUESTRA EN PANTALLA
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _imageBanner(),
              _textFieldEmail(),
              _textFieldPassword(),
              _buttonLogin(),
              _textDontHaveAccount()
            ],
          ),
        )
    );
  }

  Widget _textDontHaveAccount(){
    return Row(
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
      ]
    );
  }
  Widget _buttonLogin(){
    return  ElevatedButton(
        onPressed: (){},
        child: Text('INGRESAR')
    );
  }
  Widget _textFieldPassword(){
    return TextField(
      decoration: InputDecoration(
          hintText: 'Contraseña'
      )
    );
  }
  Widget _textFieldEmail(){
    return TextField(
      decoration: InputDecoration(
          hintText: 'Correo electronico'
      ),
    );
  }
  Widget _imageBanner (){
    return  Image.asset(
      'assets/img/delivery.png',
      width: 200,
      height: 200
    );
  }
}
