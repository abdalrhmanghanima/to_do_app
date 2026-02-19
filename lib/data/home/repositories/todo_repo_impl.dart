import 'package:injectable/injectable.dart';
import 'package:to_do_app/data/home/data_source/todo_remote_data_source.dart';
import 'package:to_do_app/data/home/model/to_do_model.dart';
import 'package:to_do_app/domain/home/repositories/todo_repo.dart';

@LazySingleton(as: TodoRepository)
class TodoRepositoryImpl implements TodoRepository {
  final TodoRemoteDataSource remote;

  TodoRepositoryImpl(this.remote);

  @override
  Future<void> addTodo(String title, String description) {
    return remote.addTodo(title, description);
  }

  @override
  Stream<List<TodoModel>> getTodos() {
    return remote.getTodos();
  }

  @override
  Future<void> deleteTodo(String id) {
    return remote.deleteTodo(id);
  }

  @override
  Future<void> updateTodo(
    String id,
    String title,
    String description,
    DateTime date,
  ) {
    return remote.updateTodo(id, title, description, date);
  }
}
