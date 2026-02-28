import 'dart:async';
import 'package:cross_file/src/types/interface.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:to_do_app/domain/home/repositories/todo_repo.dart';
import 'package:to_do_app/presentation/home/cubit/to_do_state.dart';

@injectable
class TodoCubit extends Cubit<TodoState> {
  final TodoRepository repository;
  StreamSubscription? _todosSubscription;

  TodoCubit(this.repository) : super(TodoInitial());

  void listenToTodos() {
    emit(TodoLoading());

    _todosSubscription?.cancel();

    _todosSubscription = repository.getTodos().listen(
      (todos) {
        emit(TodoLoaded(todos));
      },
      onError: (error) {
        emit(TodoError(error.toString()));
      },
    );
  }

  Future<void> addTodo(
    String title,
    String description,
    DateTime? deadLine,
    XFile? image,
  ) async {
    try {
      await repository.addTodo(title, description, deadLine, image);
    } catch (e) {
      emit(TodoError(e.toString()));
    }
  }

  Future<void> deleteTodo(String id) async {
    try {
      await repository.deleteTodo(id);
    } catch (e) {
      emit(TodoError(e.toString()));
    }
  }

  Future<void> updateTodo(
    String id,
    String title,
    String description,
    DateTime date,
  ) async {
    try {
      await repository.updateTodo(id, title, description, date);
    } catch (e) {
      emit(TodoError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _todosSubscription?.cancel();
    return super.close();
  }
}
