import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundryku/widget/my_search_bar.dart';
import 'package:laundryku/widget/my_text.dart';

class TagihanPage extends StatelessWidget {
  TagihanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            child: Image.asset(
              'assets/image/busa.png',
              width: 140,
            ),
          ),
          Container(
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
                      MyText(
                        text: 'kembali',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                const MyText(
                  text: "Tagihan",
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF000000),
                ),
                const SizedBox(height: 12),
                const Search(),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
