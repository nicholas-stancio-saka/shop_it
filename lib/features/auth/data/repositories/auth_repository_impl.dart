import 'package:shop_it/core/dependency_injection.dart';
import 'package:shop_it/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:shop_it/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:shop_it/features/auth/data/models/get_user_response.dart';
import 'package:shop_it/features/auth/data/models/login_response.dart';
import 'package:shop_it/features/auth/data/models/register_response.dart';
import 'package:shop_it/features/auth/domain/entities/user.dart';
import 'package:shop_it/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource authLocalDataSource;

  AuthRepositoryImpl(this.remoteDataSource, this.authLocalDataSource);

  @override
  Future<User> login(String username, String password) async {
    final String token = (await _login(username, password)).token;

    // TODO: Get user model on success
    // The current API does not provide a way to get user id from login
    // It only returns token

    // Assume API returns ID '1'
    const int userId = 1;

    // Get user details
    final response = await remoteDataSource.getUser(userId);
    final GetUserResponse getUserResponse = GetUserResponse.fromJson(response);

    final User user = User(
      id: getUserResponse.id,
      name: getUserResponse.name.firstname,
    );

    // Save to local storage
    await _saveToLocal(token, user);

    initializeAfterAuthDependencies(token);

    return user;
  }

  @override
  Future<User> register(String username, String password) async {
    final response = await remoteDataSource.createAccount(username, password);
    final RegisterResponse registerResponse = RegisterResponse.fromJson(response);

    // Get Token on success
    final String token = (await _login(username, password)).token;

    final User user = User(
      id: registerResponse.id,
      name: registerResponse.name.firstname,
    );

    // Save to local storage
    await _saveToLocal(token, user);

    initializeAfterAuthDependencies(token);

    return user;
  }

  Future<LoginResponse> _login(String username, String password) async {
    final response = await remoteDataSource.loginWithEmail(username, password);
    return LoginResponse.fromJson(response);
  }

  Future<void> _saveToLocal(String token, User user) async {
    // Update local storage
    await authLocalDataSource.saveToken(token);
    await authLocalDataSource.saveUser(user);
  }
}
