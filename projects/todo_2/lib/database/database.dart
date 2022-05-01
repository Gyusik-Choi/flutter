import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseProvider {
  late Database _db;
  
  static final DatabaseProvider _databaseProvider = DatabaseProvider._internal();
  DatabaseProvider._internal();

  factory DatabaseProvider() => _databaseProvider;

  Future<void> openDB() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'tood.db');

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

  Future<Database> get database async {
    return _db;
  }
}