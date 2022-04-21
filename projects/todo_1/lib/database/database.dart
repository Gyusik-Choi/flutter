import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseProvider {
  late Database _database;

  static final DatabaseProvider _databaseProvider = DatabaseProvider._internal();
  DatabaseProvider._internal();

  factory DatabaseProvider() => _databaseProvider;

  Future<void> openDB() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'todo.db');

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: initDB,
      onUpgrade: onUpgrade,
    );
  }

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }

    _database = await createDatabase();
    return _database;
  }

  Future<Database> createDatabase() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'todo.db');

    Database database = await openDatabase(
      path,
      version: 1,
      onCreate: initDB,
      onUpgrade: onUpgrade,
    );

    return database;
  }

  Future<void> initDB(Database db, int version) async {
    await db.execute(
      'CREATE TABLE Todo'
      '('
        'id INTEGER PRIMARY KEY AUTOINCREMENT, '
        'description TEXT, '
        'is_done INTEGER'
      ')'
    );
  }

  Future<void> onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < newVersion) {

    }
  }
}
