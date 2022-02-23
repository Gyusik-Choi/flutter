import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import './counter_observer.dart';
import './app.dart';

void main() {
  BlocOverrides.runZoned(
    () => runApp(const CounterApp()),
    blocObserver: CounterObserver(),
  );
}
