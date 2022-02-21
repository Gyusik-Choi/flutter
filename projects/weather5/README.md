# weather5

### 개요

위치 기반으로 현재 날씨를 나타낼 수 있고, 사진첩의 이미지를 배경화면으로 설정할 수 있는 날씨 앱

<br>

### location

Flutter의 Location 플러그인에서 제공해주는 위치 정보 조회에 대한 권한 설정 코드는 갤럭시 S8에서는 잘 동작했으나 S10에서 제대로 동작하지 않았다.

S10에서는 권한 허용 창이 뜨지 않아서 위치를 받아오지 못하는 문제가 발생했다. AndroidManifest 쪽의 설정 문제인가 생각을 처음에 했으나 이 부분에 대한 수정으로는 해결 되지 않았다.

그래서 permission_handler 플러그인에서 제공하는 권한 설정 코드로 변환해서 해결할 수 있었다.

<br>

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

### SharedPreference

SQFlite 처럼 기기 내부에 데이터를 저장할 수 있다. 

SQFlite 같은 RDBMS가 아니라서 key, value 형태로만 저장할 수 있는 차이가 있다.

key, value 형태로 관리하다 보니 DB 보다 간편하게 데이터를 조회하고 저장할 수 있다.

SQFlite 에서는 이미지가 약 2.5MB를 넘어가니 저장이 되지 않아서 SharedPreference로 저장을 시도하니 저장됐다. 물론 저장할 때 이미지 자체를 저장하는 것은 아니다.

이미지를 담은 File 객체를 byte 형태로 변환(File 클래스의 readAsByteSync 메서드 이용)하고 이를 다시 base64String으로 변환한 문자열 정보를 저장한다.

<br>

참고

https://docs.flutter.dev/cookbook/persistence/sqlite

https://github.com/tekartik/sqflite/blob/master/sqflite/doc/opening_db.md

https://codedragon.tistory.com/7850

https://nuggy875.tistory.com/28

