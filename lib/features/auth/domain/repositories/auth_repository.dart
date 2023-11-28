import 'package:shop_it/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<User> login(String username, String password);
  Future<User> register(String username, String password);
}
