import 'package:get/get.dart';

class BottomNavController extends GetxController {
  // posisi terakhir menu
  var selectedIndex = 0.obs;

  void changeMenu(int index) {
    selectedIndex.value = index;
  }
}
