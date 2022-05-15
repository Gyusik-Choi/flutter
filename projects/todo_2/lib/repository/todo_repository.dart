import 'package:todo_2/dao/todo_dao.dart';
import 'package:todo_2/model/todo.dart';

class TodoRepository {
  final TodoDao _todoDao = TodoDao();

  Future<List<dynamic>> getAllTodos() async {
    return await _todoDao.getAllTodos();
  }

  Future<void> insertTodo(Todo todo) async {
    return await _todoDao.createTodo(todo);
  }

  Future<List<dynamic>> updateTodo(Todo todo) async {
    return await _todoDao.updateTodo(todo);
  }

  Future<List<dynamic>> deleteTodo(int id) async {
    return await _todoDao.deleteTodo(id);
  }
}