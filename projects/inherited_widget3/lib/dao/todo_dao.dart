// ignore_for_file: use_rethrow_when_possible
import 'package:inherited_widget3/database/database.dart';
import 'package:inherited_widget3/model/todo.dart';
import 'package:sqflite/sqflite.dart';

class TodoDao {
  final DatabaseProvider _databaseProvider = DatabaseProvider();

  Future<List<Todo>> getAllTodos() async {
    final Database db = await _databaseProvider.database;

    try {
      List<dynamic> result = await db.query(
        'Todo'
      );

      List<Todo> todos = result.map((item) => Todo.fromMap(item)).toList();

      return todos;
    } catch (err) {
      throw (err);
    }   
  }

  Future<int> createTodo(Todo todo) async {
    final Database db = await _databaseProvider.database;

    try {
      int result = await db.insert(
        'Todo',
        todo.toMap(),
      );

      return result;
    } catch (err) {
      throw (err);
    }
  }

  Future<int> updateTodo(Todo todo) async {
    final Database db = await _databaseProvider.database;

    try {
      int result = await db.transaction((txn) async {
        int txnResult = await txn.update(
          'Todo',
          todo.toMap(),
          where: 'id = ?',
          whereArgs: [todo.id],
          conflictAlgorithm: ConflictAlgorithm.rollback,
        );

        return txnResult;
      });

      return result;
    } catch (err) {
      throw (err);
    }
  }

  Future<int> deleteTodo(int id) async {
    final Database db = await _databaseProvider.database;

    try {
      int result = await db.delete(
        'Todo',
        where: 'id = ?',
        // whereArgs: ['$id'],
        whereArgs: [id],
      );

      return result;
    } catch (err) {
      throw (err);
    }
  }
}