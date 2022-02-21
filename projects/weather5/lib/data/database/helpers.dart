import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// https://daldalhanstory.tistory.com/245
// https://docs.flutter.dev/cookbook/persistence/sqlite
// https://velog.io/@jong/Flutter-sqlite-%EC%82%AC%EC%9A%A9%ED%95%98%EA%B8%B0
// https://stackoverflow.com/questions/63103065/flutter-sqflite-databaseexceptionno-such-table-project

class DBHelper {

  // ignore: prefer_typing_uninitialized_variables
  var _database;

  // QueryResultSet 이라는 타입이 리턴되는 실제 형식이라
  // Future<Database> 에서 Future<dynamic>으로 변경
  Future<dynamic> get database async {
    if (_database != null) {
      // await _database.rawQuery('DROP TABLE settings');
      return _database;
    }
    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  Future<dynamic> initDB() async {
    // String path = join(await getDatabasesPath(), "core1.db");

    return await openDatabase(
      join(await getDatabasesPath(), "core1.db"), 
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE settings(id INTEGER PRIMARY KEY AUTOINCREMENT, background TEXT)',
        );
      },
    );
  }

  Future<dynamic> insertBackground(String background) async {
    final data = await _database;
    print("insertBackground");
    // return await data.insert(
    //   'settings',
    //   settings.toMap(),
    //   conflictAlgorithm: ConflictAlgorithm.replace,
    // );
    return await data.rawQuery(
      'INSERT INTO settings(background) VALUES(?)',
      [background]
    );
  }

  Future getBackground() async {
    final data = await _database;
    print("getBackground");

    return await data.rawQuery('SELECT * FROM settings');
  }

  Future deleteBackground() async {
    final data = await _database;
    print("deleteBackground");

    return await data.rawQuery(
      'DELETE FROM settings'
    );
  }
}