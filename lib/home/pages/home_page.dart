import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundryku/auth/login/controllers/login_controller.dart';
import 'package:laundryku/data/api_controller.dart';
import 'package:laundryku/widget/my_home_quick_button.dart';
import 'package:laundryku/widget/my_image_slider.dart';
import 'package:laundryku/widget/my_laundry_card.dart';
import 'package:laundryku/widget/my_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../route/my_app_route.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ApiController controller = Get.put(ApiController());
  String userName = 'User';

  @override
  void initState() {
    super.initState();
    loadUserName();
  }

  Future<void> loadUserName() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('user_name') ?? 'User';
    });
  }

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
                      child: const CircleAvatar(
                        radius: 24,
                        backgroundImage: AssetImage('assets/image/coba.jpeg'),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: MyText(
                      text: "Halo, $userName!",
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Align(
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
                            // final loginController = Get.find<LoginController>();
                            // loginController.logout();
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
                      color: const Color(0xFF00ADB5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            Icon(Icons.location_on,
                                color: Colors.white, size: 30),
                            SizedBox(width: 6),
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
                            return const Center(
                                child: CircularProgressIndicator());
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
