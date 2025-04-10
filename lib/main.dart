import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundryku/route/myapproute.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
