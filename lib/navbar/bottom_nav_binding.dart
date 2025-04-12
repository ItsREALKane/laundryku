import 'package:get/get.dart';
import 'package:laundryku/navbar/bottom_nav_controller.dart';

class NavbarBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(BottomNavController());
  }
}
