import 'package:flutter/material.dart';
import 'package:inherited_widget3/abstract/todo_abstract.dart';
import 'package:inherited_widget3/model/todo.dart';
import 'package:inherited_widget3/state/todo_state.dart';

class TodoStateful extends StatefulWidget {
  final TodoAbstract todoRepository;
  final Widget child;

  const TodoStateful({Key? key, required this.todoRepository, required this.child}) : super(key: key);

  static TodoStatefulState? of(BuildContext context) => context.dependOnInheritedWidgetOfExactType<TodoState>()?.data;

  @override
  State<TodoStateful> createState() => TodoStatefulState();
}

class TodoStatefulState extends State<TodoStateful> {
  List<Todo> todoItems = [];

  Future<List<Todo>> get todos async {
    List<Todo> tempTodoItems = await getAllTodos();

    setState(() {
      todoItems = tempTodoItems;
    });

    return todoItems;
  }

  Future<List<Todo>> getAllTodos() async {
    List<Todo> tempTodoItems = await widget.todoRepository.getAllTodos();

    setState(() {
      todoItems = tempTodoItems;
    });

    return todoItems;
  }

  Future<void> addTodo(Todo todo) async {
    await widget.todoRepository.insertTodo(todo);
    await getAllTodos();
  }

  Future<void> updateTodo(Todo todo) async {
    await widget.todoRepository.updateTodo(todo);
    await getAllTodos();
  }

  Future<void> deleteTodo(int id) async {
    await widget.todoRepository.deleteTodo(id);
    await getAllTodos();
  }

  @override
  Widget build(BuildContext context) {
    return TodoState(
      data: this,
      child: widget.child,
    );
  }
}