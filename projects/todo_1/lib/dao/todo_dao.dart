import 'package:sqflite/sqflite.dart';
import 'package:todo_1/database/database.dart';
import 'package:todo_1/model/todo.dart';

class TodoDao {
  final DatabaseProvider dbProvider = DatabaseProvider();

  Future<dynamic> createTodo(Todo todo) async {
    Database db = await dbProvider.database;

    try {
      int result = await db.insert(
        'Todo',
        todo.toMap()
      );
      return result;
    } catch (e) {
      return e;
    }
  }

  Future<dynamic> getTodos({List<String>? columns, String? query}) async {
    Database db = await dbProvider.database;

    List<Map<String, dynamic>> result = [];

    if (query != null) {
      if (query.isNotEmpty) {
        try {
          result = await db.query(
            'Todo',
            columns: columns,
            where: 'description LIKE ?',
            whereArgs: ["%$query%"]
          );
        } catch (e) {
          return e;
        }
      }
    } else {
      result = await db.query('Todo', columns: columns);
    }

    if (result.isNotEmpty) {
      print('todo_dao');
      print(result);
      List<Todo> todos = result.map((item) => Todo.fromJson(item)).toList();
      print('todo_dao after fromJson');
      print(todos[0].isDone);
      return todos;
    }

    return [];
  }

  Future<dynamic> updateTodo(Todo todo) async {
    Database db = await dbProvider.database;
    print('updateTodo');
    print(todo.isDone);
    try {
      int result = await db.update(
        'Todo',
        todo.toMap(),
        where: "id = ?",
        whereArgs: [todo.id],
      );

      return result;
    } catch (e) {
      return e;
    }

  }

  Future<dynamic> deleteTodo(int id) async {
    Database db = await dbProvider.database;

    try {
      int result = await db.delete(
        'Todo',
        where: 'id = ?',
        whereArgs: [id],
      );
      return result;
    } catch (e) {
      return e;
    }
  }
}