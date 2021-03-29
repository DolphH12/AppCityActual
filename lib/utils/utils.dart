import 'package:flutter/material.dart';

bool isNumeric(String s) {

  if(s.isEmpty) return false;

  final n = num.tryParse(s);

  return (n == null)? false: true;

}

void mostrarAlerta(BuildContext context, String mensaje){

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Información incorrecta'),
        content: Text(mensaje),
        actions: [
          FlatButton(
            onPressed: () => Navigator.of(context).pop(), 
            child: Text('Cerrar'),
          )
        ],
      );
    }
  );

}

void pasardeVentana(BuildContext context, String ventana, String actual){
  Navigator.pushReplacementNamed(context, ventana);
}