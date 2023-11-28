import 'dart:convert';

class AuthRequest {
  final String username;
  final String password;

  AuthRequest({
    required this.username,
    required this.password,
  });

  factory AuthRequest.fromRawJson(String str) => AuthRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AuthRequest.fromJson(Map<String, dynamic> json) => AuthRequest(
        username: json["username"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
      };
}
