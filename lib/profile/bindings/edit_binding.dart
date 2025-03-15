import 'package:get/get.dart';
import 'package:laundryku/profile/controller/edit_controller.dart';

class EditBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(EditController());
  }
}
