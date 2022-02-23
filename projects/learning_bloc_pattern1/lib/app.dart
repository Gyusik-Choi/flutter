import 'package:flutter/material.dart';
import './view/counter_page.dart';

class CounterApp extends MaterialApp {
  const CounterApp({Key? key}) : 
    super(key: key, home: const CounterPage());
}