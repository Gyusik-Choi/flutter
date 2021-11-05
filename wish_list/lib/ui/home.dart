import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/model/model.dart';
import '../controller/data_controller.dart';
import './wish.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final DataController _d = Get.put(DataController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Word List'),
          centerTitle: true,
          actions: <IconButton>[
            IconButton(
              icon: const Icon(
                Icons.shopping_cart,
              ),
              onPressed: () {
                Get.to(() => WishList());
              },
            ),
          ],
        ),
        body: Obx(() =>
          _d.posts.isNotEmpty
            ? homeBody(context)
            : const Center(
              child: CircularProgressIndicator(
              )
          )
        ),
      )
    );
  }

  Widget homeBody(BuildContext context) {
    return ListView.builder(
      itemCount: _d.posts.length.toInt(),
      itemBuilder: (context, index) {
        ApiModel item = _d.posts[index];
        String title = item.title;
        String body = item.body;
        int id = item.id;
        bool selected = item.selected;

        if (index < _d.posts.length - 1) {
          return Card(
            child: ListTile(
              leading: IconButton(
                icon: Icon(
                  Icons.favorite,
                  color: selected ? Colors.pink : Colors.grey,
                  // color: Colors.grey,
                ),
                onPressed: () {
                  if (item.selected == false) {
                    _d.addItem(id - 1);
                  } else {
                    _d.removeItem(id - 1);
                  }
                }
                // 여기서 상태 변경하는게 아니다
                // controller 에서 변경하도록 할 것
                // onPressed: () {
                //   selected = !selected;
                //   print(selected);
                // },
              ),
              title: Text(
                title
              ),
              subtitle: Text(
                body
              ),
            ),
          );
        } else {
          if (_d.canLoadMore == RxBool(true)) {
            _d.getPosts();
          }

          if (_d.isLoading == RxBool(false) && _d.canLoadMore == RxBool(false)) {
            return const ListTile(
              title: Center(
                child: Text(
                  '끝'
                ),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        }
      },
    );
  }
}