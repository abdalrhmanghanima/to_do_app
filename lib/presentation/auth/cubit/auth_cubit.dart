import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:to_do_app/domain/auth/repositories/auth_repo.dart';
import 'package:to_do_app/presentation/auth/cubit/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  final AuthRepository repository;

  AuthCubit(this.repository) : super(AuthInitial());

  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    try {
      final user = await repository.login(email, password);
      emit(Authenticated(user));
    } catch (e) {
      String message = "Something went wrong";

      if (e is FirebaseAuthException) {
        if (e.code == 'user-not-found') {
          message = "No user found with this email";
        } else if (e.code == 'wrong-password') {
          message = "Wrong password";
        } else if (e.code == 'email-already-in-use') {
          message = "Email already exists";
        } else if (e.code == 'weak-password') {
          message = "Password is too weak";
        }
      }

      emit(AuthError(message));
    }
  }

  Future<void> signUp(String name, String email, String password) async {
    emit(AuthLoading());

    try {
      final user = await repository.signUp(name, email, password);

      emit(Authenticated(user));
    } catch (e) {
      String message = "Something went wrong";

      if (e is FirebaseAuthException) {
        switch (e.code) {
          case 'email-already-in-use':
            message = "Email already exists";
            break;

          case 'weak-password':
            message = "Password is too weak";
            break;

          case 'user-not-found':
            message = "No user found with this email";
            break;

          case 'wrong-password':
            message = "Wrong password";
            break;

          case 'invalid-email':
            message = "Invalid email format";
            break;

          default:
            message = e.message ?? "Authentication failed";
        }
      }

      emit(AuthError(message));
    }
  }

  void listenToAuthChanges() {
    repository.authStateChanges().listen((user) {
      if (user != null) {
        emit(Authenticated(user));
      } else {
        emit(Unauthenticated());
      }
    });
  }
}
