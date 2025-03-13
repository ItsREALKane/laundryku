import 'package:get/get.dart';
import 'package:laundryku/login/controller/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    // deklarasi controller login here
    Get.put(LoginController());
  }
}
