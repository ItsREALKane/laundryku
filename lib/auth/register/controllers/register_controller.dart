import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:laundryku/data/service/API_service.dart';
import 'package:laundryku/route/my_app_route.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterController extends GetxController {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> registerWithEmail() async {
    try {
      if (usernameController.text.isEmpty ||
          emailController.text.isEmpty ||
          passwordController.text.isEmpty) {
        Get.dialog(SimpleDialog(
          title: Text("Error"),
          children: [Text("Semua field harus diisi!")],
        ));
        return;
      }

      var headers = {'Content-Type': 'application/json'};
      var url = Uri.parse(
          ApiEndPoints.base + ApiEndPoints.authEndpoints.registerEmail);
      Map body = {
        'name': usernameController.text,
        'email': emailController.text.trim(),
        'password': passwordController.text,
        'password_confirmation': passwordController.text // penting!
      };

      print("Register Body: $body");

      http.Response response =
          await http.post(url, body: jsonEncode(body), headers: headers);

      print("Response Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 201) {
        // 201 menunjukkan berhasil
        final json = jsonDecode(response.body);
        if (json['status'] == true) {
          // check 'status' untuk validasi sukses
          var token = json['token'];
          final SharedPreferences? prefs = await _prefs;
          await prefs?.setString('token', token);

          usernameController.clear();
          emailController.clear();
          passwordController.clear();

          Get.back();

          try {
            // Navigate setelah dialog ditutup
            await Get.toNamed(MyappRoute.navbar);
            print('✅ Navigasi berhasil ke homePage');
          } catch (e) {
            print('❌ Navigasi gagal: $e');
          }
        } else {
          throw json['message'] ?? "Unknown error occurred";
        }
      } else {
        throw jsonDecode(response.body)["message"] ?? "Unknown error occurred";
      }
    } catch (e) {
      print("❌ Error terjadi saat registrasi: $e");
      // Menangani error dengan pesan yang jelas
      showDialog(
          context: Get.context!,
          builder: (context) {
            return SimpleDialog(
              title: Text('Error'),
              contentPadding: EdgeInsets.all(20),
              children: [Text(e.toString())],
            );
          });
    }
  }
}
