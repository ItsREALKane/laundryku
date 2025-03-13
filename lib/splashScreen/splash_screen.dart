import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundryku/widget/my_text.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        Get.toNamed('/login');
      }
    });
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
