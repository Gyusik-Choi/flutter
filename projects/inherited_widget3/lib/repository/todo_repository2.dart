import 'package:inherited_widget3/abstract/todo_abstract.dart';
import 'package:inherited_widget3/dao/todo_dao.dart';
import 'package:inherited_widget3/model/todo.dart';

class TodoRepository2 implements TodoAbstract {
  final TodoDao todoDao;

  TodoRepository2(this.todoDao);

  @override
  Future<List<Todo>> getAllTodos() async {
    return await todoDao.getAllTodos();
  }

  @override
  Future<int> insertTodo(Todo todo) async {
    return await todoDao.createTodo(todo);
  }

  @override
  Future<int> updateTodo(Todo todo) async {
    return await todoDao.updateTodo(todo);
  }

  @override
  Future<int> deleteTodo(int id) async {
    return await todoDao.deleteTodo(id);
  }
}