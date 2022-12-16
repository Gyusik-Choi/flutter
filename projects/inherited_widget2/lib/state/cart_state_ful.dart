import 'package:flutter/material.dart';
import 'package:inherited_widget2/model/catalog_model.dart';
import 'package:inherited_widget2/state/cart_state.dart';

class CartStateful extends StatefulWidget {
  final Widget child;

  const CartStateful({Key? key, required this.child}) : super(key: key);

  static CartStatefulState? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CartState>()?.data;
  }

  @override
  State<CartStateful> createState() => CartStatefulState();
}

class CartStatefulState extends State<CartStateful> {
  // The private field backing [catalog].
  CatalogModel _catalog = CatalogModel();

  // Internal, private state of the cart. Stores the ids of each item.
  final List<int> _itemIds = [];

  // The current catalog. Used to construct items from numeric ids.
  CatalogModel get catalog => _catalog;

  set catalog(CatalogModel newCatalog) {
    _catalog = newCatalog;
  }

  // List of items in the cart.
  List<Item> get items => _itemIds.map((id) => _catalog.getById(id)).toList();

  // The current total price of all items.
  int get totalPrice => items.fold(0, (total, current) => total + current.price);

  // Adds [item] to cart. This is the only way to modify the cart from outside.
  void add(Item item) {
    // This line tells [Model] that it should rebuild the widgets that
    // depend on it.
    setState(() { _itemIds.add(item.id); });
  }

  void remove(Item item) {
    // Don't forget to tell dependent widgets to rebuild _every time_
    // you change the model.
    setState(() { _itemIds.remove(item.id); });
  }

  @override
  Widget build(BuildContext context) {
    return CartState(
      data: this, 
      child: widget.child,
    );
  }
}