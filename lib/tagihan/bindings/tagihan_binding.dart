import 'package:get/get.dart';
import 'package:laundryku/tagihan/controllers/tagihan_controller.dart';


class TagihanBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(TagihanController());
  }
}
