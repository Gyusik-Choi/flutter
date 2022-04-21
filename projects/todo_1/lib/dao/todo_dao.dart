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
}