import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:laundryku/data/service/API_service.dart';
import 'package:laundryku/favorite/controllers/favorite_controller.dart';
import 'package:laundryku/route/my_app_route.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  RxBool rememberMe = false.obs;
  RxBool isLoading = false.obs;

  Future<void> loginWithEmail() async {
    var headers = {'Content-Type': 'application/json'};
    try {
      isLoading.value = true;

      var url =
          Uri.parse(ApiEndPoints.base + ApiEndPoints.authEndpoints.loginEmail);
      Map body = {
        'email': emailController.text.trim(),
        'password': passwordController.text
      };
      http.Response response =
          await http.post(url, body: jsonEncode(body), headers: headers);

      isLoading.value = false;

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        if (json['status'] == true) {
          var token = json['token'];
          final SharedPreferences prefs = await _prefs;

          await prefs.setString('token', token);

          await prefs.setBool('remember_me', rememberMe.value);

          if (json['user_id'] != null) {
            await prefs.setInt('user_id', json['user_id']);
            await prefs.setString('user_name', json['name'] ?? '');


            final apiService = ApiService();
            await apiService.saveUserId(json['user_id']);
            print("✅ User ID disimpen: ${json['user_id']}");

            if (Get.isRegistered<FavoriteController>()) {
              Get.delete<FavoriteController>(); // buang yang lama
            }
            Get.put(FavoriteController());
            await Get.find<FavoriteController>().loadUserIdAndFavorites();
          }

          Get.toNamed(MyappRoute.navbar);
        } else {
          throw json['message'] ?? "Login failed";
        }
      } else {
        throw jsonDecode(response.body)['message'] ?? "Unknown Error Occurred";
      }
    } catch (error) {
      isLoading.value = false;
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

    await prefs.remove('token');
    await prefs.remove('user_id');
    await prefs.remove('user_name');

    if (Get.isRegistered<FavoriteController>()) {
      Get.find<FavoriteController>().favoriteList.clear();
      Get.delete<FavoriteController>();
    }

    print(
        "👋 Logged out. Token, user info dibersihkan, favorite tetap aman di device.");
    Get.offAllNamed(MyappRoute.loginPage);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<void> signinWithGoogle() async {
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
      Get.offAllNamed(MyappRoute.navbar);
    } else {
      Get.snackbar("Error", "Login failed",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
