import 'dart:async';
import 'package:todo_2/model/todo.dart';
import 'package:todo_2/repository/todo_repository.dart';

class TodoBloc {
  final TodoRepository _todoRepository = TodoRepository();
  final StreamController _todoController = StreamController();

  get todos {
    return _todoController.stream;
  }

  Future<void> getAllTodos() async {
    List<dynamic> getAllTodosResult = await _todoRepository.getAllTodos();

    if (getAllTodosResult[1] == null) {
      // 서버 에러
    }

    _todoController.sink.add(getAllTodosResult[1]);
  }

  Future<void> addTodo(Todo todo) async {
    await _todoRepository.insertTodo(todo);
    await getAllTodos();
  }

  Future<void> updateTodo(Todo todo) async {
    List<dynamic> updateTodoResult = await _todoRepository.updateTodo(todo);

    if (updateTodoResult[1] == null) {
      // 서버 에러
    }

    await getAllTodos();
  }

  Future<void> deleteTodo(int id) async {
    List<dynamic> deleteTodoResult = await _todoRepository.deleteTodo(id);

    if (deleteTodoResult[1] == null) {
      // 서버 에러
    }

    await getAllTodos();
  }
}