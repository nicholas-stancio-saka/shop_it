import 'dart:convert';

import 'package:shop_it/features/auth/data/models/auth_utils.dart';

class RegisterRequest {
  final int id;
  final String email;
  final String username;
  final String password;
  final Name name;
  final Address address;
  final String phone;

  RegisterRequest({
    required this.id,
    required this.email,
    required this.username,
    required this.password,
    required this.name,
    required this.address,
    required this.phone,
  });

  factory RegisterRequest.fromRawJson(String str) => RegisterRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RegisterRequest.fromJson(Map<String, dynamic> json) => RegisterRequest(
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
