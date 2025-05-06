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

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        if (json['status'] == true) {
          var token = json['token'];
          final SharedPreferences prefs = await _prefs;
          await prefs.setString('token', token);

          var userUrl = Uri.parse("${ApiEndPoints.base}/api/users");
          http.Response userResponse = await http.get(userUrl);

          if (userResponse.statusCode == 200) {
            final userData = jsonDecode(userResponse.body)['data'] as List;
            final matchedUser = userData.firstWhere(
              (user) => user['email'] == emailController.text.trim(),
              orElse: () => null,
            );

            if (matchedUser != null) {
              await prefs.setInt('user_id', matchedUser['id']);
              await prefs.setString('user_name', matchedUser['name']);
              print("User ID disimpan: ${matchedUser['id']}");
            }
          }

          Get.toNamed(MyappRoute.navbar);
        } else {
          throw json['message'] ?? "Login failed";
        }
      } else {
        throw jsonDecode(response.body)['message'] ?? "Unknown Error Occurred";
      }
    } catch (error) {
      showDialog(
        context: Get.context!,
        builder: (context) {
          return SimpleDialog(
            title: Text('Error'),
            contentPadding: EdgeInsets.all(20),
            children: [Text(error.toString())],
          );
        },
      );
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    print("👋 Logged out. Data cleared.");
    Get.offAllNamed('/login');
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
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
