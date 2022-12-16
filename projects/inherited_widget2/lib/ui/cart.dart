import 'package:flutter/material.dart';
import 'package:inherited_widget2/model/catalog_model.dart';
import 'package:inherited_widget2/state/cart_state_ful.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.yellow,
        child: Column(
          children: const [
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(32),
                child: _CartList(),
              ),
            ),
            Divider(height: 4, color: Colors.black),
          ],
        ),
      ),
    );
  }
}

class _CartList extends StatefulWidget {
  const _CartList({Key? key}) : super(key: key);

  @override
  State<_CartList> createState() => __CartListState();
}

class __CartListState extends State<_CartList> {
  List<Item> cart = [];
  TextStyle? itemNameStyle;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    CartStatefulState? data = CartStateful.of(context);
    cart = data!.items;
  }

  @override
  Widget build(BuildContext context) {
    var itemNameStyle = Theme.of(context).textTheme.titleLarge;
    // var cart = CartStateful.of(context)!.items;

    return ListView.builder(
      itemCount: cart.length,
      itemBuilder: (context, index) => ListTile(
        leading: const Icon(Icons.done),
        trailing: IconButton(
          icon: const Icon(Icons.remove_circle_outline),
          onPressed: () {
            CartStateful.of(context)!.remove(cart[index]);
          },
        ),
        title: Text(
          cart[index].name,
          style: itemNameStyle,
        ),
      ),
    );
  }
}