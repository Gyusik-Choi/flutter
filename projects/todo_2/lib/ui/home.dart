import 'package:flutter/material.dart';
import 'package:todo_2/bloc/todo_bloc.dart';

import 'add_todo.dart';
import 'get_todos.dart';

class Home extends StatelessWidget {
  final TodoBloc _todoBloc = TodoBloc();

  Home({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // https://nurozkaya.medium.com/keyboard-pushes-the-content-up-resizes-the-screen-problem-in-flutter-59188a19324a
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            IconButton(
              icon: const Icon(
                Icons.toggle_off,
              ),
              onPressed: () {

              },
            )
          ],
        ),
        body: getTodos(_todoBloc),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await addTodo(context, _todoBloc);
          },
          backgroundColor: Colors.white,
          child: const Icon(
            Icons.add,
            color: Colors.indigoAccent,
          )
        ),
      )
    );
  }
}