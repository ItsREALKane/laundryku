import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundryku/profile/controllers/edit_controller.dart';
import 'package:laundryku/profile/controllers/profile_controller.dart';
import 'package:laundryku/widget/my_button.dart';
import 'package:laundryku/widget/my_menu_item.dart';
import 'package:laundryku/widget/my_text.dart';

class ProfilePage extends StatelessWidget {
  final ProfileController controller = Get.put(ProfileController());
  final EditController editController = Get.put(EditController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Column(
            children: [
              const SizedBox(height: 100),
              Center(
                child: Column(
                  children: [
                    Obx(() {
                      final imageUrl = editController.imageUrl.value;
                      return CircleAvatar(
                        radius: 50,
                        backgroundImage: imageUrl.isNotEmpty
                            ? (imageUrl.startsWith('http')
                                ? NetworkImage(imageUrl)
                                : FileImage(File(imageUrl))) as ImageProvider
                            : const AssetImage(
                                'assets/image/default_profile.png'),
                      );
                    }),
                    const SizedBox(height: 16),
                    Obx(() => MyText(
                          text: controller.userName.value,
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        )),
                    Obx(() => MyText(
                          text: controller.email.value,
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.black54,
                        )),
                    MyButton(
                      text: 'Edit Profil',
                      onPressed: () {
                        Get.toNamed("/profileEdit");
                      },
                      color: const Color(0xFF00ADB5),
                      width: 120,
                      height: 36,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 50),
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.grey.shade700, width: 1),
                ),
                child: Column(
                  children: [
                    MenuItem(
                      icon: Icons.receipt_outlined,
                      text: 'Pesanan Saya',
                      onTap: () {
                        Get.toNamed("/order");
                      },
                    ),
                    const Divider(height: 1),
                    MenuItem(
                      icon: Icons.history,
                      text: 'Riwayat Pesanan',
                      onTap: () {
                        Get.toNamed("/orderHistory");
                      },
                    ),
                    const Divider(height: 1),
                    MenuItem(
                      icon: Icons.settings,
                      text: 'Pengaturan',
                      onTap: () {
                        Get.toNamed("/profileSetting");
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
