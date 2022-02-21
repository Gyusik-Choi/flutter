# Flutter

## scroll_swipe_like

### 개요

GetX 상태 관리 툴을 기반으로 무한 스크롤, 스와이프 삭제, 좋아요를 누른 글 목록 확인 등의 기능을 구현한 플러터 프로젝트

<br>

### 새롭게 시도해본 것

#### bindings

- GetX 의 세 가지 주요 기능(state management, route management, dependency management) 중 의존성(dependency)을 관리하는 작업을 bindings 폴더로 따로 빼서 진행했다

  - 의존성 관리와 UI의 분리

- put & lazyPut

  - BambooController는 BambooRepository, BambooRepository는 BambooProvider 를 생성자로 주입받게 되는데 이를 bamboo_binding.dart에 정의 한다

    - 이 방법을 사용하지 않으면 Controller를 보통 UI를 그리는 클래스 안에서 생성해야 한다
    - bamboo_binding.dart에 의존성에 대한 정보를 작성하여서 Controller의 생성(과 제거)을 GetX에서 관리해준다
      - UI를 그리는 클래스 코드 안에 put을 사용하지 않고 find 메서드로 생성된 Controller를 선언만 해주면 된다

  - put 예시

    - ```dart
      // bamboo_binding.dart
      
      class BambooBinding implements Bindings {
        @override
        void dependencies() {
          Get.put<BambooController>(
            BambooController(
              BambooRepository(
                BambooProvider(
                )
              )
            )
          );
        }
      }
      ```

      

  - lazyPut 예시

    - ```dart
      // bamboo_binding.dart
      
      class BambooBinding implements Bindings {
        @override
        void dependencies() {
          Get.lazyPut<BambooController>(() {
            return BambooController(
              BambooRepository(
                BambooProvider(
                )
              )
            );
          });
        }
      }
      ```

    

  - put과 lazyPut의 차이

    - ```dart
      void main() {
        runApp(
          GetMaterialApp(
            initialRoute: '/home',
            getPages: [
              GetPage(
                name: '/home', 
                page: () => Home(), 
              ),
              GetPage(
                name: '/bamboo', 
                page: () => Bamboo(),
                binding: BambooBinding()
              ),
              GetPage(
                name: '/like',
                page: () => Like(),
              ),
            ],
          )
        );
      }
      ```

      - /bamboo 페이지에서 bamboo_binding.dart에 작성한 의존성이 실행되도록 코드를 작성한 경우다

        - put, lazyPut 모두 /home 에서는 Controller가 생성되지 않고 /bamboo로 이동하면 Controller가 생성된다

        - ![1](readme\1.PNG)

          

    - ```dart
      void main() {
        runApp(
          GetMaterialApp(
            initialRoute: '/home',
            getPages: [
              GetPage(
                name: '/home', 
                page: () => Home(),
                binding: BambooBinding()
              ),
              GetPage(
                name: '/bamboo', 
                page: () => Bamboo(),
              ),
              GetPage(
                name: '/like',
                page: () => Like(),
              ),
            ],
          )
        );
      }
      ```

      - /home에서 의존성이 생성되도록 작성했다 (Controller를 /home 에서는 사용하지 않는다)
        - put은 /home에서 Controller가 생성된다
        - ![2](readme\2.PNG)
        - lazyPut은 /home에서 Controller가 생성되지 않는다
          - /bamboo에서 Controller가 생성된다
          - ![1](readme\1.PNG)

  

#### 스와이프

- 좋아요를 누른 글 목록 페이지(/like) 에서 스와이프를 통해 좋아요를 취소할 수 있다
- Flutter에서 제공하는 Dismissible Class를 활용해서 구현했다

<br>

### 기능

#### 무한 스크롤

- 글 목록을 무한 스크롤 형태로 보여주며 50개까지만 나타나도록 했다

- jsonplaceholder 사이트에서 API 요청을 통해 한번에 10개씩 받아온다

- canLoadMore(더 불러올 수 있는지 확인), isLoading(불러오는 중인지 확인) 두 가지 주요 변수를 활용한다

- ```dart
    Widget postBody(BambooController _controller) {
      return ListView.builder(
        itemCount: _controller.posts.length,
        itemBuilder: (context, index) {
          int id = _controller.posts[index].id;
          String title = _controller.posts[index].title;
          bool selected = _controller.posts[index].selected;
          
          if (index < _controller.posts.length - 1) {
            return Card(
            );
          // 마지막 index일때
          } else {
    		// 글을 더 불러올 수 있으면 글 불러오기 요청
            if (_controller.canLoadMore == RxBool(true)) {
              _controller.getPosts();
            }
              
    		// 글을 더 불러올 수 있으면서 글을 불러오는 중이면 로딩 표시
            if (_controller.canLoadMore == RxBool(true) && _controller.isLoading == RxBool(true)) {
              return const Center(
                child: CircularProgressIndicator()
              );
           // 그렇지 않으면 50개를 모두 불러왔으므로 마지막임을 나타냄
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
  ```

- 처음에 10개를 Controller가 생성되는 최초 시점(onInit 함수)에 불러온다

- ```dart
  class BambooController extends GetxController {
    @override
    Future<void> onInit() async {
      await getPosts();
      super.onInit();
    }
  }
  ```

- 새로 10개를 불러오는 동안 CircularProgressIndicator로 로딩 화면을 표시하게 되고 1초의 지연을 준다

- ```dart
  class BambooController extends GetxController {
    int get pageNumber => _pageNumber.value;
      
    Future<void> getPosts() async {
  	// _pageNumber를 1씩 올려준다
      _pageNumber.value = _pageNumber.value + 1;
        // isLoading 상태를 true로 만들고
      isLoading.value = true;
        
        // 1초 지연 시킨다
      await Future.delayed(const Duration(milliseconds: 1000));
        
      List<dynamic> postItems = await bambooRepository.getPosts(pageNumber);
      for (dynamic post in postItems) {
        posts.add(post);
      }
  	// 글을 모두 받아오면 isLoading 상태를 false로 변경
      isLoading.value = false;
  
        // _pageNumber가 5이상이면 글이 50개까지 이미 불러왔으므로 canLoadMore을 false로 바꾼다
        // canLoadMore가 false가 됐으므로 더 이상 getPosts 함수를 UI 쪽에서 호출하지 않는다
      if (_pageNumber.value >= 5) {
        canLoadMore.value = false;
      }
    }
      
  }
  ```

<br>

#### 스와이프

- Dismissible Class

  - 스와이프의 오른쪽에서 왼쪽으로만 동작하도록 설정

  - ```dart
    DismissDirection dismissDirectionEndToStart = DismissDirection.endToStart;
    return Dismissible(
        direction: dismissDirectionEndToStart,
    );
    ```

    - endToStart(오른쪽에서 왼쪽 방향) 방향을 갖는 DismissDirection 클래스의 인스턴스 dismissDirectionEndToStart를 만들어서 direction 프로퍼티에 지정해준다

    <br>

  - 스와이프를 했을 때 바로 삭제하지 않고 확인창을 띄워 사용자가 한번 더 확인하도록 한다

  - ![5](readme\5.PNG)

  - ```dart
    return Dismissible(
        direction: dismissDirectionEndToStart,
        // https://velog.io/@kjha2142/Flutter-Dismissible-Widget
        confirmDismiss: (direction) {
            return showDialog(
                context: context,
                builder: (context) {
                    return AlertDialog(
                        title: const Text(
                            '삭제하시겠습니까?',
                        ),
                        actions: <Widget>[
                            ElevatedButton(
                                onPressed: () {
                                    return Navigator.of(context).pop(true);
                                },
                                child: const Text(
                                    '삭제',
                                ),
                            ),
                            ElevatedButton(
                                onPressed: () {
                                    return Navigator.of(context).pop(false);
                                },
                                child: const Text(
                                    '취소',
                                ),
                            ),
                        ],
                    );
                }
            );
        },
    );
    ```

    - confirmDismiss 프로퍼티에서 삭제가 이루어질 때 어떤 동작을 수행하도록 설정할 수 있다

      - showDialog 위젯에서 AlertDialog 위젯을 생성하여 사용자에게 정말로 삭제할 것인지를 묻는다

    <br>

  - 스와이프의 디자인을 설정할 수 있다

  - ```dart
    return Dismissible(
        key: UniqueKey(),
        background: Card(
            color: Colors.red,
            child: ListTile(
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
        ),
    );
    ```

    - background 프로퍼티에 스와이프 디자인을 설정한다
      - Card 위젯의 배경을 빨간색으로 했고, Card 위젯의 우측 끝에 휴지통 아이콘을 넣으려고 trailing 프로퍼티에 IconButton 위젯을 넣어주었다
      - (Card 위젯으로 한 이유는 좋아요 글 목록이 Card 위젯으로 되어 있어서 이와 비슷한 형태를 유지하려고 Card 위젯으로 background를 설정했다)

<br>

#### 좋아요

- 글 목록에서 좋아요를 누를 수 있고, 좋아요를 누른 글만 목록으로 확인할 수 있는 페이지가 별도로 존재

- getx controller

- ```dart
  // bamboo_controller.dart
  class BambooController extends GetxController {
      // 글 목록
    RxList<dynamic> posts = [].obs;
      // 좋아요를 누른 글 id(글 목록 배열의 인덱스 아님)(글 마다 id 속성을 가지고 있음 1~50까지)
    RxList<int> postsLike = <int>[].obs;
  
    isSelected(int id) {
        // 글 목록의 인덱스 보다 글 id가 1씩 더 크다(0번 인덱스 글은 id가 1)
      posts[id - 1].selected = !posts[id - 1].selected;
        // Rx 변수로 선언하지 않았기 때문에
        // Obx 로 관찰될 수 없어서 refresh 로 setState 와 같은 동작을 실행시켜서
        // 화면을 새롭게 그릴 수 있도록 한다
      posts.refresh();
    }
      
      // postsLike 배열에 좋아요 누른 글의 id 저장하고 순서대로 정렬
    likePost(int idNumber) {
      postsLike.add(idNumber);
      postsLike.sort();
    }
      // postsLike 배열에서 좋아요 취소한 글의 id 제거하고 순서대로 정렬
    unLikePost(int idNumber) {
      postsLike.remove(idNumber);
      postsLike.sort();
    }
  
  }
  ```

  <br>

- 글 목록

- ![3](readme\3.PNG)

- ```dart
  // bamboo.dart
  
  Widget postBody(BambooController _controller) {
      return ListView.builder(
          itemCount: _controller.posts.length,
          itemBuilder: (context, index) {
              int id = _controller.posts[index].id;
              String title = _controller.posts[index].title;
              bool selected = _controller.posts[index].selected;
          
              return Card(
                  child: ListTile(
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
                      ),
                      minVerticalPadding: 12,
                  )
              );
        	}
      );
  }
  
  ```

  <br>

- 좋아요 목록

- ![4](readme\4.PNG)

- ```dart
  // like.dart
  
  class Like extends StatelessWidget {
    final BambooController _bambooController = Get.find<BambooController>();
  
    @override
    Widget build(BuildContext context) {
      return Obx(() =>
        SafeArea(
          child: Scaffold(
            body: ListView.builder(
              itemCount: _bambooController.postsLike.length,
              itemBuilder: (context, index) {
                BambooModel item = _bambooController.posts[_bambooController.postsLike[index] - 1];
                int id = item.id;
                String title = item.title;
                bool selected = item.selected;
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
  ```

- 

<br>

참고

https://pub.dev/packages/get

https://github.com/jonataslaw/getx/blob/master/documentation/en_US/dependency_management.md#getput

https://docs.flutter.dev/cookbook/gestures/dismissible

https://api.flutter.dev/flutter/widgets/Dismissible-class.html

https://stackoverflow.com/questions/52478469/disable-dismiss-direction-on-dismissible-widget

https://stackoverflow.com/questions/55792521/how-to-fix-a-dismissed-dismissible-widget-is-still-part-of-the-tree-error-in

https://velog.io/@kjha2142/Flutter-Dismissible-Widget

https://jsonplaceholder.typicode.com

