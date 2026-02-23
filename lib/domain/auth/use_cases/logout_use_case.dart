import 'package:to_do_app/domain/auth/repositories/auth_repo.dart';
import 'package:injectable/injectable.dart';
@injectable
class LogoutUseCase {
  final AuthRepository repository;

  LogoutUseCase(this.repository);

  Future<void> call() {
    return repository.logout();
  }
}