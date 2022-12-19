import 'package:flutter/material.dart';
import 'package:inherited_widget3/state/todo_stateful.dart';

class TodoState extends InheritedWidget {
  final TodoStatefulState data;
  
  const TodoState({Key? key, required this.data, required Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
  
}