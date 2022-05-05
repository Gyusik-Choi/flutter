import 'package:todo_2/dao/todo_dao.dart';
import 'package:todo_2/model/todo.dart';

class TodoRepository {
  final TodoDao _todoDao = TodoDao();

  Future<void> insertTodo(Todo todo) async {
    await _todoDao.createTodo(todo);
  }
}