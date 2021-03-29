import 'dart:convert';

RegistroModel registroModelFromJson(String str) => RegistroModel.fromJson(json.decode(str));

String registroModelToJson(RegistroModel data) => json.encode(data.toJson());

class RegistroModel {
    RegistroModel({
        this.telefono,
        this.email,
        this.usuario,
        this.pass,
    });
    String telefono;
    String email;
    String usuario;
    String pass;

    factory RegistroModel.fromJson(Map<String, dynamic> json) => RegistroModel(
        telefono: json["phone"],
        email: json["email"],
        usuario: json["username"],
        pass: json["password"],
    );

    Map<String, dynamic> toJson() => {
        "phone": telefono,
        "email": email,
        "username": usuario,
        "password": pass,
    };
}
