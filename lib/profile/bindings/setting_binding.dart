import 'package:get/get.dart';
import 'package:laundryku/profile/controllers/setting_controller.dart';

class SettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SettingController());
  }
}
