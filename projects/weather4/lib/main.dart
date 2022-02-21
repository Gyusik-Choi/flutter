import 'package:flutter/material.dart';
import 'package:get/get.dart';
import './ui/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: Home(),
      theme: ThemeData(
        fontFamily: 'outfit',
      ),
    );
  }
}