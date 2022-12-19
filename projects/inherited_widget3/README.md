# inherited_widget3

### 주제

[bloc 패턴을 적용한 todo 앱](https://vaygeth.medium.com/reactive-flutter-todo-app-using-bloc-design-pattern-b71e2434f692)을 stream 대신에 inherited widget 을 사용하여 구현했다.

<br>

### 구현 사항

#### Dependency Injection

기존의 코드는 MyApp 안에서 TodoStateful, MaterialApp, Home 의 관계를 설정했다.

```dart
Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TodoStateful(
      todoRepository: TodoRepository(TodoDao()),
      child: const MaterialApp(
        home: Home(),
      ),
    );
  }
}
```

<br>

이때 Home 에 TodoStatefulState 를 주입하려면 아래와 같이 주입을 해줄 수 있다.

```dart
Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TodoStatefulState? state = TodoStateful.of(context);

    return TodoStateful(
      todoRepository: TodoRepository(TodoDao()),
      child: MaterialApp(
        home: Home(state: state),
      ),
    );
  }
}
```

<br>

MyApp 안에서 여러 위젯들의 관계를 적용하다보니 코드가 점점 길어졌다. 위젯 관계가 더 복잡해질 경우 MyApp 안의 코드가 장황해질 수 있어서 [이 글](https://medium.com/flutter-community/dependency-injection-in-flutter-with-inheritedwidget-b48ca63e823)을 참고하여 아래와 같은 방식으로 코드를 수정했다.

```dart
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  DatabaseProvider databaseProvider = DatabaseProvider();
  await databaseProvider.openDB();

  // https://medium.com/flutter-community/dependency-injection-in-flutter-with-inheritedwidget-b48ca63e823
  // MyApp 안에서 직접 TodoStateful 로 MaterialApp 을 감싸는 방법 대신에
  // 여기서 TodoStateful 로 MyApp 을 감싸는 방식으로 수정
  TodoStateful todoStateful = TodoStateful(
    todoRepository: TodoRepository(TodoDao()), 
    child: const MyApp()
  );

  runApp(todoStateful);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TodoStatefulState? state = TodoStateful.of(context);

    return MaterialApp(
      home: Home(state: state),
    );
  }
}
```

<br>

runApp 을 하는 시점에 TodoStateful 과 MyApp 만 설정해주면서 MyApp 안에서 TodoStateful 로 MaterialApp 을 감싸는 코드를 작성해줄 필요가 없어졌다.

MyApp 에서는 MaterialApp, Home 그리고 Home 에 주입할 TodoStatefulState 를 정의해주면 된다.

<br>

#### FutureBuilder

[원래](https://vaygeth.medium.com/reactive-flutter-todo-app-using-bloc-design-pattern-b71e2434f692) 는 StreamBuilder 로 구현되어 있으나 InheritedWidget 을 StatefulWidget 과 접목하면서 StreamController 를 사용하지 않아 FutureBuilder 를 사용했다.

FutureBuilder 의 future 로 TodoStatefulState 의 todos 배열을 사용하여 todos 배열에 변화가 있을 때 마다 화면에 반영되게 된다.

<br>

<참고>

https://vaygeth.medium.com/reactive-flutter-todo-app-using-bloc-design-pattern-b71e2434f692

https://medium.com/flutter-community/dependency-injection-in-flutter-with-inheritedwidget-b48ca63e823

