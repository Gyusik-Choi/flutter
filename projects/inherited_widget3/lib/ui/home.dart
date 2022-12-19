import 'package:flutter/material.dart';
import 'package:inherited_widget3/model/todo.dart';
import 'package:inherited_widget3/state/todo_stateful.dart';
import 'package:inherited_widget3/ui/add_todo.dart';
import 'package:inherited_widget3/ui/get_todos.dart';

class Home extends StatefulWidget {
  final TodoStatefulState? state;
  const Home({Key? key, required this.state}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TodoStatefulState? state;
  List<Todo> todos = [];

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    state = widget.state;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // https://nurozkaya.medium.com/keyboard-pushes-the-content-up-resizes-the-screen-problem-in-flutter-59188a19324a
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: getTodos(state!),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await addTodo(context, state!);
        },
        backgroundColor: Colors.white,
        child: const Icon(
          Icons.add,
          color: Colors.indigoAccent,
        )
      ),
    );
  }
}