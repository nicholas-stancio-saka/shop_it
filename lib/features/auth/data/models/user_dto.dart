import 'dart:convert';

class UserDTO {
  final int id;
  final String email;

  UserDTO({
    required this.id,
    required this.email,
  });

  factory UserDTO.fromRawJson(String str) => UserDTO.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserDTO.fromJson(Map<String, dynamic> json) => UserDTO(
        id: json["id"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
      };
}
