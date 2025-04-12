import 'package:get/get.dart';
import 'package:laundryku/home/controllers/home_controller.dart';


class HomeBinding extends Bindings {
  @override
  void dependencies() {
    // deklarasi controller login here
    Get.put(HomeController());
  }
}
