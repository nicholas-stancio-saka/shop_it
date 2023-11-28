import 'package:shop_it/features/auth/domain/entities/user.dart';
import 'package:shop_it/features/auth/domain/repositories/auth_repository.dart';

class RegisterUser {
  final AuthRepository repository;

  RegisterUser(this.repository);

  Future<User> call(String email, String password) async {
    return await repository.register(email, password);
  }
}
