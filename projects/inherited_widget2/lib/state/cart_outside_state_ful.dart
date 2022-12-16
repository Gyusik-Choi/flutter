import 'package:flutter/material.dart';
import 'package:inherited_widget2/state/cart_outside_state.dart';

class CartOutsideStateful extends StatefulWidget {
  final Widget child;

  const CartOutsideStateful({Key? key, required this.child}) : super(key: key);

  static CartOutsideStatefulState? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CartOutsideState>()?.data;
  }

  @override
  State<CartOutsideStateful> createState() => CartOutsideStatefulState();
}

class CartOutsideStatefulState extends State<CartOutsideStateful> {
  final String outside = 'CartOutsideStatefulState';

  @override
  Widget build(BuildContext context) {
    return CartOutsideState(
      data: this,
      child: widget.child,
    );
  }
}