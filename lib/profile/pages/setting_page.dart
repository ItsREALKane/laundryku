import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundryku/widget/my_text.dart';

class SettingProfilePage extends StatefulWidget {
  const SettingProfilePage({super.key});

  @override
  State<SettingProfilePage> createState() => _SettingProfilePageState();
}

class _SettingProfilePageState extends State<SettingProfilePage> {
  bool isDarkMode = false;
  bool isNotificationEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            // App bar with back button
            Padding(
              padding: const EdgeInsets.only(top: 40, left: 16),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back(); // Go back to previous screen using GetX
                    },
                    child: Row(
                      children: [
                        const Icon(Icons.arrow_back_ios, size: 16),
                        const SizedBox(width: 4),
                        const MyText(
                          text: 'Kembali',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Settings Container
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF1EBABA),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  // Dark Mode Toggle
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const MyText(
                        text: 'Mode Gelap',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                      Switch(
                        value: isDarkMode,
                        onChanged: (value) {
                          setState(() {
                            isDarkMode = value;
                          });
                        },
                        activeColor: Colors.white,
                        activeTrackColor: Colors.black54,
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Notification Toggle
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const MyText(
                        text: 'Notifikasi',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                      Switch(
                        value: isNotificationEnabled,
                        onChanged: (value) {
                          setState(() {
                            isNotificationEnabled = value;
                          });
                        },
                        activeColor: Colors.white,
                        activeTrackColor: Colors.black54,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
