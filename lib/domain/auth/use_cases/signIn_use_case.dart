import 'package:to_do_app/domain/auth/entities/user_entity.dart';
import 'package:to_do_app/domain/auth/repositories/auth_repo.dart';
import 'package:injectable/injectable.dart';
@injectable
class SignInUseCase {
  final AuthRepository repository;

  SignInUseCase(this.repository);

  Future<UserEntity> call(String email, String password) {
    return repository.login(email, password);
  }
}