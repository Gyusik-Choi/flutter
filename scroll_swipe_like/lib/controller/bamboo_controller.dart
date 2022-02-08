import 'package:get/get.dart';
import '../data/repository/bamboo_repository.dart';

class BambooController extends GetxController {
  final BambooRepository bambooRepository;

  BambooController(this.bambooRepository);

  final RxInt _pageNumber = 0.obs;
  RxList<dynamic> posts = [].obs;
  RxList<int> postsLike = <int>[].obs;
  RxBool canLoadMore = true.obs;
  RxBool isLoading = true.obs;

  int get pageNumber => _pageNumber.value;

  @override
  Future<void> onInit() async {
    await getPosts();
    super.onInit();
  }

  Future<void> getPosts() async {
    _pageNumber.value = _pageNumber.value + 1;
    
    isLoading.value = true;

    await Future.delayed(const Duration(milliseconds: 1000));
    List<dynamic> postItems = await bambooRepository.getPosts(pageNumber);
    for (dynamic post in postItems) {
      posts.add(post);
    }

    isLoading.value = false;

    if (_pageNumber.value >= 5) {
      canLoadMore.value = false;
    }
  }

  isSelected(int id) {
    posts[id - 1].selected = !posts[id - 1].selected;
    // Rx 변수로 선언하지 않았기 때문에
    // Obx 로 관찰될 수 없어서 refresh 로 setState 와 같은 동작을 실행시켜서
    // 화면을 새롭게 그릴 수 있도록 한다
    posts.refresh();
  }

  likePost(int idNumber) {
    postsLike.add(idNumber);
    postsLike.sort();
  }

  unLikePost(int idNumber) {
    postsLike.remove(idNumber);
    postsLike.sort();
  }

}