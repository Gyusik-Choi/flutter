import 'package:get/get.dart';
import '../controller/data_controller.dart';
import '../data/repository/posts_repository.dart';
import '../data/providers/api.dart';

class Binding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiProvider>(() {
      return ApiProvider();  
    });
  }
}