# weather5

### SQFlite

에러가 엄청나게 발생했다.

> Unhandled Exception: DatabaseException(no such table: settings (code 1 SQLITE_ERROR)

<br>

먼저 no such table 에러가 계속 발생했다. db 파일을 생성하고 그 안에 settings 테이블을 생성하고 select를 통해 빈 테이블을 조회하려 했는데 잘 되지 않았다. 생성한 db 파일에서 table이 조회가 안되는 것인데 왜 table을 찾을 수 없는지는 아직 잘 모르겠다. 에뮬레이터로 실행시킨다면 생성한 db 파일은 에뮬레이터의 저장공간에 저장된다. 

VS Code로 작업을 진행하다가 VS Code 에서는 device file 에 접근하는 방식을 알지 못했다. 안드로이드 스튜디오의 device explorer를 통해 db 파일을 삭제하고 안드로이드 스튜디오를 껐다가 켠 후 재실행하니 no such table 에러는 발생하지 않았다.

이후에는 Unhandled Exception: type 'QueryResultSet' is not a subtype of type 'FutureOr<String>' 에러가 발생했다.

```dart
  Future<Database> getBackground() async {
    final data = await _database;
    // return await data.execute(
    //   "SELECT * FROM settings",
    // );
    // return await data.query('settings');
    print("getBackground");
    print(data);
    return await data.rawQuery('SELECT * FROM settings');
  }
```

<br>

자료형이 맞지 않아서 발생한 에러였다. query 문 수행후 반환되는 자료형은 QueryResultSet 인데 함수에는 Database로 작성해서 불일치로 인한 에러였다. 그러나 Future<QueryResultSet>은 되지 않아서 그냥 Future로 적용하니 해결됐다.

<br>

```dart
  Future getBackground() async {
    final data = await _database;
    // return await data.execute(
    //   "SELECT * FROM settings",
    // );
    // return await data.query('settings');
    print("getBackground");
    print(data);
    return await data.rawQuery('SELECT * FROM settings');
  }
```



<br>

https://docs.flutter.dev/cookbook/persistence/sqlite

https://github.com/tekartik/sqflite/blob/master/sqflite/doc/opening_db.md

https://codedragon.tistory.com/7850

https://nuggy875.tistory.com/28

