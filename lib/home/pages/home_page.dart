import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:laundryku/widget/home_quick_button.dart';
import 'package:laundryku/widget/my_image_slider.dart';

import 'package:laundryku/widget/my_text.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            child: Image.asset(
              'assets/image/busa2.png',
              width: 140,
            ),
          ),
          Positioned(
            top: 16,
            right: 16,
            child: GestureDetector(
              onTap: () {
                Get.toNamed("/profile");
              },
              child: CircleAvatar(
                radius: 24,
                backgroundImage: AssetImage('assets/image/coba.jpeg'),
              ),
            ),
          ),
          Positioned(
            top: 100,
            left: 20,
            child: MyText(
              text: "Halo, Kenas!",
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Positioned(
            top: 120,
            left: 20,
            child: MyText(
              text: "Apa yang ingin anda \nbersihkan hari ini?",
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Positioned(
            top: 200,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                HomeQuickButton(
                    icon: Icons.dry_cleaning,
                    onTap: () {
                      Get.toNamed("/laundryList");
                    }),
                HomeQuickButton(icon: Icons.access_time, onTap: () {}),
                HomeQuickButton(icon: Icons.event_note_rounded, onTap: () {}),
              ],
            ),
          ),
          Positioned(
            top: 320,
            left: 20,
            right: 20,
            child: MyImageSlider(
              imagePaths: [
                'assets/image/laundrydeterjen.png',
                'assets/image/coba.jpeg',
                'assets/image/laundrydeterjen.png',
                'assets/image/coba.jpeg',
              ],
            ),
          )
        ],
      ),
    );
  }
}
