import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundryku/data/api_controller.dart';

import 'package:laundryku/widget/my_home_quick_button.dart';
import 'package:laundryku/widget/my_image_slider.dart';
import 'package:laundryku/widget/my_laundry_card.dart';
import 'package:laundryku/widget/my_text.dart';

import '../../route/my_app_route.dart';

class HomePage extends StatelessWidget {
  final ApiController controller = Get.put(ApiController());
  
  HomePage();

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
                            Get.toNamed(MyappRoute.laundryListPage);
                          }),
                      HomeQuickButton(
                          icon: Icons.access_time, 
                          onTap: () {
                            
                          }),
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
                        Obx(() {
                          if (controller.isLoading.value) {
                            return Center(child: CircularProgressIndicator());
                          }
                          return Column(
                            children: controller.postList
                                .map((laundry) => MyLaundryCard(
                                      laundry: laundry,
                                      onTap: () {
                                        Get.toNamed(
                                          MyappRoute.laundryDetailPage,
                                          arguments: laundry,
                                        );
                                      },
                                    ))
                                .toList(),
                          );
                        }),
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
