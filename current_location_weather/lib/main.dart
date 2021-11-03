import 'package:flutter/material.dart';
import 'package:get/get.dart';
import './screens/home.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      title: 'getX weather',
      home: HomePage(),
    );
  }
}
