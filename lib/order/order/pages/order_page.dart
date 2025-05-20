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
              Row(
                children: [
                  const Expanded(child: Search()),
                  const SizedBox(width: 8),
                  InkWell(
                    onTap: () => _showSortBottomSheet(context, controller),
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.filter_list, size: 18),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  InkWell(
                    onTap: () => _pickDateRange(context, controller),
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.date_range, size: 18),
                          const SizedBox(width: 4),
                          Obx(() {
                            final start = controller.startDate.value;
                            final end = controller.endDate.value;
                            return MyText(
                              text: (start == null || end == null)
                                  ? "Tanggal"
                                  : "${start.day}/${start.month}/${start.year} - ${end.day}/${end.month}/${end.year}",
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                            );
                          }),
                          Obx(() {
                            return (controller.startDate.value != null ||
                                    controller.endDate.value != null)
                                ? InkWell(
                                    onTap: () => controller.resetDateRange(),
                                    child: const Padding(
                                      padding: EdgeInsets.only(left: 4.0),
                                      child: Icon(Icons.close, size: 16),
                                    ),
                                  )
                                : const SizedBox();
                          }),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),
              Obx(() {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildFilterButton(controller, 'All'),
                      _buildFilterButton(controller, 'Menunggu Konfirmasi'),
                      _buildFilterButton(controller, 'Diproses'),
                      _buildFilterButton(controller, 'Siap Diambil'),
                      _buildFilterButton(controller, 'belum dibayar'),
                      _buildFilterButton(controller, 'Selesai'),
                      _buildFilterButton(controller, 'Dibatalkan'),
                    ],
                  ),
                );
              }),

              const SizedBox(height: 16),

              // 🔁 Order List
              Obx(() {
                if (controller.isLoading.value) {
                  return const Expanded(
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                final filteredOrders = controller.filteredOrders;

                return Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder:
                        (Widget child, Animation<double> animation) {
                      return FadeTransition(opacity: animation, child: child);
                    },
                    child: filteredOrders.isEmpty
                        ? const Center(
                            key: ValueKey("empty"),
                            child: Text(
                              'Tidak ada pesanan',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                          )
                        : ListView.builder(
                            key: ValueKey(filteredOrders.length),
                            itemCount: filteredOrders.length,
                            itemBuilder: (context, index) {
                              final order = filteredOrders[index];
                              return MyOrderCard(
                                name: order.name,
                                status: order.status,
                                estimatedTime: "Estimasi?",
                                orderDate: order.orderDate,
                                imagePath: order.img,
                                actionIcon: Icons.description,
                                onTap: () {
                                  Get.delete<OrderDetailController>();
                                  Get.toNamed(
                                    MyappRoute.orderDetailPage,
                                    arguments: order,
                                  );
                                },
                              );
                            },
                          ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterButton(OrderController controller, String label) {
    final isSelected = controller.selectedStatus.value == label;

    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: InkWell(
        onTap: () {
          controller.selectedStatus.value = label;
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF00ADB5) : Colors.grey[200],
            borderRadius: BorderRadius.circular(12),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ]
                : [],
          ),
          child: MyText(
            text: '$label',
            textAlign: TextAlign.center,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: isSelected ? Colors.white : Colors.black87,
          ),
        ),
      ),
    );
  }
}

void _showSortBottomSheet(BuildContext context, OrderController controller) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const MyText(
              text: "Urutkan berdasarkan",
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.arrow_downward),
              title: MyText(
                text: 'Terbaru',
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
              onTap: () {
                controller.isNewestFirst.value = true;
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.arrow_upward),
              title: MyText(
                text: 'Terlama',
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
              onTap: () {
                controller.isNewestFirst.value = false;
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
    },
  );
}


void _pickDateRange(BuildContext context, OrderController controller) async {
  final picked = await showDateRangePicker(
    context: context,
    firstDate: DateTime(2020),
    lastDate: DateTime(2100),
    initialDateRange:
        controller.startDate.value != null && controller.endDate.value != null
            ? DateTimeRange(
                start: controller.startDate.value!,
                end: controller.endDate.value!)
            : null,
  );

  if (picked != null) {
    controller.startDate.value = picked.start;
    controller.endDate.value = picked.end;
  }
}
