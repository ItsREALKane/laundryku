import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundryku/widget/my_button.dart';
import 'package:laundryku/widget/my_text.dart';
import 'package:laundryku/widget/my_text_field.dart';

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({super.key});

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 8.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.arrow_back_ios, size: 16),
                          MyText(
                            text: 'kembali',
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/image/coba.jpeg'),
                ),
                const SizedBox(height: 10),
                MyButton(
                  text: 'Pilih Foto',
                  onPressed: () {},
                  color: const Color(0xFF00ADB5),
                  width: 120,
                  height: 36,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
                const SizedBox(height: 30),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 50, bottom: 5),
                      child: MyText(
                        text: 'Username',
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Colors.black87,
                      ),
                    ),
                    MyTextField(
                      hintText: 'user',
                      controller: _usernameController,
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 50, bottom: 5),
                      child: MyText(
                        text: 'No. Hp',
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Colors.black87,
                      ),
                    ),
                    MyTextField(
                      hintText: '08112071740',
                      controller: _phoneController,
                    ),
                  ],
                ),
                const Spacer(),
                MyButton(
                  text: 'SIMPAN',
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Profil berhasil disimpan')),
                    );
                  },
                  color: const Color(0xFF00ADB5),
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  height: 50,
                  width: 400,
                  ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
