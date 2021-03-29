import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import '../utils/utils.dart';

class FullScreenMap extends StatefulWidget {

  @override
  _FullScreenMapState createState() => _FullScreenMapState();
}

class _FullScreenMapState extends State<FullScreenMap> {
  MapboxMapController mapController;
  final center = const LatLng(6.2655837,-75.5707694);
  String slectedStyle = 'mapbox://styles/cooappcity/ckj6q74ks03y219ndomi1rwu8';

  void _onMapCreated(MapboxMapController controller) {
    mapController = controller;
    _onStyleLoaded();
    Timer(Duration(seconds: 2), () {
      _simbolAdd();
    
    mapController.onSymbolTapped.add((argument) { pasardeVentana(context, 'information', 'map'); });

    });
    

  }

  void _simbolAdd() {
    mapController.addSymbol(SymbolOptions(
      geometry: center,
      iconSize: 4,
      iconImage: 'assets/img/wall.png',
      textField: 'MURO 1',
      textOffset: const Offset(0,3),
      
    ));

    mapController.addSymbol(SymbolOptions(
      geometry: LatLng(6.2652032522987655, -75.58258608011867),
      iconSize: 4,
      iconImage: 'assets/img/wall.png',
      textField: 'MURO 2',
      textOffset: Offset(0,3),
    ));
    
    mapController.addSymbol(SymbolOptions(
      geometry: LatLng(6.275078723860908, -75.55954054008548),
      iconSize: 4,
      iconImage: 'assets/img/wall.png',
      textField: 'MURO 3',
      textOffset: Offset(0,3),
    ));
  }

  void _onStyleLoaded() {
    addImageFromAsset('assetImage', 'assets/img/wall.png');
    //addImageFromUrl('networkImage', 'https://via.placeholder.com/50');
  }

  /// Adds an asset image to the currently displayed style
  Future<void> addImageFromAsset(String name, String assetName) async {
    final ByteData bytes = await rootBundle.load(assetName);
    final Uint8List list = bytes.buffer.asUint8List();
    return mapController.addImage(name, list);
  }

  /// Adds a network image to the currently displayed style
  // Future<void> addImageFromUrl(String name, String url) async {
  //   var response = await http.get(url);
  //   return mapController.addImage(name, response.bodyBytes);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: crearMapa(),
      floatingActionButton: botonesFlotantes(context),
      
    );
  }

  Column botonesFlotantes(BuildContext context) {
    return Column(
      mainAxisAlignment:  MainAxisAlignment.end,
      children: [
        //Zoom In
        FloatingActionButton(
          heroTag: "btn1",
          backgroundColor: Color.fromRGBO(56, 145, 61, 1.0),
          child: Icon(Icons.zoom_in),
          onPressed: (){
            mapController.animateCamera(CameraUpdate.zoomIn());
          }
        ),

        SizedBox(height: 5,),

        //Zoom Out
        FloatingActionButton(
          heroTag: "btn2",
          backgroundColor: Color.fromRGBO(56, 145, 61, 1.0),
          child: Icon(Icons.zoom_out),
          onPressed: (){
            mapController.animateCamera(CameraUpdate.zoomOut());
          }
        ),

        SizedBox(height: 5,),

        FloatingActionButton(
          heroTag: "btn3",
          backgroundColor: Color.fromRGBO(56, 145, 61, 1.0),
          child: Icon(Icons.home),
          onPressed: (){
            pasardeVentana(context, 'home', 'mapa');
          }
        ),

        
      ],
    );
  }

  MapboxMap crearMapa() {
    return MapboxMap(
        styleString: slectedStyle,
        onMapCreated: _onMapCreated,
        initialCameraPosition:
          CameraPosition(
            target: center,
            zoom: 14
          ),
      );
  }
}