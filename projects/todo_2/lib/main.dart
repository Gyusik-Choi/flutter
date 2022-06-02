import 'package:flutter/material.dart';
import 'package:todo_2/database/database.dart';
import 'package:todo_2/ui/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  DatabaseProvider databaseProvider = DatabaseProvider();
  await databaseProvider.openDB();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
      theme: ThemeData(
        brightness: Brightness.light,
      ),
    );
  }
}