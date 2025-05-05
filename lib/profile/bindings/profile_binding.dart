import 'package:get/get.dart';
import 'package:laundryku/profile/controller/profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    // deklarasi controller login here
    Get.put(ProfileController());
  }
}
