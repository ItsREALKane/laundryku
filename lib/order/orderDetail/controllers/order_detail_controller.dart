import 'package:get/get.dart';
import 'package:laundryku/order/order/controllers/order_controller.dart';

class OrderDetailController extends GetxController {
  late OrderItem order;

  @override
  void onInit() {
    super.onInit();
    order = Get.arguments as OrderItem;
  }

  @override
  void onClose() {
    super.onClose();
    Get.delete<OrderDetailController>();
  }
}
