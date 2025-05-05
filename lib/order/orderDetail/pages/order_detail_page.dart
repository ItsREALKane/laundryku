import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundryku/widget/my_laundry_info_card.dart';
import 'package:laundryku/widget/my_text.dart';

class OrderDetailPage extends StatelessWidget {
  const OrderDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final imageHeight = screenHeight * 0.25;
    final cardHeight = 120.0;

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
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
                                      _buildDetailRow("STATUS PESANAN",
                                          "Di cuci", Color(0xFF00ADB5)),
                                      const SizedBox(height: 12),
                                      _buildDetailRow("NO. HP", "08112017140",
                                          Color(0xFF00ADB5)),
                                      const SizedBox(height: 12),
                                      _buildDetailRow("INFO LAUNDRY",
                                          "Pakaian 5KG", Color(0xFF00ADB5)),
                                      const SizedBox(height: 12),
                                      _buildDetailRow(
                                          "ALAMAT",
                                          "Mitra Kost, Jl. Bae-Besito, Besito Kulon, Jurang, Kec. Gebog, Kabupaten Kudus, Jawa Tengah 59333",
                                          Color(0xFF00ADB5)),
                                      const SizedBox(height: 12),
                                      _buildDetailRow("TANGGAL", "18/01/2024",
                                          Color(0xFF00ADB5)),
                                      const SizedBox(height: 12),
                                      _buildDetailRow("TOTAL", "Rp20.000",
                                          Color(0xFF00ADB5)),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 170),
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
                        title: 'Bening Laundry',
                        subtitle: 'Pakaian, Sprei, Tas, Boneka',
                        services: const [
                          LaundryService(
                            name: 'Delivery',
                            icon: Icons.local_shipping_outlined,
                          ),
                          LaundryService(
                            name: 'Pick Up',
                            icon: Icons.shopping_bag_outlined,
                          ),
                        ],
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

  Widget _buildDetailRow(String label, String value, Color valueColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyText(
          text: label,
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: Colors.black54,
        ),
        const SizedBox(height: 4),
        MyText(
          text: value,
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: valueColor,
        ),
      ],
    );
  }
}
