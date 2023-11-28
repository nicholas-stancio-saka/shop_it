import 'dart:convert';

class AuthResponse {
  final String token;

  AuthResponse({
    required this.token,
  });

  factory AuthResponse.fromRawJson(String str) => AuthResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AuthResponse.fromJson(Map<String, dynamic> json) => AuthResponse(
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
      };
}
