import '../provider/bamboo_provider.dart';

class BambooRepository {

  final BambooProvider bambooProvider;

  BambooRepository(this.bambooProvider);

  Future<List<dynamic>> getPosts(int pageNum) async {
    return await bambooProvider.getPosts(pageNum);
  }
}