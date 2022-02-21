import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/model/bamboo_model.dart';
import '../controller/bamboo_controller.dart';

// ignore: use_key_in_widget_constructors
class Like extends StatelessWidget {
  final BambooController _bambooController = Get.find<BambooController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() =>
      SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('좋아요',
              style: TextStyle(
                fontFamily: 'outfit',
              )
            ),
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back
              ),
              onPressed: () => Get.back(),
            ),
          ),
          body: ListView.builder(
            itemCount: _bambooController.postsLike.length,
            itemBuilder: (context, index) {
              BambooModel item = _bambooController.posts[_bambooController.postsLike[index] - 1];
              int id = item.id;
              String title = item.title;
              bool selected = item.selected;
              // https://stackoverflow.com/questions/52478469/disable-dismiss-direction-on-dismissible-widget
              DismissDirection dismissDirectionEndToStart = DismissDirection.endToStart;
              return Dismissible(
                // error => A dismissed Dismissible widget is still part of the tree
                // https://stackoverflow.com/questions/55792521/how-to-fix-a-dismissed-dismissible-widget-is-still-part-of-the-tree-error-in
                key: UniqueKey(),
                // 위에서 end to start로 방향을 선언한 변수 dismissDirectionEndToStart를 direction의 value로 설정해서 한쪽 방향으로만 동작하게 함
                direction: dismissDirectionEndToStart,
                onDismissed: (direction) {
                  _bambooController.isSelected(id);
                  _bambooController.unLikePost(id);
                },
                // https://velog.io/@kjha2142/Flutter-Dismissible-Widget
                confirmDismiss: (direction) {
                  return showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text(
                          '삭제하시겠습니까?',
                          style: TextStyle(
                            fontFamily: 'outfit'
                          )
                        ),
                        actions: <Widget>[
                          ElevatedButton(
                            onPressed: () {
                              return Navigator.of(context).pop(true);
                            },
                            child: const Text(
                              '삭제',
                              style: TextStyle(
                                fontFamily: 'outfit'
                              )
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              return Navigator.of(context).pop(false);
                            },
                            child: const Text(
                              '취소',
                              style: TextStyle(
                                fontFamily: 'outfit'
                              )
                            ),
                          ),
                        ],
                      );
                    }
                  );
                },
                background: Card(
                  child: ListTile(
                    // leading 과 title 부분은
                    // trailing 의 icon 위치가 세로축의 중앙에 오도록 하기 위하여
                    // 일부러 Swipe 되는 Card 의 내용과 동일하게 작성하고 (trailing 의 위치는 leading 과 title 의 배치에 영향을 받는다)
                    // Text 의 색깔을
                    // background Card 의 색깔과 동일하게 맞춰 화면에서는 보이지 않도록 했다
                    leading: Text(
                      id.toString(),
                      style: const TextStyle(
                        color: Colors.red,
                      )
                    ),
                    title: Text(
                      title,
                      style: const TextStyle(
                        color: Colors.red,
                      )
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {},
                    ),
                    minVerticalPadding: 12,
                  ),
                  color: Colors.red,
                ),
                child: Card(
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
                        _bambooController.isSelected(id);
              
                        // if (selected == true) {
                        if (_bambooController.posts[id - 1].selected == true) {
                          _bambooController.likePost(id);
                        } else {
                          _bambooController.unLikePost(id);
                        }
                        
                      }
                    ),
                    minVerticalPadding: 12,
                  ),
                ),
              );
            }
          )
        )
      )
    );
  }
}