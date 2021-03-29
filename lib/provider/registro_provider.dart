import 'dart:convert';
import 'dart:io';

import 'package:http_parser/http_parser.dart';
import 'package:mime_type/mime_type.dart';
import 'package:http/http.dart' as http;
import 'package:muroappmod/models/registromodel.dart';
import 'package:muroappmod/preferencias_usuario/preferencias_usuario.dart';

class RegistroProvider {
  
  final String _url = 'https://muroappmod-default-rtdb.firebaseio.com';
  final _prefs = PreferenciasUsuario();

  Future<bool> crearRegistro(RegistroModel registro) async{

    final url = '$_url/Registro/${_prefs.token}.json';

    final resp = await http.post(url, body: registroModelToJson(registro));

    final decodedData = json.decode(resp.body);

    return true;

  }

  // Future<bool> editarProducto(RegistroModel producto) async{

  //   final url = '$_url/Registro/${registro.id}.json?auth=${_prefs.token}';

  //   final resp = await http.put(url, body: registroModelToJson(producto));

  //   final decodedData = json.decode(resp.body);

  //   return true;

  // }

  Future<List<RegistroModel>> cargarRegistros() async{
    final url = '$_url/Registro/${_prefs.token}.json';

    final resp = await http.get(url);

    final Map<String, dynamic> decodedData = json.decode(resp.body);
    final List<RegistroModel> productos = List();

    if(decodedData == null) return [];

    if(decodedData['error'] != null) return [];

    decodedData.forEach((id, prod) { 
      final prodTemp = RegistroModel.fromJson(prod);
      prodTemp.id = id;

      productos.add(prodTemp);

    });

    return productos;

  }


  // Future<int> borrarProducto(String id) async {

  //   final url = '$_url/Registro/$id.json?auth=${_prefs.token}';
  //   final resp = await http.delete(url);

  //   return 1;

  // }

  Future<String> subirImagen(File imagen) async{

    final url = Uri.parse('https://api.cloudinary.com/v1_1/dium0fdut/image/upload?upload_preset=hqruhsgd');
    final mimeType = mime(imagen.path).split('/');

    final imageUploadRequest = http.MultipartRequest(
      'POST',
      url
    );

    final file = await http.MultipartFile.fromPath(
      'file', 
      imagen.path,
      contentType: MediaType(mimeType[0], mimeType[1])
    );

    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    if(resp.statusCode != 200 && resp.statusCode != 201){
      return null;
    }

    final respData  = json.decode(resp.body);

    return respData['secure_url'];

  }


}