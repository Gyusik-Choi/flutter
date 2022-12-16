import 'package:flutter/material.dart';
import 'package:inherited_widget2/state/cart_state_ful.dart';

// ignore: must_be_immutable
class CartState extends InheritedWidget {
  final CartStatefulState data;

  const CartState({Key? key, required this.data, required Widget child}) : super(key: key, child: child);
  
  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}