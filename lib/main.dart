import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundryku/firebase_options.dart';
import 'package:laundryku/home/pages/home_page.dart';
import 'package:laundryku/login/controllers/login_controller.dart';
import 'package:laundryku/login/pages/login_page.dart';
import 'package:laundryku/route/my_app_route.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.put(LoginController()); // ← Ini penting!

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Laundryku',
      debugShowCheckedModeBanner: false,
      initialRoute: MyappRoute.splashScreen,
      getPages: MyappRoute.page,
    );
  }
}
