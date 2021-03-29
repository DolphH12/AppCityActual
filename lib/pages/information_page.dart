import 'dart:math';

import 'package:flutter/material.dart';

class InformationPage extends StatelessWidget {
  const InformationPage
({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _fondoApp(),
          Center(
            child: Text('Aqui va la informacion', style: TextStyle(color: Colors.white, fontSize: 30.0, fontWeight: FontWeight.bold)),
          )
        ],
      ),
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

}
