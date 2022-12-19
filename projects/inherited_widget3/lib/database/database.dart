import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  late Database _db;

  // https://medium.com/flutter-seoul/dart%EC%97%90%EC%84%9C-singleton-pattern%EC%82%AC%EC%9A%A9%ED%95%98%EA%B8%B0-2312616bbb7e
  // 생성자 선언
  DatabaseProvider._internal();
  // 생성자 호출
  static final DatabaseProvider _databaseProvider = DatabaseProvider._internal();

  factory DatabaseProvider() => _databaseProvider;

  Future<Database> get database async => _db;

  Future<void> openDB() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'todo.db');

    _db = await openDatabase(
      path,
      version: 1,
      onCreate: createDB,
    );
  }

  Future<void> createDB(Database db, int version) async {
    await db.execute(
      'CREATE TABLE Todo'
      '('
        'id INTEGER PRIMARY KEY AUTOINCREMENT, '
        'description TEXT, '
        'is_done INTEGER'
      ')'
    );
  }
}