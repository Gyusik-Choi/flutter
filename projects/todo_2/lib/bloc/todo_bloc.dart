import 'dart:async';
import 'package:todo_2/model/todo.dart';
import 'package:todo_2/repository/todo_repository.dart';

class TodoBloc {
  final TodoRepository _todoRepository = TodoRepository();
  final StreamController _todoController = StreamController<List<dynamic>>();

  get todos {
    return _todoController.stream;
  }

  Future<bool> getAllTodos() async {
    List<dynamic> getAllTodosResult = await _todoRepository.getAllTodos();

    if (getAllTodosResult[1] == null) {
      // 서버 에러
      return false;
    }

    _todoController.sink.add(getAllTodosResult[1]);
    return true;
  }

  Future<dynamic> addTodo(Todo todo) async {
    List<dynamic> insertTodoResult = await _todoRepository.insertTodo(todo);

    if (insertTodoResult[1] == null) {
      // 서버 에
      return false;
    }

    await getAllTodos();
  }

  Future<dynamic> updateTodo(Todo todo) async {
    List<dynamic> updateTodoResult = await _todoRepository.updateTodo(todo);

    if (updateTodoResult[1] == null) {
      // 서버 에러
      return false;
    }

    await getAllTodos();
  }

  Future<dynamic> deleteTodo(int id) async {
    List<dynamic> deleteTodoResult = await _todoRepository.deleteTodo(id);

    if (deleteTodoResult[1] == null) {
      // 서버 에러
      return false;
    }

    await getAllTodos();
  }
}