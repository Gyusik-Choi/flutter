import 'package:flutter/material.dart';
import 'package:inherited_widget3/dao/todo_dao.dart';
import 'package:inherited_widget3/database/database.dart';
import 'package:inherited_widget3/repository/todo_repository.dart';
import 'package:inherited_widget3/state/todo_stateful.dart';
import 'package:inherited_widget3/ui/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  DatabaseProvider databaseProvider = DatabaseProvider();
  await databaseProvider.openDB();

  // https://medium.com/flutter-community/dependency-injection-in-flutter-with-inheritedwidget-b48ca63e823
  // MyApp 안에서 직접 TodoStateful 로 MaterialApp 을 감싸는 방법 대신에
  // 여기서 TodoStateful 로 MyApp 을 감싸는 방식으로 수정
  // 그리고 MyApp 에서 Home 에 TodoStatefulState 를 주입
  TodoStateful todoStateful = TodoStateful(todoRepository: TodoRepository(TodoDao()), child: const MyApp());

  runApp(todoStateful);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return TodoStateful(
    //   todoRepository: TodoRepository(TodoDao()),
    //   child: const MaterialApp(
    //     home: Home(),
    //   ),
    // );

    // 위의 방식에서 아래 방식으로 수정
    // home 에 state 를 주입
    TodoStatefulState? state = TodoStateful.of(context);

    return MaterialApp(
      home: Home(state: state),
    );
  }
}