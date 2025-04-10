import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundryku/profile/controller/profile_controller.dart';
import 'package:laundryku/widget/my_button.dart';
import 'package:laundryku/widget/my_menu_item.dart';
import 'package:laundryku/widget/my_text.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            bottom: 0,
            left: 0,
            child: Image.asset(
              'assets/image/busa.png',
              width: 140,
            ),
          ),
          Column(
            children: [
              const SizedBox(height: 100),
              Center(
                child: Column(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                        image: const DecorationImage(
                          image: AssetImage('assets/image/coba.jpeg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const MyText(
                      text: 'User',
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                    const MyText(
                      text: 'user@gmail.com',
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: Colors.black54,
                    ),
                    const SizedBox(height: 16),
                    MyButton(
                      text: 'Edit Profil',
                      onPressed: () {
                        Get.toNamed("/editProfile");
                      },
                      color: const Color(0xFF00ADB5),
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
                      onTap: () {},
                    ),
                    const Divider(height: 1),
                    MenuItem(
                      icon: Icons.history,
                      text: 'Riwayat Pesanan',
                      onTap: () {},
                    ),
                    const Divider(height: 1),
                    MenuItem(
                      icon: Icons.settings,
                      text: 'Pengaturan',
                      onTap: () {
                        Get.toNamed("/settingProfile");
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
