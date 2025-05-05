import 'package:get/get.dart';
import 'package:laundryku/auth/register/controllers/register_controller.dart';


class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    // deklarasi controller login here
    Get.put(RegisterController());
  }
}
