import 'package:get/get.dart';
import 'package:laundryku/laundry/laundryDetail/controllers/laundry_details_controller.dart';

class LaundryDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LaundryDetailsController());
  }
}
