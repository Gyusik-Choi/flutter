import 'package:flutter/material.dart';
import '../bloc/todo_bloc.dart';
import '../model/todo.dart';

Widget getTodos(TodoBloc bloc) {
  return StreamBuilder(
    stream: bloc.todos,
    builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
      if (snapshot.hasData) {
        if (snapshot.data!.isNotEmpty) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (BuildContext context, int index) {
              Todo todo = snapshot.data![index];
              bool isDone = todo.isDone;
              String description = todo.description;

              return Card(
                child: ListTile(
                  leading: isDone
                    ? const Icon(
                        Icons.done,
                        color: Colors.indigoAccent,
                      )
                    : const Icon(
                        Icons.check_box_outline_blank,
                        color: Colors.tealAccent,
                      ),
                  title: Text(
                    description,
                    style: TextStyle(
                      decoration: isDone
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                    )
                  ),
                )
              );
            },
          );
        } else {
          return const Center(
            child: Text('새로운 Todo 항목을 작성해주세요!'),
          );
        }
      } else {
        bloc.getAllTodos();
        return const Center(child: CircularProgressIndicator());
      }
    },
  );
}