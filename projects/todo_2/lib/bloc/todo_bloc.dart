import 'dart:async';
import 'package:todo_2/model/todo.dart';
import 'package:todo_2/repository/todo_repository.dart';

class TodoBloc {
  final TodoRepository _todoRepository = TodoRepository();
  final StreamController _todoController = StreamController();

  get todos {
    return _todoController.stream;
  }

  Future<void> addTodo(Todo todo) async {
    await _todoRepository.insertTodo(todo);
  }
}