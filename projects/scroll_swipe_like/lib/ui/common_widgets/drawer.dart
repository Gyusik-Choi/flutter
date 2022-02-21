import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('진학고등학교'),
          ),
          ListTile(
            title: const Text('대나무숲'),
            onTap: () => Get.toNamed('/bamboo', arguments: 'Get is the best'),
          )
        ],
      )
    );
  }
}
