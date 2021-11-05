import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wish_list1/controller/data_controller.dart';
import 'package:wish_list1/data/model/model.dart';

class WishList extends StatelessWidget {
  final DataController _d = Get.find<DataController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite'),
        centerTitle: true,
      ),
      body: Obx(() =>
        ListView.builder(
          itemCount: _d.favoriteItems.length,
          itemBuilder: (context, index) {
            ApiModel item = _d.favoriteItems[index];
            int id = item.id;
            String title = item.title;

            return Card(
              child: ListTile(
                title: Text(
                    title
                ),
                trailing: IconButton(
                  icon: const Icon(
                    Icons.close
                  ),
                  onPressed: () {
                    _d.removeItem(id - 1);
                    _d.favoriteItems;
                  },
                ),
              ),
            );
          }
        )
      )
    );
  }
}
