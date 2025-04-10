import 'package:flutter/material.dart';
import 'package:laundryku/widget/my_text.dart';

class PesanPage extends StatelessWidget {
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
          Positioned(
            top: 0,
            right: 0,
            child: Image.asset(
              'assets/image/busa2.png',
              width: 140,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30),
                MyText(
                  text: "Pesan",
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF000000),
                ),
              ],
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/image/tidakadapesan.png',
                  width: 90,
                ),
                MyText(
                  text: "Tidak ada pesan untuk anda saat ini",
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF595959),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
