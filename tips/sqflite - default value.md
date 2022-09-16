# sqflite - default value

### Cannot add a NOT NULL column with default value NULL 에러

```
await db.execute(
  'CREATE TABLE User'
  '('
    'MemNo INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, '
    'MemID TEXT NOT NULL, '
    'MemName TEXT DEFAULT "" NOT NULL, '
    'MemGender TEXT DEFAULT "" NOT NULL '
  ')'
);
```

<br>

위의 테이블을 생성한 후에 NOT NULL 인 컬럼을 추가하기 위해 아래의 코드를 실행하면 에러가 발생할 수 있다.

```
await db.execute(
  'ALTER TABLE User '
  'ADD MemNumber TEXT NOT NULL '
);
```

<br>

테이블에 추가할 NOT NULL 인 컬럼에 default value 를 지정해주지 않으면 에러가 발생한다. 아래와 같이 default value 를 지정해주면 에러가 발생하지 않는다.

```
await db.execute(
  'ALTER TABLE User '
  'ADD MemNumber DEFAULT "" TEXT NOT NULL '
);
```

<br>

이 에러는 테이블에 데이터가 있건 없건 발생한다. 즉 설령 테이블에 데이터가 하나도 없더라도 발생하게 된다.

<참고>

<https://stackoverflow.com/questions/3170634/cannot-add-a-not-null-column-with-default-value-null-in-sqlite3>