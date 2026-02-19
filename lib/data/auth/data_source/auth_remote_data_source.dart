import 'package:to_do_app/data/auth/model/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> signUp(
      String name,
      String email,
      String password,
      );


  Future<UserModel> login(String email, String password);

  Future<void> logout();

  Stream<UserModel?> authStateChanges();
}
