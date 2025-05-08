import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundryku/auth/register/controllers/register_controller.dart';
import 'package:laundryku/widget/my_button.dart';
import 'package:laundryku/widget/my_text.dart';
import 'package:laundryku/widget/my_text_field.dart';

class RegisterPage extends StatelessWidget {
  final RegisterController registerController = Get.find<RegisterController>();

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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/image/logo.png',
                    width: 130,
                  ),
                  SizedBox(height: 20),
                  MyText(
                    text: "Welcome to Laundryku",
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF00ADB5),
                  ),
                  SizedBox(height: 20),
                  MyTextField(
                    hintText: "Username",
                    controller: registerController.usernameController,
                  ),
                  MyTextField(
                    hintText: "Email",
                    controller: registerController.emailController,
                  ),
                  MyTextField(
                    hintText: "Password",
                    controller: registerController.passwordController,
                    isObscure: true,
                  ),
                  SizedBox(height: 20),
                  MyButton(
                    text: "Sign Up",
                    onPressed: () => registerController.registerWithEmail(),
                    color: const Color(0xFF00ADB5),
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    height: 50,
                    width: 400,
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyText(
                        text: "Sudah punya akun? ",
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF888888),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed("/login");
                        },
                        child: MyText(
                          text: "Login",
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
          ),
        ],
      ),
    );
  }
}
