import 'package:todo_1/dao/todo_dao.dart';
import 'package:todo_1/model/todo.dart';

class TodoRepository {
  final TodoDao todoDao = TodoDao();

  Future<dynamic> getAllTodos({String? query}) => todoDao.getTodos(query: query);
  Future<dynamic> insertTodo(Todo todo) => todoDao.createTodo(todo);
  Future<dynamic> deleteTodoById(int id) => todoDao.deleteTodo(id);
}