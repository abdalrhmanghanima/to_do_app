import 'package:to_do_app/domain/auth/entities/user_entity.dart';
import 'package:to_do_app/domain/auth/repositories/auth_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class SignUpUseCase {
  final AuthRepository repository;

  SignUpUseCase(this.repository);

  Future<UserEntity> call(String name, String email, String password) {
    return repository.signUp(name, email, password);
  }
}
