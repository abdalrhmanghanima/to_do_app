import 'package:to_do_app/data/home/model/to_do_model.dart';

abstract class TodoRemoteDataSource {
  Future<void> addTodo(String title, String description,DateTime? deadLine);
  Stream<List<TodoModel>> getTodos();
  Future<void> deleteTodo(String id);
  Future<void> updateTodo(
    String id,
    String title,
    String description,
    DateTime date,
  );
}
