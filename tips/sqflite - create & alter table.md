# sqflite - create & alter table

### create

마지막 컬럼 생성시 콜론(,) 은 찍지 않아야 한다

```dart
await db.execute(
  'CREATE TABLE User'
  '('
    'MemNo INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, '
    'MemID TEXT NOT NULL, '
  ')'
);
```

<br>

콜론 뒤에 한 칸을 띄우는 것과 관계 없이 에러 발생한다

```dart
await db.execute(
  'CREATE TABLE User'
  '('
    'MemNo INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, '
    'MemID TEXT NOT NULL,'
  ')'
);
```

<br>

```dart
await db.execute(
  'CREATE TABLE User'
  '('
    'MemNo INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, '
    'MemID TEXT NOT NULL'
  ')'
);
```

<br>

콜론을 안 쓰고 한 칸을 띄우는 것은 가능하다

```dart
await db.execute(
  'CREATE TABLE User'
  '('
    'MemNo INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, '
    'MemID TEXT NOT NULL '
  ')'
);
```

<br>

### alter

컬럼 추가할 때 추가하는 마지막 컬럼 코드에 콜론(,)을 찍으면 에러 발생한다

```dart
await db.execute(
  'ALTER TABLE User '
  'ADD MemName TEXT DEFAULT "" NOT NULL, '
);
```

<br>

콜론을 쓰지 않아야 에러 발생하지 않고 정상적으로 수행된다

```dart
await db.execute(
  'ALTER TABLE User '
  'ADD MemName TEXT DEFAULT "" NOT NULL '
);
```

<br>

create 와 마찬가지로 마지막 컬럼 코드의 마지막에 콜론만 없다면 한 칸 띄우고 안 띄우고는 상관없이 가능하다

```
await db.execute(
  'ALTER TABLE User '
  'ADD MemName TEXT DEFAULT "" NOT NULL'
);
```

<br>

<참고>

https://github.com/tekartik/sqflite/blob/master/sqflite/doc/sql.md

