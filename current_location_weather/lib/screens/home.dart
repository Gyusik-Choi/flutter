import 'package:flutter/material.dart';
import 'package:get/get.dart';
import './weather.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.lightBlueAccent,
        body: Center(
          child: TextButton(
            style: TextButton.styleFrom(
              side: const BorderSide(color: Colors.white)
            ),
            onPressed: () { 
              Get.to(() => Weather());
             },
            child: const Text(
              '오늘의 날씨',
              style: TextStyle(
                color: Colors.white,
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      )
    );
  }
}
