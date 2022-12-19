import 'package:inherited_widget3/model/todo.dart';

// https://github.com/dart-lang/language/issues/1393
abstract class TodoAbstract {
  Future getAllTodos();
  Future insertTodo(Todo todo);
  Future updateTodo(Todo todo);
  Future deleteTodo(int id);
}