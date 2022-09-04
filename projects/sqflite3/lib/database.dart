import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite/utils/utils.dart';

class DatabaseHelper {
  late Database _db;

  DatabaseHelper._internal();

  static final DatabaseHelper _database = DatabaseHelper._internal();

  factory DatabaseHelper() {
    return _database;
  }

  Future<Database> get database async {
    return _db;
  }

  Future<void> openDB() async {
    _db = await openDatabase(
      join(await getDatabasesPath(), 'database.db'),
      version: 3,
      onCreate: (Database db, int version) async {
        print('onCreate');
        print(version);
        await createTable(db);
      },
      onUpgrade: (Database db, int oldVersion, int newVersion) async {
        print('onUpgrade');
        print(oldVersion);
        print(newVersion);
        await upgradeTable(db, oldVersion, newVersion);
      }
    );

    await tableExists(_db, 'Users');
  }

  Future<void> createTable(Database db) async {
    await db.execute(
      'CREATE TABLE User'
      '('
        'MemNo INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, '
        'MemID TEXT NOT NULL, '
        'MemName TEXT DEFAULT "" NOT NULL, '
        'MemGender TEXT DEFAULT "" NOT NULL '
      ')'
    );
  }

  // https://stackoverflow.com/questions/3170634/cannot-add-a-not-null-column-with-default-value-null-in-sqlite3
  // NOT NULL 컬럼 추가를 할 경우 DEFAULT 값을 선언해주지 않으면 에러 발생
  // 테이블에 데이터가 있건 없건 발생한다
  Future<void> upgradeTable(Database db, int oldVersion, int newVersion) async {
    // version 2
    if (oldVersion < 2) {
      await db.execute(
        'ALTER TABLE User '
        'ADD MemName TEXT DEFAULT "" NOT NULL '
        // 'ADD MemName TEXT NOT NULL '
      );
    }

    // version 3
    if (oldVersion < 3) {
      await db.execute(
        'ALTER TABLE User '
        'ADD MemGender TEXT DEFAULT "" NOT NULL '
      );
    }

    // ! 원래는 위의 방법 대신 아래의 방법을 생각했으나 아래의 방법은 위험이 존재한다 !
    // ! oldVersion 1에서 newVersion 3으로 업데이트 할 경우에는 수정할 수 없다 !

    // // version 2
    // if (oldVersion == 1 && newVersion == 2) {
    //   await db.execute(
    //       'ALTER TABLE User '
    //           'ADD MemName TEXT DEFAULT "" NOT NULL '
    //     // 'ADD MemName TEXT NOT NULL '
    //   );
    // }
    //
    // // version 3
    // if (oldVersion == 2 && newVersion == 3) {
    //   await db.execute(
    //       'ALTER TABLE User '
    //           'ADD MemGender TEXT DEFAULT "" NOT NULL '
    //   );
    // }
  }

  Future<bool> tableExists(DatabaseExecutor db, String tableName) async {
    int count = firstIntValue(
      await db.query(
        'sqlite_master',
        columns: [],
        where: 'type = ? AND name = ?',
        whereArgs: ['table', tableName]
      )
    )
    ?? 0;

    return count > 0;
  }

  // column 존재 여부는 이 함수로 판단할 수 없음
  Future<void> columnExists(DatabaseExecutor db, String tableName, String columnName) async {
    // ex> [{type: table, name: User, tbl_name: User, rootpage: 4, sql: CREATE TABLE User(MemNo INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, MemID TEXT NOT NULL)}]
    List result = await db.query(
      'sqlite_master',
      // columns: [columnName],
      where: 'type = ? AND name = ?',
      whereArgs: ['table', tableName]
    );
  }
}