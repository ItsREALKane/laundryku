import 'package:get/get.dart';
import 'package:laundryku/profile/controllers/edit_controller.dart';

class EditBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(EditController());
  }
}
