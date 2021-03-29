import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:muroappmod/models/registromodel.dart';
import 'package:muroappmod/provider/registro_provider.dart';
import 'package:muroappmod/theme.dart';
import 'package:muroappmod/utils/utils.dart';

class SignuptoPage extends StatefulWidget {

  // ATRIBUTOS
  final String _phoneNumber;

  // CONSTRUCTOR
  SignuptoPage(this._phoneNumber);

  @override
  _SignuptoPageState createState() => _SignuptoPageState();
}

class _SignuptoPageState extends State<SignuptoPage> {

  RegistroModel registro = RegistroModel();
  RegistroProvider registroProvider = RegistroProvider();
  final formKey = GlobalKey<FormState>();
  File foto;

  final imgFondo = Container(
    padding: EdgeInsets.only(top: 50.0),
    child: Column(
      children: [
        Image(
          image: AssetImage("assets/img/login2.png"),
          height: 150.0,
        ),
        SizedBox(height: 10.0, width: double.infinity),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _crearFondo(context),
          imgFondo,
          _crearCuentaNuevaForm(context)
        ],
      )
    );
  }

  Widget _crearFondo(BuildContext context){

    // MEDIA QUERY
    final screenSize = MediaQuery.of(context).size;

    // FONDO
    final fondoVerde = Container(
      height: screenSize.height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
           colors:[
            Color.fromRGBO(27, 94, 32, 1.0),
            Color.fromRGBO(71, 188, 77, 1.0),
          ]
        )
      ),
    );

    // CIRCULO
    final circulo = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: Color.fromRGBO(255, 255, 255, 0.1)
      ),
    );

    // RETURN
    return Stack(
      children: [
        fondoVerde,
        Positioned( child: circulo, top: 90.0, left: 30.0,),
        Positioned( child: circulo, top: -40.0, right: -30.0,),
        Positioned( child: circulo, bottom: 80.0, right: 30.0,),
        Positioned( child: circulo, bottom: -40.0, left: 120.0,),
      ],
    );
  }

  Widget _crearCuentaNuevaForm(BuildContext context) {

    // MEDIA QUERY
    final screenSize = MediaQuery.of(context).size;

    // RETURN
    return SingleChildScrollView(
      child: Column(
        children: [
          SafeArea(
            child: Container(
              height: 150.0,
            ),
          ),
          Container(
            width: screenSize.width * 0.80,
            margin: EdgeInsets.symmetric(vertical: 35.0),
            padding: EdgeInsets.symmetric(vertical: 20.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 3.0,
                  offset: Offset(0.0, 5.0),
                  spreadRadius: 3.0
                )
              ]
            ),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Text("Crea tu cuenta", style: TextStyle(fontSize: 20.0),),
                  SizedBox(height: 40.0),
                  _mostrarFoto(),
                  _crearBotonFoto(),
                  SizedBox(height: 20.0),
                  _crearPhoneNumb(context),
                  SizedBox(height: 20.0),
                  _crearEmail(),
                  SizedBox(height: 20.0),
                  _crearUsuario(),
                  SizedBox(height: 20.0),
                  _crearPassword(),
                  SizedBox(height: 20.0),
                  _crearBoton()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _crearPhoneNumb(BuildContext context) {

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        enableInteractiveSelection: false,
        onSaved: (value) => registro.telefono = widget._phoneNumber,
        decoration: InputDecoration(
          icon: Icon(Icons.phone_android, color: Color.fromRGBO(27, 94, 32, 1.0)),
          labelText: "${widget._phoneNumber.substring(0,3)} ${widget._phoneNumber.substring(3, (widget._phoneNumber.length))}",
        ),
        onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
      ),
    );
  }

  Widget _crearEmail() {

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        onSaved: (value) => registro.email = value,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          icon: Icon(Icons.alternate_email, color: Color.fromRGBO(27, 94, 32, 1.0)),
          labelText: "Correo electrónico",
        ),
      ),
    );
  }

  Widget _crearUsuario() {

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        onSaved: (value) => registro.usuario = value,
        decoration: InputDecoration(
          icon: Icon(Icons.person, color: Color.fromRGBO(27, 94, 32, 1.0)),
          labelText: "Nombre de usuario",
        ),
      ),
    );
  }

  Widget _crearPassword() {

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        onSaved: (value) => registro.pass = value,
        obscureText: true,
        decoration: InputDecoration(
          icon: Icon(Icons.lock_outline, color: Color.fromRGBO(27, 94, 32, 1.0)),
          labelText: "Contraseña",
        ),
      ),
    );
  }

  Widget _crearBoton() {

    return RaisedButton(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
        child: Text("Continuar"),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0)
      ),
      elevation: 0.0,
      color: Color.fromRGBO(27, 94, 32, 1.0),
      textColor: Colors.white,
      onPressed: () {_submit();}
          );
  }

  Widget _crearBotonFoto() {
    return RaisedButton(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 15.0),
        child: Text("FOTO DE PERFIL"),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0)
      ),
      elevation: 0.0,
      color: Color.fromRGBO(27, 94, 32, 1.0),
      textColor: Colors.white,
      onPressed: _seleccionarFoto,
          );
  }

  _seleccionarFoto() async {

    _procesarImagen(ImageSource.gallery);

  }
  
  
  _tomarFoto()async {

    _procesarImagen(ImageSource.camera);

  }

  _procesarImagen(ImageSource origen) async{
    final _picked = ImagePicker();
    final pickedFile = await _picked.getImage(
      source: origen
    );
    foto = File(pickedFile.path);

    if (foto != null) {
      registro.fotoUrl = null;
    }
    setState(() {});
  }

  Widget _mostrarFoto(){

    if(registro.fotoUrl != null){
      return FadeInImage(
        placeholder: AssetImage('assets/img/jar-loading.gif'), 
        image: NetworkImage(registro.fotoUrl),
        height: 300.0,
        fit: BoxFit.fill
      );
    }else{

      if( foto != null ){
        return Image.file(
          foto,
          fit: BoxFit.fill,
          height: 300.0,
        );
      }
      return Image(
        image: AssetImage(foto?.path ?? 'assets/img/no-image.png'),
        height: 300.0,
        fit: BoxFit.cover,
      );
    }

  }
      
    void _submit() async {
      formKey.currentState.save();

      if(foto != null) {
        registro.fotoUrl= await registroProvider.subirImagen(foto);
      }

      registroProvider.crearRegistro(registro);
      pasardeVentana(context, 'wrap', 'register');
    }
}