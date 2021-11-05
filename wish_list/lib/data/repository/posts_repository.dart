import '../providers/api.dart';

class PostsRepository {
  final ApiProvider apiProvider = ApiProvider();

  getPosts(int pageNum) {
    return apiProvider.getPosts(pageNum);
  }
}