import 'package:injectable/injectable.dart';
import 'package:to_do_app/domain/auth/entities/user_entity.dart';
import 'package:to_do_app/domain/auth/repositories/auth_repo.dart';
@injectable
class SignInWithGoogleUseCase {
  final AuthRepository authRepository;
  SignInWithGoogleUseCase(this.authRepository);
  Future<UserEntity> call() {
    return authRepository.signInWithGoogle();
  }
}
