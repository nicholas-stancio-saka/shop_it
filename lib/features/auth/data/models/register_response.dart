import 'dart:convert';

import 'package:shop_it/features/auth/data/models/auth_utils.dart';

class RegisterResponse {
  final int id;
  final String email;
  final String username;
  final String password;
  final Name name;
  final Address address;
  final String phone;

  RegisterResponse({
    required this.id,
    required this.email,
    required this.username,
    required this.password,
    required this.name,
    required this.address,
    required this.phone,
  });

  factory RegisterResponse.fromRawJson(String str) => RegisterResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RegisterResponse.fromJson(Map<String, dynamic> json) => RegisterResponse(
        id: json["id"],
        email: json["email"],
        username: json["username"],
        password: json["password"],
        name: Name.fromJson(json["name"]),
        address: Address.fromJson(json["address"]),
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "username": username,
        "password": password,
        "name": name.toJson(),
        "address": address.toJson(),
        "phone": phone,
      };
}
