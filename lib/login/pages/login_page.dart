import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:laundryku/login/controllers/login_controller.dart';
import 'package:laundryku/route/my_app_route.dart';
import 'package:laundryku/widget/my_button.dart';
import 'package:laundryku/widget/my_text.dart';
import 'package:laundryku/widget/my_text_field.dart';

class LoginPage extends StatelessWidget {
  final LoginController loginController = Get.find<LoginController>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
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
                  text: "Welcome Back",
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF00ADB5),
                ),
                SizedBox(height: 20),
                MyTextField(
                    hintText: "Username", controller: usernameController),
                MyTextField(
                    hintText: "Password", controller: passwordController),
                MyButton(
                  text: "Login",
                  onPressed: () {
                    Get.toNamed(MyappRoute.navbar);
                  },
                  color: const Color(0xFF00ADB5),
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  height: 50,
                  width: 400,
                  borderRadius: 30,
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: Colors.grey,
                        thickness: 1,
                        endIndent: 15,
                      ),
                    ),
                    MyText(
                      text: "or sign in with",
                      color: Color(0xFF888888),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    Expanded(
                      child: Divider(
                        color: Colors.grey,
                        thickness: 1,
                        indent: 15,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () => loginController.signinWithGoogle(),
                  child: Container(
                    height: 50,
                    width: 250,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/image/google.png',
                          width: 24,
                          height: 24,
                        ),
                        SizedBox(width: 10),
                        MyText(
                          text: "Login with Google",
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyText(
                      text: "belum punya akun? ",
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF888888),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed("/register");
                      },
                      child: MyText(
                        text: "SignUp",
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF00ADB5),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  }
