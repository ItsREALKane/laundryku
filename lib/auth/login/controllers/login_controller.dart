import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:laundryku/data/service/API_service.dart';
import 'package:laundryku/route/my_app_route.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> loginWithEmail() async {
    var headers = {'Content-Type': 'application/json'};
    try {
      var url =
          Uri.parse(ApiEndPoints.base + ApiEndPoints.authEndpoints.loginEmail);
      Map body = {
        'email': emailController.text.trim(),
        'password': passwordController.text
      };
      http.Response response =
          await http.post(url, body: jsonEncode(body), headers: headers);

      // Cek status code 200 untuk login berhasil
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');

        if (json['status'] == true) {
          // status true menunjukkan login sukses
          var token = json['token']; // Periksa apakah 'token' tersedia
          final SharedPreferences? prefs = await _prefs;
          await prefs?.setString('token', token);
          print("Token stored successfully: $token");

          emailController.clear();
          passwordController.clear();
          print("Navigating to navbar...");

          Get.toNamed(MyappRoute.navbar);
        } else {
          // Jika login gagal, tampilkan pesan error
          throw json['message'] ??
              "Login failed"; // Ambil pesan error dari server
        }
      } else {
        throw jsonDecode(response.body)['message'] ?? "Unknown Error Occurred";
      }
    } catch (error) {
      // Tangani error dengan dialog yang memberikan detail lebih lengkap
      print("❌ Error: $error");
      showDialog(
          context: Get.context!,
          builder: (context) {
            return SimpleDialog(
              title: Text('Error'),
              contentPadding: EdgeInsets.all(20),
              children: [Text(error.toString())],
            );
          });
    }
  }

  signinWithGoogle() async {
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    print(userCredential.user?.displayName);
    print(userCredential.user?.email);

    if (userCredential.user != null) {
      Get.offAllNamed('/navbar');
    } else {
      Get.snackbar("Error", "Login failed",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }
}
