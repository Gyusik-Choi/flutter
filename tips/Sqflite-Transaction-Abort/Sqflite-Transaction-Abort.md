# SQFlite

## transaction

### ConflictAlgorithm

SQFlite 에서 update, insert 의 경우 ConflictAlgorithm 을 설정할 수 있는데, 관련 문서를 읽어보다가 직접 확인해보고 싶어서 간단하게 진행해보았다.

아래의 abort가 [공식 문서](https://github.com/tekartik/sqflite/blob/master/sqflite/doc/conflict_algorithm.md)의 내용이다.

```
abort => When a constraint violation occurs,no ROLLBACK is executed so changes from prior commands within the same transaction are preserved. This is the default behavior.
```

abort 의 경우 제약 조건 위반에 걸렸을때 같은 트랜잭션 안에서 이전에 수행된 명령은 유지가 된다고 한다.

<br>

```dart
Future<void> testAddAndUpdate() async {
	final Database _db = await _databaseProvider.database;

	Todo _todoItem = Todo(description: 'study flutter');
	Todo _todoItem2 = Todo(id: 1, description: 'study dart');

  try {
  	await _db.transaction((txn) async {
  		await txn.insert(
  			'Todo',
  			_todoItem.toMap(),
  		);

  		await txn.insert(
  			'Todo',
  			_todoItem2.toMap(),
    	);
    });
  } catch (err) {
    print(err);
  }
}
```

<br>

```dart
DatabaseException(UNIQUE constraint failed: Todo.id (code 1555 SQLITE_CONSTRAINT_PRIMARYKEY)) sql 'INSERT INTO Todo (id, description, is_done) VALUES (?, ?, ?)' args [1, study dart, 0]
```

<br>

![캡쳐](캡쳐.png)

<br>

하나의 트랜잭션 안에서 빈 Todo 테이블에 _todoItem 을 넣고(정상적으로 들어갔다면 id는 1), 다시 1번 id에 _todoItem2 를 넣으려고 했다. unique constraint failed 에러가 발생했다. 문서 내용을 토대로 상상했던 내용은 _todoItem 이 들어가는 것이었다. 

**그러나** _todoItem 은 들어가지 않았다. 트랜잭션이 잘 동작해서 롤백이 이루어진듯 하다. 문서의 내용을 잘못 이해한 것일 수 있으나 일단 내가 기존에 이해하고 있던 트랜잭션의 방식대로 하나의 트랜잭션 안에서 오류가 발생하면 이전의 내용들이 롤백 되고 있음을 확인할 수 있었다.

<br>

혹시나하여 코드에 직접 conflictAlgorithm: ConflictAlgorithm.abort 를 명시해서 다시 시도해보았으나 결과는 이전과 같았다.

```dart
Future<void> testAddAndUpdate() async {
	final Database _db = await _databaseProvider.database;

	Todo _todoItem = Todo(description: 'study flutter');
	Todo _todoItem2 = Todo(id: 1, description: 'study dart');

  try {
  	await _db.transaction((txn) async {
  		await txn.insert(
  			'Todo',
  			_todoItem.toMap(),
        conflictAlgorithm: ConflictAlgorithm.abort,
  		);

  		await txn.insert(
  			'Todo',
  			_todoItem2.toMap(),
        conflictAlgorithm: ConflictAlgorithm.abort,
    	);
    });
  } catch (err) {
    print(err);
  }
}
```

