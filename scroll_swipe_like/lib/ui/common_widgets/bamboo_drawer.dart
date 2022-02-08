import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BambooDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('대나무숲'),
          ),
          ListTile(
            title: const Text('내가쓴글'),
            onTap: () => Get.toNamed('/like'),
          )
        ],
      )
    );
  }
}
