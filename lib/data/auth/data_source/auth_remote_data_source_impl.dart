import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:to_do_app/data/auth/data_source/auth_remote_data_source.dart';
import 'package:to_do_app/data/auth/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;
  final GoogleSignIn googleSignIn;

  AuthRemoteDataSourceImpl(
    this.firebaseAuth,
    this.firestore,
    this.googleSignIn,
  );

  @override
  Future<UserModel> signUp(String name, String email, String password) async {
    final credential = await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final user = credential.user!;

    await user.updateDisplayName(name);

    await firestore.collection('users').doc(user.uid).set({
      'name': name,
      'email': email,
      'createdAt': FieldValue.serverTimestamp(),
    });

    return UserModel.fromFirebase(user);
  }

  @override
  Future<UserModel> login(String email, String password) async {
    final credential = await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    return UserModel.fromFirebase(credential.user!);
  }

  @override
  Future<void> logout() async {
    await firebaseAuth.signOut();
  }

  @override
  Stream<UserModel?> authStateChanges() {
    return firebaseAuth.authStateChanges().map(
      (user) => user != null ? UserModel.fromFirebase(user) : null,
    );
  }

  @override
  Future<UserModel> signInWithGoogle() async {
    // Start Google Sign-In flow
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    // User aborted the sign-in flow
    if (googleUser == null) {
      throw Exception('SIGN_IN_ABORTED_BY_USER');
    }

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken,
    );

    final userCredential = await firebaseAuth.signInWithCredential(credential);

    final user = userCredential.user;
    if (user == null) {
      throw FirebaseAuthException(
        code: 'user-null',
        message: 'Failed to retrieve user from Google sign-in.',
      );
    }

    return UserModel.fromFirebase(user);
  }
}
