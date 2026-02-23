import 'package:injectable/injectable.dart';
import 'package:to_do_app/data/auth/data_source/auth_remote_data_source.dart';
import 'package:to_do_app/domain/auth/entities/user_entity.dart';
import 'package:to_do_app/domain/auth/repositories/auth_repo.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remote;

  AuthRepositoryImpl(this.remote);

  @override
  Stream<UserEntity?> authStateChanges() {
    return remote.authStateChanges();
  }

  @override
  Future<UserEntity> signUp(String name, String email, String password) {
    return remote.signUp(name, email, password);
  }

  @override
  Future<UserEntity> login(String email, String password) {
    return remote.login(email, password);
  }

  @override
  Future<void> logout() {
    return remote.logout();
  }
  @override
  Future<UserEntity> signInWithGoogle() {
    return remote.signInWithGoogle();
  }
}
