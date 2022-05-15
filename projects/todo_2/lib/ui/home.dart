import 'package:flutter/material.dart';
import 'package:todo_2/bloc/todo_bloc.dart';

class Home extends StatelessWidget {
  final TodoBloc _todoBloc = TodoBloc();

  Home({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ElevatedButton(
          child: const Text('add todo'),
          onPressed: () async {

          },
        )
      )
    );
  }
}