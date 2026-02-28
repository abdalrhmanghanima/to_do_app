import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:to_do_app/data/home/data_source/todo_remote_data_source.dart';
import 'package:to_do_app/data/home/model/to_do_model.dart';

@LazySingleton(as: TodoRemoteDataSource)
class TodoRemoteDataSourceImpl implements TodoRemoteDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth firebaseAuth;

  TodoRemoteDataSourceImpl(this.firestore, this.firebaseAuth);

  String get uid => firebaseAuth.currentUser!.uid;

  @override
  Future<void> addTodo(
    String title,
    String description,
    DateTime? deadline,
    XFile? image,
  ) async {
    await firestore.collection('users').doc(uid).collection('tasks').add({
      'title': title,
      'description': description,
      'createdAt': FieldValue.serverTimestamp(),
      'deadline': deadline != null ? Timestamp.fromDate(deadline) : null,
    });
  }

  @override
  Stream<List<TodoModel>> getTodos() {
    return firestore
        .collection('users')
        .doc(uid)
        .collection('tasks')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            return TodoModel.fromJson(doc.data(), doc.id);
          }).toList();
        });
  }

  @override
  Future<void> deleteTodo(String id) async {
    await firestore
        .collection('users')
        .doc(uid)
        .collection('tasks')
        .doc(id)
        .delete();
  }

  @override
  Future<void> updateTodo(
    String id,
    String title,
    String description,
    DateTime date,
  ) async {
    await firestore
        .collection('users')
        .doc(uid)
        .collection('tasks')
        .doc(id)
        .update({
          'title': title,
          'description': description,
          'createdAt': date,
        });
  }
}
