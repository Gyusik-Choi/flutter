import 'package:sqflite/sqflite.dart';
import 'package:todo_2/database/database.dart';
import 'package:todo_2/model/todo.dart';

class TodoDao {
  Future<dynamic> createTodo(Todo todo) async {
    final DatabaseProvider _databaseProvider = DatabaseProvider();
    final Database _db = await _databaseProvider.database;

    try {
      int result = await _db.insert(
        'Todo',
        todo.toMap(),
      );

      return result;
    } catch (err) {
      return err;
    }
  }
}