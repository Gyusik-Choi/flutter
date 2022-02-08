import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/bamboo_controller.dart';
import '../ui/common_widgets/bamboo_drawer.dart';

class Bamboo extends StatelessWidget {
  BambooController bambooController = Get.find<BambooController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => 
      SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              '대나무숲',
            ),
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back
              ),
              onPressed: () => Get.back(),
            ),
          ),
          body: bambooController.posts.isNotEmpty ? postBody(bambooController) : const Center(child: CircularProgressIndicator()),
          //https://stackoverflow.com/questions/53300696/how-to-place-drawer-widget-on-the-right
          endDrawer: BambooDrawer(),
        )
      )
    );
  }

  Widget postBody(BambooController _controller) {
    return ListView.builder(
      itemCount: _controller.posts.length,
      itemBuilder: (context, index) {
        int id = _controller.posts[index].id;
        String title = _controller.posts[index].title;
        bool selected = _controller.posts[index].selected;
        
        if (index < _controller.posts.length - 1) {
          return Card(
            child: ListTile(
              leading: Text(
                id.toString()
              ),
              title: Text(
                title
              ),
              trailing: IconButton(
                icon: Icon(
                  Icons.favorite,
                  color: selected ? Colors.red : Colors.grey,
                ),
                onPressed: () {
                  _controller.isSelected(id);

                  if (_controller.posts[id - 1].selected == true) {
                    _controller.likePost(id);
                  } else {
                    _controller.unLikePost(id);
                  }

                }
                // 아래처럼하면 즉시실행으로 동작한다
                // onPressed: _controller.isSelected(index),
              ),
              minVerticalPadding: 12,
            )
          );
        } else {
          if (_controller.canLoadMore == RxBool(true)) {
            _controller.getPosts();
          }

          if (_controller.canLoadMore == RxBool(true) && _controller.isLoading == RxBool(true)) {
            return const Center(
              child: CircularProgressIndicator()
            );
          } else {
            return const ListTile(
              title: Center(
                child: Text(
                  '끝'
                ),
              ),
            );
          }
        }
      }
    );
  }
}
