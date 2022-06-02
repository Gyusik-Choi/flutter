import 'package:flutter/material.dart';
import '../bloc/todo_bloc.dart';
import '../model/todo.dart';
import 'dialog.dart';

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
              int id = todo.id!;
              bool isDone = todo.isDone;
              String description = todo.description;

              return Dismissible(
                key: ObjectKey(todo.id),
                direction: DismissDirection.endToStart,
                background: const Card(
                  color: Colors.blue,
                  child: ListTile(
                    title: Text(
                      '삭제',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    )
                  ),
                ),
                onDismissed: (direction) {
                  bloc.deleteTodo(id);
                },
                confirmDismiss: (direction) async {
                  return await dialog(context);
                },
                child: Card(
                  child: ListTile(
                    leading: IconButton(
                      icon: isDone
                        ? const Icon(
                            Icons.done,
                            color: Colors.indigoAccent,
                          )
                        : const Icon(
                            Icons.check_box_outline_blank,
                            color: Colors.tealAccent,
                          ),
                      onPressed: () {
                        todo.isDone = !todo.isDone;
                        bloc.updateTodo(todo);
                      },
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
                ),
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