import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'di.config.dart';

final sl = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async {
  await sl.init();
}
@module
abstract class RegisterModule {

  @lazySingleton
  FirebaseAuth get firebaseAuth =>
      FirebaseAuth.instance;

  @lazySingleton
  FirebaseFirestore get firestore =>
      FirebaseFirestore.instance;
}
