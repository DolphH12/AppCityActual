import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:muroappmod/models/registro_model.dart';


class UsuarioProvider {
  
  Future<Map<String, dynamic>> login(String usuario, String password) async{

    final headers = {
      'Authorization': 'Basic YXBwY2l0eTp1ZGVh',
      'Content-Type': 'application/x-www-form-urlencoded'
    };
    final request = http.Request('POST', Uri.parse('http://186.86.104.224:8090/api/autenticacion/oauth/token'));
    request.bodyFields = {
      'username': usuario,
      'password': password,
      'grant_type': 'password'
    };
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    Map<String, dynamic> decodedResp = json.decode(await response.stream.bytesToString());

    if(response.statusCode == 200){
      //_prefs.token = decodedResp['idToken'];
      print(decodedResp["access_token"]);
      //print(await response.stream.bytesToString().toString());
      return {'ok': true, 'token': decodedResp["access_token"]};
    }else{
      return{'ok': false, 'mensaje': decodedResp["error"]};
    }

  }

  Future<Map<String, dynamic>> nuevoUsuario(RegistroModel registro) async{

    var headers = {
        'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('http://186.86.104.224:8090/api/registro/registro/crear'));
    request.body = registroModelToJson(registro);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    Map<String, dynamic> decodedResp = json.decode(await response.stream.bytesToString());

    if (response.statusCode == 200) {
      return{'ok': true, 'token': decodedResp['message']};
    }
    else {
      return{'ok': false, 'mensaje': decodedResp['message']};
    }

  }


}