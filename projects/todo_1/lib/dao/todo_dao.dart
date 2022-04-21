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
        result = await db.query(
          'Todo',
          columns: columns,
          where: 'description LIKE ?',
          whereArgs: ["%$query%"]
        );
      }
    } else {
      result = await db.query('Todo', columns: columns);
    }

    if (result.isNotEmpty) {
      List<Todo> todos = result.map((item) => Todo.fromJson(item)).toList();
      return todos;
    }

    return [];
  }
}