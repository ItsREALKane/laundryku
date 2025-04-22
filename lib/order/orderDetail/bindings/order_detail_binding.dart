import 'package:get/get.dart';
import 'package:laundryku/order/orderDetail/controllers/order_detail_controller.dart';

class OrderDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(OrderDetailController());
  }
}
