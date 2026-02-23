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

  AuthRemoteDataSourceImpl(this.firebaseAuth, this.firestore, this.googleSignIn);

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

    // يبدأ عملية تسجيل الدخول
    final GoogleSignInAccount googleUser =
    await googleSignIn.authenticate();

    // يجيب الـ idToken
    final GoogleSignInAuthentication googleAuth =
        googleUser.authentication;

    // إنشاء Firebase credential
    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
    );

    // تسجيل الدخول في Firebase
    final userCredential =
    await firebaseAuth.signInWithCredential(credential);

    return UserModel.fromFirebase(userCredential.user!);
  }
}
