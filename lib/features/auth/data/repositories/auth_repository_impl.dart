import 'package:shop_it/core/dependency_injection.dart';
import 'package:shop_it/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:shop_it/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:shop_it/features/auth/data/models/auth_response.dart';
import 'package:shop_it/features/auth/domain/entities/user.dart';
import 'package:shop_it/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource authLocalDataSource;

  AuthRepositoryImpl(this.remoteDataSource, this.authLocalDataSource);

  @override
  Future<User> login(String email, String password) async {
    final response = await remoteDataSource.loginWithEmail(email, password);
    final AuthResponse authResponseModel = AuthResponse.fromJson(response);

    final User user = User.fromApi(authResponseModel);

    initializeAfterAuthDependencies(authResponseModel.token);

    // Update local storage
    await authLocalDataSource.saveToken(authResponseModel.token);
    await authLocalDataSource.saveUserID(authResponseModel.user.id);

    return user;
  }

  @override
  Future<User> register(String email, String password) async {
    final response = await remoteDataSource.createAccount(email, password);
    return User.fromApi(AuthResponse.fromJson(response));
  }
}
