import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundryku/order/orderDetail/controllers/order_detail_controller.dart';
import 'package:laundryku/widget/my_laundry_info_card.dart';
import 'package:laundryku/widget/my_text.dart';

class OrderDetailPage extends StatelessWidget {
  OrderDetailPage({super.key});
  final order = Get.put(OrderDetailController()).order;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    print(
        "Raw order date: ${order.orderDate} (${order.orderDate.runtimeType})");
    final imageHeight = screenHeight * 0.25;
    final cardHeight = 120.0;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            height: imageHeight,
            width: double.infinity,
            child: Image.asset(
              'assets/image/bg.jpg',
              fit: BoxFit.cover,
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: imageHeight - 20),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: cardHeight),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(50, 20, 50, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: MyText(
                                    text: "Detail Pesanan",
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                                SizedBox(height: 12),
                                Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(8),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          blurRadius: 1,
                                          spreadRadius: 2,
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        _buildDetailRow(
                                            "STATUS PESANAN", order.status),
                                        SizedBox(height: 12),
                                        _buildDetailRow("NO. HP", order.phone),
                                        SizedBox(height: 12),
                                        _buildDetailRow(
                                            "INFO PESANAN", order.infoPesanan),
                                        SizedBox(height: 12),
                                        _buildDetailRow(
                                            "ALAMAT ANDA", order.alamat),
                                        SizedBox(height: 12),
                                        _buildDetailRow("TANGGAL PESANAN",
                                            (order.orderDate).toString()),
                                        SizedBox(height: 12),
                                        _buildDetailRow(
                                            "TOTAL", "Rp ${order.total}"),
                                      ],
                                    )),
                                const SizedBox(height: 300),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: -cardHeight / 3,
                      left: 60,
                      right: 60,
                      child: LaundryInfoCard(
                        title: order.name,
                        subtitle: order.jasa,
                        services: order.pengantaran
                            .split(',')
                            .map((e) => e.trim())
                            .map((name) => LaundryService(
                                  name: name,
                                  icon: _getIconForService(name),
                                ))
                            .toList(),
                        backgroundColor: Colors.grey.shade100,
                        textColor: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            left: 10,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.7),
                borderRadius: BorderRadius.circular(20),
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                  Get.back();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  IconData _getIconForService(String name) {
    switch (name.toLowerCase()) {
      case 'delivery':
        return Icons.local_shipping_outlined;
      case 'pick up':
        return Icons.shopping_bag_outlined;
      case 'antar':
        return Icons.delivery_dining_outlined;
      case 'ambil':
        return Icons.storefront_outlined;
      default:
        return Icons.miscellaneous_services;
    }
  }

  Widget _buildDetailRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyText(
          text: label,
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Color(0xFF00ADB5),
        ),
        MyText(
          text: value,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Colors.grey.shade600,
        ),
      ],
    );
  }
}
