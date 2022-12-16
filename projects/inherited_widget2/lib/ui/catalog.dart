import 'package:flutter/material.dart';
import 'package:inherited_widget2/model/catalog_model.dart';
import 'package:inherited_widget2/state/cart_outside_state_ful.dart';
import 'package:inherited_widget2/state/cart_state_ful.dart';

class Catalog extends StatefulWidget {
  const Catalog({Key? key}) : super(key: key);

  @override
  State<Catalog> createState() => _CatalogState();
}

class _CatalogState extends State<Catalog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _MyAppBar(),
          const SliverToBoxAdapter(child: SizedBox(height: 12)),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => _MyListItem(index)
            ),
          ),
        ],
      ),
    );
  }
}

class _MyAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print(CartOutsideStateful.of(context)!.outside);

    return SliverAppBar(
      title: const Text('Catalog'),
      centerTitle: true,
      floating: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.shopping_cart),
          onPressed: () => Navigator.pushNamed(context, '/cart'),
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class _MyListItem extends StatefulWidget {
  int idx;

  _MyListItem(this.idx, {Key? key}) : super(key: key);

  @override
  State<_MyListItem> createState() => __MyListItemState();
}

class __MyListItemState extends State<_MyListItem> {
  @override
  Widget build(BuildContext context) {
    Item item = CartStateful.of(context)!.catalog.getByPosition(widget.idx);
    TextStyle? textTheme = Theme.of(context).textTheme.titleLarge;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: LimitedBox(
        maxHeight: 48,
        child: Row(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                color: item.color,
              ),
            ),
            const SizedBox(width: 24),
            Expanded(
              child: Text(item.name, style: textTheme),
            ),
            const SizedBox(width: 24),
            _AddButton(item: item),
          ],
        ),
      ),
    );
  }
}

class _AddButton extends StatelessWidget {
  final Item item;

  const _AddButton({required this.item});

  @override
  Widget build(BuildContext context) {
    bool isInCart = CartStateful.of(context)!.items.contains(item);

    return TextButton(
      onPressed: isInCart
        ? null
        : () { CartStateful.of(context)!.add(item); },
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
          if (states.contains(MaterialState.pressed)) {
            return Theme.of(context).primaryColor;
          }
          return null;
        }),
      ),
      child: isInCart
        ? const Icon(Icons.check, semanticLabel: 'ADDED')
        : const Text('ADD'),
    );
  }
}