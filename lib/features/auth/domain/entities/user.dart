import 'package:shop_it/features/auth/data/models/auth_response.dart';

class User {
  final int id;
  final String email;

  User({
    required this.id,
    required this.email,
  });

  factory User.fromApi(AuthResponse authResponse) {
    return User(
      id: authResponse.user.id,
      email: authResponse.user.email,
    );
  }
}
