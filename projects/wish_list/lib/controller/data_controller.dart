import 'package:get/get.dart';
import '../data/model/model.dart';
import '../data/repository/posts_repository.dart';

class DataController extends GetxController {
  // final RxList posts = <dynamic>[].obs;
  // final PostsRepository postsRepository = PostsRepository();
  // final RxInt pageNumber = 0.obs;
  // final RxInt limitPageNumber = 5.obs;
  // final RxBool canLoadMore = true.obs;
  // final RxBool isLoading = true.obs;

  RxList posts = <dynamic>[].obs;
  PostsRepository postsRepository = PostsRepository();
  RxInt pageNumber = 0.obs;
  RxInt limitPageNumber = 5.obs;
  RxBool canLoadMore = true.obs;
  RxBool isLoading = true.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await getPosts();
  }

  Future<void> getPosts() async {
    pageNumber += 1;
    print(pageNumber);
    if (pageNumber.toInt() >= limitPageNumber.toInt()) {
      isLoading.value = false;
      canLoadMore.value = false;
      // canLoadMore = RxBool(false);
    } else {
      isLoading.value = false;

      await Future.delayed(const Duration(milliseconds: 1000));

      List<ApiModel> postItems = await postsRepository.getPosts(pageNumber.toInt());
      for (ApiModel postItem in postItems) {
        posts.add(postItem);
      }

      isLoading.value = true;
    }
  }

  void addItem(int idx) {
    posts[idx].selected = true;
    // https://github.com/jonataslaw/getx/issues/314
    // https://here4you.tistory.com/276
    posts.refresh();
  }

  void removeItem(int idx) {
    posts[idx].selected = false;
    // https://github.com/jonataslaw/getx/issues/314
    // https://here4you.tistory.com/276
    posts.refresh();
  }

  List<dynamic> get favoriteItems {
    return posts.where((item) => item.selected == true).toList();
  }
}