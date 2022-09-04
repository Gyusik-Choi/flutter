import 'package:flutter/material.dart';
import 'package:sqflite3/database.dart';
import 'home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  DatabaseHelper databaseHelper = DatabaseHelper();
  await databaseHelper.openDB();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}
