import 'package:flutter/material.dart';
import 'package:muroappmod/animation/FadeAnimation.dart';
import 'package:muroappmod/models/registro_model.dart';
import 'package:muroappmod/provider/usuario_provider.dart';
import 'package:muroappmod/utils/utils.dart';
import 'login.dart';


class SignupPage extends StatelessWidget {

  RegistroModel registro = RegistroModel();
  final formKey = GlobalKey<FormState>();
  UsuarioProvider usuarioProvider = UsuarioProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, size: 20, color: Colors.black,),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40),
          height: MediaQuery.of(context).size.height - 50,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  FadeAnimation(1, Text("Registrarse", style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold
                  ),)),
                  SizedBox(height: 20,),
                  FadeAnimation(1.2, Text("Crea una cuenta, es gratis", style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey[700]
                  ),)),
                ],
              ),
              Column(
                key: formKey,
                children: <Widget>[
                  FadeAnimation(1.2, makeInput(label: "Usuario", t: 0)),
                  FadeAnimation(1.2, makeInput(label: "Email", t: 1)),
                  FadeAnimation(1.2, makeInput(label: "Celular", t: 2)),
                  FadeAnimation(1.3, makeInput(label: "Password", obscureText: true, t: 3)),
                ],
              ),
              FadeAnimation(1.5, Container(
                padding: EdgeInsets.only(top: 3, left: 3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border(
                    bottom: BorderSide(color: Colors.black),
                    top: BorderSide(color: Colors.black),
                    left: BorderSide(color: Colors.black),
                    right: BorderSide(color: Colors.black),
                  )
                ),
                child: MaterialButton(
                  minWidth: double.infinity,
                  height: 60,
                  onPressed: () {_onSubmit(context);},
                  color: Colors.greenAccent,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)
                  ),
                  child: Text("Registrarse", style: TextStyle(
                    fontWeight: FontWeight.w600, 
                    fontSize: 18
                  ),),
                ),
              )),
              FadeAnimation(1.6, Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Ya tienes una cuenta?"),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                    child: Text(" Ingresar", style: TextStyle(
                    fontWeight: FontWeight.w600, fontSize: 18
                    ),),
                  )
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }

  Widget makeInput({label, obscureText = false, t = 0}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(label, style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: Colors.black87
        ),),
        SizedBox(height: 5,),
        TextField(
          onChanged: (value) {
            switch (t) {
              case 0: registro.usuario = value;
                break;
              case 1: registro.email = value;
                break;
              case 2: registro.telefono = value;
                break;
              case 3: registro.pass = value;
                break;
              default: 
            }
          },
          obscureText: obscureText,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[400])
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[400])
            ),
          ),
        ),
        SizedBox(height: 30,),
      ],
    );
  }

  void _onSubmit(BuildContext context) async{
    print('${registro.email}');
    print('${registro.usuario}');
    print('${registro.pass}');
    print('${registro.telefono}');

    Map info = await usuarioProvider.nuevoUsuario(registro);
    if(info['ok']){
      pasardeVentana(context, 'wrap', 'register');
    }else{
      mostrarAlerta(context, info['mensaje']);
    }
  }
}