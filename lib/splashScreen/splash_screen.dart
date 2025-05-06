import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundryku/widget/my_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
@override
void initState() {
  super.initState();
  _checkLoginStatus();
}

Future<void> _checkLoginStatus() async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token');

  await Future.delayed(Duration(seconds: 3));

  if (!mounted) return;

  if (token != null && token.isNotEmpty) {
    Get.offAllNamed('/navbar');
  } else {
    Get.offAllNamed('/login');
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/image/logo.png',
                  width: 130,
                ),
                 MyText(
                  text: "Laundryku",
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF00ADB5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
