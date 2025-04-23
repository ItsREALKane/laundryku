import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:laundryku/widget/my_home_quick_button.dart';
import 'package:laundryku/widget/my_image_slider.dart';
import 'package:laundryku/widget/my_laundry_card.dart';

import 'package:laundryku/widget/my_text.dart';

import '../../route/my_app_route.dart';

final List<LaundryItem> nearbyLaundry = [
  LaundryItem(
    imageUrl:
        'https://i.pinimg.com/736x/3a/5c/53/3a5c53166f8b0d3e479f251659032234.jpg',
    name: 'Bening Laundry',
    services: ['Cuci Pakaian', 'Cuci Sprei', 'Cuci Tas'],
  ),
  LaundryItem(
    imageUrl:
        'https://i.pinimg.com/736x/3a/5c/53/3a5c53166f8b0d3e479f251659032234.jpg',
    name: 'Naruto Laundry',
    services: ['Cuci Pakaian', 'Setrika Pakaian'],
  ),
  LaundryItem(
    imageUrl:
        'https://i.pinimg.com/736x/3a/5c/53/3a5c53166f8b0d3e479f251659032234.jpg',
    name: 'Kings Laundry',
    services: [
      'Cuci Pakaian',
      'Setrika Pakaian',
      'Cuci Helm',
    ],
  ),
];

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              child: Image.asset(
                'assets/image/busa2.png',
                width: 140,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  const SizedBox(height: 60),
                  Align(
                    alignment: Alignment.centerRight,
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
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: MyText(
                      text: "Halo, Kenas!",
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: MyText(
                      text: "Apa yang ingin anda \nbersihkan hari ini?",
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      HomeQuickButton(
                          icon: Icons.dry_cleaning,
                          onTap: () {
                            Get.toNamed("/laundryList");
                          }),
                      HomeQuickButton(icon: Icons.access_time, onTap: () {}),
                      HomeQuickButton(
                          icon: Icons.event_note_rounded,
                          onTap: () {
                            Get.toNamed(MyappRoute.tagihanPage);
                          }),
                    ],
                  ),
                  const SizedBox(height: 24),
                  MyImageSlider(
                    imagePaths: [
                      'assets/image/laundrydeterjen.png',
                      'assets/image/coba.jpeg',
                      'assets/image/laundrydeterjen.png',
                      'assets/image/coba.jpeg',
                    ],
                  ),
                  const SizedBox(height: 24),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Color(0xFF00ADB5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.location_on,
                                color: Colors.white, size: 30),
                            const SizedBox(width: 6),
                            MyText(
                              text: "Laundry terdekat",
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Column(
                          children: nearbyLaundry
                              .map((laundry) => MyLaundryCard(
                                  nama: post.nama,
                                    laundry: laundry,
                                    onTap: () {
                                      Get.toNamed(MyappRoute.laundryDetailPage);
                                    },
                                  ))
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
