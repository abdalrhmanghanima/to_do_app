import 'package:to_do_app/domain/auth/entities/user_entity.dart';

abstract class AuthRepository {
  Stream<UserEntity?> authStateChanges();
  Future<UserEntity> signUp(String name, String email, String password);

  Future<UserEntity> login(String email, String password);
  Future<void> logout();
  Future<UserEntity> signInWithGoogle();
}
