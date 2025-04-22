import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundryku/route/my_app_route.dart';
import 'package:laundryku/widget/my_order_card.dart';
import 'package:laundryku/widget/my_search_bar.dart';
import 'package:laundryku/widget/my_text.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    final orders = [
      OrderItem(
        name: 'Bening Laundry',
        status: 'Di cuci',
        estimatedTime: '1-2 hari',
        orderDate: '18/01/2024',
        imagePath: 'assets/image/coba.jpeg',
        actionIcon: Icons.edit_document,
      ),
      OrderItem(
        name: 'Naruto Laundry',
        status: 'Di cuci',
        estimatedTime: '1-2 hari',
        orderDate: '18/01/2024',
        imagePath: 'assets/image/coba.jpeg',
        actionIcon: Icons.iron_outlined,
      ),
      OrderItem(
        name: 'Keren Laundry',
        status: 'Di cuci',
        estimatedTime: '1-2 hari',
        orderDate: '18/01/2024',
        imagePath: 'assets/image/coba.jpeg',
        actionIcon: Icons.check_circle_outline,
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: const Row(
                  children: [
                    Icon(Icons.arrow_back_ios, size: 18),
                    SizedBox(width: 2),
                    Text(
                      'Kembali',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const MyText(
                text: "Pesanan saya",
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF000000),
              ),
              const SizedBox(height: 16),
              const Search(),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: orders.length,
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  itemBuilder: (context, index) {
                    return MyOrderCard(
                      name: orders[index].name,
                      status: orders[index].status,
                      estimatedTime: orders[index].estimatedTime,
                      orderDate: orders[index].orderDate,
                      imagePath: orders[index].imagePath,
                      actionIcon: orders[index].actionIcon,
                      onTap: () {
                        Get.toNamed(MyappRoute.orderDetailPage);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
