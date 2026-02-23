import 'package:to_do_app/domain/auth/entities/user_entity.dart';
import 'package:to_do_app/domain/auth/repositories/auth_repo.dart';
import 'package:injectable/injectable.dart';
@injectable
class AuthStateChangesUseCase {
  final AuthRepository repository;

  AuthStateChangesUseCase(this.repository);

  Stream<UserEntity?> call() {
    return repository.authStateChanges();
  }
}