import 'package:flutter/material.dart';
import 'package:todo_1/bloc/todo_bloc.dart';

class Home extends StatelessWidget {
  final TodoBloc _todoBloc = TodoBloc();
  
  Home({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: getTodosWidget(),
      ) 
    );
  }

  Widget getTodosWidget() {
    return StreamBuilder(
      stream: _todoBloc.todos,
      builder: (BuildContext context, AsyncSnapshot snapShot) {
        if (snapShot.hasData == false) {
          return const Center(
            child: Text('No Todos'),
          );
        }

        return Container();
      }
    );
  }
}