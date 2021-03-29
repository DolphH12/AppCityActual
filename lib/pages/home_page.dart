import 'dart:math';
import 'package:flutter/material.dart';
import 'package:muroappmod/models/registromodel.dart';
import 'package:muroappmod/provider/registro_provider.dart';
import 'package:provider/provider.dart';

import '../stores/login_store.dart';
import '../utils/utils.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final registroProvider = RegistroProvider();

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginStore>(
      builder: (_, loginStore, __) {
        return Scaffold(
          body: Stack(
        children: [
          _fondoApp(),
          SingleChildScrollView(
            child: Column(
              children: [
                //_crearUsuario(),
                _titulos(),
                _botonesRedondeados(context),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: _bottomNavigationBar(context,loginStore),
        );
      },
    );
  }

  BottomNavigationBar _bottomNavigationBar(BuildContext context, LoginStore loginStore) {
    return BottomNavigationBar(
      backgroundColor: Color.fromRGBO(56, 145, 61, 1.0),
      selectedItemColor: Color.fromRGBO(25, 61, 26, 1.0),
      unselectedItemColor: Color.fromRGBO(174, 213, 129, 1.0),
      iconSize: 35.0,
      items: [
        const BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.mail),
          label: 'Mensajes',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.supervised_user_circle),
          label: 'Perfil',
        ),
      ],
      onTap: (value) {
        if(value == 2) loginStore.signOut(context);
      },
    );
  }

  Widget _fondoApp(){

    final gradiente = Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: FractionalOffset(0.0, 0.6),
          end: FractionalOffset(0.0, 1.0),
          colors: [
            Color.fromRGBO(174, 213, 129, 1.0),
            Color.fromRGBO(249, 251, 231, 1.0),
          ],
        ),
      ),
    );

    final cajaVerde = Transform.rotate(
      angle: -pi / 5.0,
      child: Container(
        width: 400.0,
        height: 400.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(80.0),
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(27, 94, 32, 1.0),
              Color.fromRGBO(71, 188, 77, 1.0),
            ]
          ),
        ),
      ),
    );
    


    return Stack(
      children: [
        gradiente,
        Positioned(
          top: -100.0,
          left: -50,
          child: cajaVerde),
      ],
    );

  }

  Widget _titulos(){

    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('CITY SUPER APP', style: TextStyle(color: Colors.white, fontSize: 30.0, fontWeight: FontWeight.bold)),
            SizedBox(height: 10.0,),
            Text('Construyamos un lugar mejor', style: TextStyle(color: Colors.white, fontSize: 18.0,))
          ],
        ),
      ),
    );

  }

  // Widget _crearUsuario(){
  //   return FutureBuilder(
  //     future: registroProvider.cargarRegistros(),
  //     builder: (BuildContext context, AsyncSnapshot<List<RegistroModel>> snapshot) {
  //       if ( snapshot.hasData ) {

  //         final registros = snapshot.data;

  //         return _crearItem(context, registros[0]);

  //       } else {
  //         return Center( child: CircularProgressIndicator());
  //       }
  //     },
  //   );
  // }

  Widget _crearItem(BuildContext context, RegistroModel registro ) {
    
    print(registro);

    return Container(
      margin: EdgeInsets.only(top: 50),
      child: Column(
        children: [
          ( registro.fotoUrl == null ) 
          ? Image(image: AssetImage('assets/img/no-image.png'))
          : FadeInImage(
            image: NetworkImage( registro.fotoUrl ),
            placeholder: AssetImage('assets/img/jar-loading.gif'),
            height: 100.0,
            width: 100.0,
            fit: BoxFit.cover,
          ),
          Text('BIENVENIDO', style: TextStyle(color: Colors.white, fontSize: 25.0, fontWeight: FontWeight.bold)),
          Text('${registro.usuario}', style: TextStyle(color: Colors.white, fontSize: 25.0, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _botonesRedondeados(BuildContext context){

    return Table(
      children: [
        TableRow(
          children: [
            GestureDetector(
              onTap: (){
                pasardeVentana(context, 'mapa', 'home');
              },
              child: _crearBotonRedondeado(Colors.blue, Icons.border_all_rounded, 'MURO')
            ),
            _crearBotonRedondeado(Colors.purpleAccent, Icons.directions_bus, 'TRANSPORTE')
          ]
        ),
        TableRow(
          children: [
            _crearBotonRedondeado(Colors.pinkAccent, Icons.shop, 'MERCADO'),
            _crearBotonRedondeado(Colors.orange, Icons.insert_drive_file, 'ANALISIS')
          ]
        ),
        TableRow(
          children: [
            _crearBotonRedondeado(Colors.blueAccent, Icons.movie_filter, 'ENTRETENIMIENTO'),
            _crearBotonRedondeado(Colors.green, Icons.cloud, 'NUBE')
          ]
        ),
        TableRow(
          children: [
            _crearBotonRedondeado(Colors.red, Icons.collections, 'GALERIA'),
            _crearBotonRedondeado(Colors.teal, Icons.help_outline, 'AYUDA')
          ]
        )          
      ],
    );

  }

  Widget _crearBotonRedondeado(Color color, IconData icono, String palabra){

    return Container(
      height: 180.0,
      margin: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(255, 255, 255, 0.8),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column( 
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(height: 5.0,),
          CircleAvatar(
            backgroundColor: color,
            radius: 35.0,
            child: Icon(icono, color: Colors.white, size: 30.0,),
          ),
          Text(palabra, style: TextStyle(color: color),),
          SizedBox(height: 5.0,)
        ],
      ),
    );
  }

}
