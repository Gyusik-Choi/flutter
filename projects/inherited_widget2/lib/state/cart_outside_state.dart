import 'package:flutter/material.dart';
import 'package:inherited_widget2/state/cart_outside_state_ful.dart';

class CartOutsideState extends InheritedWidget {
  final CartOutsideStatefulState data;

  const CartOutsideState({Key? key, required this.data, required Widget child}) : super(key: key, child: child);
  
  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}