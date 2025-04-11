import 'package:get/get.dart';
import 'package:laundryku/order/orderhistory/controller/order_history_controller.dart';

class OrderHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(OrderHistoryController());
  }
}
