import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundryku/profile/controllers/edit_controller.dart';
import 'package:laundryku/widget/my_button.dart';
import 'package:laundryku/widget/my_text.dart';
import 'package:laundryku/widget/my_text_field.dart';

class ProfileEditPage extends StatelessWidget {
  final EditController editController = Get.put(EditController());


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
                      onTap: () => Get.back(),
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
                Obx(() {
                  final imageUrl = editController.imageUrl.value;
                  return CircleAvatar(
                    radius: 50,
                    backgroundImage: imageUrl.isNotEmpty
                        ? (imageUrl.startsWith('http')
                            ? NetworkImage(imageUrl)
                            : FileImage(File(imageUrl))) as ImageProvider
                        : const AssetImage('assets/image/default_profile.png'),
                  );
                }),
                const SizedBox(height: 10),
                MyButton(
                  text: 'Pilih Foto',
                  onPressed: () async {
                    await editController.pickImage();
                  },
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
                      controller: editController.userName,
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
                      hintText: '08123...',
                      controller: editController.phone,
                    ),
                  ],
                ),
                const Spacer(),
                MyButton(
                  text: 'SIMPAN',
                  onPressed: () async {
                    await editController.saveProfile();
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
