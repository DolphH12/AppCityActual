// To parse this JSON data, do
//
//     final registroModel = registroModelFromJson(jsonString);

import 'dart:convert';

RegistroModel registroModelFromJson(String str) => RegistroModel.fromJson(json.decode(str));

String registroModelToJson(RegistroModel data) => json.encode(data.toJson());

class RegistroModel {
    RegistroModel({
        this.id,
        this.telefono,
        this.email,
        this.usuario,
        this.pass,
        this.fotoUrl,
    });

    String id;
    String telefono;
    String email;
    String usuario;
    String pass;
    String fotoUrl;

    factory RegistroModel.fromJson(Map<String, dynamic> json) => RegistroModel(
        id: json["id"],
        telefono: json["telefono"],
        email: json["email"],
        usuario: json["usuario"],
        pass: json["pass"],
        fotoUrl: json["fotoUrl"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "telefono": telefono,
        "email": email,
        "usuario": usuario,
        "pass": pass,
        "fotoUrl": fotoUrl,
    };
}
