import 'dart:async';

import 'package:todo_1/model/todo.dart';
import 'package:todo_1/repository/todo_repository.dart';

class TodoBloc {
  final TodoRepository _todoRepository = TodoRepository();
  final StreamController _controller = StreamController.broadcast();

  get todos => _controller.stream;

  Future<void> getTodos({String? query}) async {
    List<dynamic> todos = await _todoRepository.getAllTodos(query: query);
    _controller.sink.add(todos);
  }

  Future<void> insertTodo(Todo todo) async {
    await _todoRepository.insertTodo(todo);
  }
}