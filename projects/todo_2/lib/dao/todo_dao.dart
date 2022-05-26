import 'package:sqflite/sqflite.dart';
import 'package:todo_2/database/database.dart';
import 'package:todo_2/model/todo.dart';

class TodoDao {
  final DatabaseProvider _databaseProvider = DatabaseProvider();

  Future<List<dynamic>> getAllTodos() async {
    final Database _db = await _databaseProvider.database;

    try {
      List<dynamic> result = await _db.query(
        'Todo'
      );

      if (result.isEmpty) {
        return [null, []];
      }

      List<Todo> todos = result.map((item) => Todo.fromMap(item)).toList();

      return [null, todos];
    } catch (err) {
      return [err, null];
    }   
  }

  Future<dynamic> createTodo(Todo todo) async {
    final Database _db = await _databaseProvider.database;

    try {
      int result = await _db.insert(
        'Todo',
        todo.toMap(),
      );

      return [null, result];
    } catch (err) {
      return [err, null];
    }
  }

  Future<List<dynamic>> updateTodo(Todo todo) async {
    final Database _db = await _databaseProvider.database;

    try {
      int result = await _db.transaction((txn) async {
        int txnResult = await txn.update(
          'Todo',
          todo.toMap(),
          where: 'id = ?',
          whereArgs: [todo.id],
          conflictAlgorithm: ConflictAlgorithm.rollback,
        );

        return txnResult;
      });

      return [null, result];
    } catch (err) {
      return [err, null];
    }
  }

  Future<List<dynamic>> deleteTodo(int id) async {
    final Database _db = await _databaseProvider.database;

    try {
      int result = await _db.delete(
        'Todo',
        where: 'id = ?',
        // whereArgs: ['$id'],
        whereArgs: [id],
      );

      return [null, result];
    } catch (err) {
      return [err, null];
    }
  }
}