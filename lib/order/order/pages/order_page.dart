import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundryku/order/order/controllers/order_controller.dart';
import 'package:laundryku/order/orderDetail/controllers/order_detail_controller.dart';
import 'package:laundryku/route/my_app_route.dart';
import 'package:laundryku/widget/my_order_card.dart';
import 'package:laundryku/widget/my_search_bar.dart';
import 'package:laundryku/widget/my_text.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => Get.back(),
                child: const Row(
                  children: [
                    Icon(Icons.arrow_back_ios, size: 18),
                    SizedBox(width: 2),
                    MyText(
                      text: 'kembali',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const MyText(
                  text: "Pesanan saya",
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF000000)),
              const SizedBox(height: 16),
              const Search(),
              const SizedBox(height: 16),
              Obx(() {
                if (controller.isLoading.value) {
                  return const Expanded(
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                final orders = controller.orders;

                if (orders.isEmpty) {
                  return const Expanded(
                    child: Center(
                      child: Text(
                        'Tidak ada pesanan',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ),
                  );
                }

                return Expanded(
                  child: ListView.builder(
                    itemCount: orders.length,
                    itemBuilder: (context, index) {
                      final order = orders[index];
                      return MyOrderCard(
                        name: order.name,
                        status: order.status,
                        estimatedTime: "Estimasi?",
                        orderDate: order.orderDate,
                        imagePath: 'assets/image/coba.jpeg',
                        actionIcon: Icons.description,
                        onTap: () {
                          Get.delete<OrderDetailController>();
                          Get.toNamed(
                            MyappRoute.orderDetailPage,
                            arguments: orders[index],
                          );
                        },
                      );
                    },
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
