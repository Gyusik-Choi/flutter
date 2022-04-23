import 'package:flutter/material.dart';
import 'package:todo_1/database/database.dart';
import 'package:todo_1/ui/home.dart';

Future<void> main() async {
  // https://stackoverflow.com/questions/63873338/what-does-widgetsflutterbinding-ensureinitialized-do
  // https://changjoopark.medium.com/flutter-main-%EB%A9%94%EC%86%8C%EB%93%9C%EC%97%90%EC%84%9C-%EB%B9%84%EB%8F%99%EA%B8%B0-%EB%A9%94%EC%86%8C%EB%93%9C-%EC%82%AC%EC%9A%A9%EC%8B%9C-%EB%B0%98%EB%93%9C%EC%8B%9C-%EC%B6%94%EA%B0%80%ED%95%B4%EC%95%BC%ED%95%98%EB%8A%94-%ED%95%9C%EC%A4%84-728705061375
  WidgetsFlutterBinding.ensureInitialized();

  DatabaseProvider databaseProvider = DatabaseProvider();
  await databaseProvider.openDB();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}