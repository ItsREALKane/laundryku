import 'package:get/get.dart';
import 'package:laundryku/favorite/controllers/favorite_controller.dart';

class FavoriteBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(FavoriteController());
  }
}
