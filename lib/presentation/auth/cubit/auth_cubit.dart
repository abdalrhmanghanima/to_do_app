import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:to_do_app/domain/auth/use_cases/auth_state_changes_use_case.dart';
import 'package:to_do_app/domain/auth/use_cases/logout_use_case.dart';
import 'package:to_do_app/domain/auth/use_cases/signIn_use_case.dart';
import 'package:to_do_app/domain/auth/use_cases/sign_in_with_google_use_case.dart';
import 'package:to_do_app/domain/auth/use_cases/signup_use_case.dart';
import 'package:to_do_app/presentation/auth/cubit/auth_state.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  final SignInUseCase signInUseCase;
  final SignUpUseCase signUpUseCase;
  final LogoutUseCase logoutUseCase;
  final AuthStateChangesUseCase authStateChangesUseCase;
  final SignInWithGoogleUseCase signInWithGoogleUseCase;

  AuthCubit(
    this.signInUseCase,
    this.signUpUseCase,
    this.logoutUseCase,
    this.authStateChangesUseCase,
    this.signInWithGoogleUseCase,
  ) : super(AuthInitial());

  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    try {
      final user = await signInUseCase(email, password);
      emit(Authenticated(user));
    } catch (e) {
      emit(AuthError(_mapError(e)));
    }
  }

  Future<void> signUp(String name, String email, String password) async {
    emit(AuthLoading());
    try {
      final user = await signUpUseCase(name, email, password);
      emit(Authenticated(user));
    } catch (e) {
      emit(AuthError(_mapError(e)));
    }
  }

  Future<void> logout() async {
    await logoutUseCase();
    emit(Unauthenticated());
  }

  void listenToAuthChanges() {
    authStateChangesUseCase().listen((user) {
      if (user != null) {
        emit(Authenticated(user));
      } else {
        emit(Unauthenticated());
      }
    });
  }

  Future<void> signInWithGoogle() async {
    emit(AuthLoading());
    try {
      final user = await signInWithGoogleUseCase();
      emit(Authenticated(user));
    } catch (e) {
      // User explicitly aborted Google sign-in: do not show an error
      if (e.toString().contains('SIGN_IN_ABORTED_BY_USER')) {
        emit(Unauthenticated());
        return;
      }

      emit(AuthError(_mapError(e)));
    }
  }

  String _mapError(Object e) {
    if (e is FirebaseAuthException) {
      switch (e.code) {
        case 'user-not-found':
          return "No user found with this email";
        case 'wrong-password':
          return "Wrong password";
        case 'email-already-in-use':
          return "Email already exists";
        case 'weak-password':
          return "Password is too weak";
        case 'invalid-email':
          return "Invalid email format";
        default:
          return e.message ?? "Authentication failed";
      }
    }
    return "Something went wrong";
  }
}
