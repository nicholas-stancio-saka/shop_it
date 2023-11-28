import 'dart:convert';

class AuthRequest {
  final UserRequest user;

  AuthRequest({
    required this.user,
  });

  factory AuthRequest.fromRawJson(String str) => AuthRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AuthRequest.fromJson(Map<String, dynamic> json) => AuthRequest(
        user: UserRequest.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
      };
}

class UserRequest {
  final String email;
  final String password;

  UserRequest({
    required this.email,
    required this.password,
  });

  factory UserRequest.fromRawJson(String str) => UserRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserRequest.fromJson(Map<String, dynamic> json) => UserRequest(
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
      };
}
