import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:to_do_app/data/home/model/to_do_model.dart';
import 'package:to_do_app/domain/home/repositories/todo_repo.dart';

@injectable
class TodoCubit extends Cubit<List<TodoModel>> {
  final TodoRepository repository;

  TodoCubit(this.repository) : super([]);

  void listenToTodos() {
    repository.getTodos().listen((todos) {
      emit(todos);
    });
  }

  Future<void> addTodo(String title, String description, DateTime? deadLine) async {
    await repository.addTodo(title, description,deadLine);
  }

  Future<void> deleteTodo(String id) async {
    await repository.deleteTodo(id);
  }

  Future<void> updateTodo(
    String id,
    String title,
    String description,
    DateTime date,
  ) async {
    await repository.updateTodo(id, title, description, date);
  }
}
