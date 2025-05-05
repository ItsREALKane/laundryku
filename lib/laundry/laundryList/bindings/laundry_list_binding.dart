import 'package:get/get.dart';
import 'package:laundryku/laundry/laundryList/controllers/laundry_list_controller.dart';

class LaundryListBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LaundryListController());
  }
}
