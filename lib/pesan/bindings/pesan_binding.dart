import 'package:get/get.dart';
import 'package:laundryku/pesan/controllers/pesan_controller.dart';

class PesanBinding extends Bindings {
  @override
  void dependencies() {
    // deklarasi controller  here
    Get.put(PesanController());
  }
}
