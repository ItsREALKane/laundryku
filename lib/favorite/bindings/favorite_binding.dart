import 'package:get/get.dart';
import 'package:laundryku/favorite/controller/favorite_controller.dart';

class FavoriteBinding extends Bindings {
  @override
  void dependencies() {
    // deklarasi controller login here
    Get.put(FavoriteController());
  }
}
