import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../bindings/bamboo_binding.dart';
import './ui/home.dart';
import './ui/bamboo.dart';
import './ui/like.dart';

void main() {
  runApp(
    GetMaterialApp(
      initialRoute: '/home',
      defaultTransition: Transition.native,
      getPages: [
        GetPage(
          name: '/home', 
          page: () => Home(),
          binding: BambooBinding()
        ),
        GetPage(
          name: '/bamboo', 
          page: () => Bamboo(),
          // binding: BambooBinding()
        ),
        GetPage(
          name: '/like',
          page: () => Like(),
          // binding: BambooBinding()
        ),
      ],
      theme: ThemeData(
        fontFamily: 'outfit',
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'outfit',
            fontSize: 15,
          ) 
        ),
      ),
    )
  );
}
