import 'package:get/get.dart';
import 'package:scroll_swipe_like/controller/bamboo_controller.dart';
import 'package:scroll_swipe_like/data/provider/bamboo_provider.dart';
import 'package:scroll_swipe_like/data/repository/bamboo_repository.dart';

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

    // lazyPut과 put은 문법이 살짝 다름
    // put은 이렇게 쓰면 에러 발생
    // Get.put<BambooController>(() {
    //   return BambooController(
    //     BambooRepository(
    //       BambooProvider(
    //       )
    //     )
    //   );
    // });

    // put은 이렇게 써야함
    // Get.put<BambooController>(
    //   BambooController(
    //     BambooRepository(
    //       BambooProvider(
    //       )
    //     )
    //   )
    // );
  }
}