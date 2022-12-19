import 'package:flutter/material.dart';
import 'package:inherited_widget3/model/todo.dart';
import 'package:inherited_widget3/state/todo_stateful.dart';
import 'package:inherited_widget3/ui/dialog.dart';

Widget getTodos(TodoStatefulState state) {
  return FutureBuilder<List<Todo>>(
    future: state.todos,
    builder: (BuildContext context, AsyncSnapshot<List<Todo>> snapshot) {
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
                onDismissed: (direction) async {
                  await state.deleteTodo(id);
                },
                confirmDismiss: (direction) async {
                  return await deleteDialog(context);
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
                      onPressed: () async {
                        todo.isDone = !todo.isDone;
                        await state.updateTodo(todo);
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
        state.getAllTodos();
        return const Center(child: CircularProgressIndicator());
      }
    },
  );
}