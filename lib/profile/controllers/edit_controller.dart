import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:laundryku/data/service/API_service.dart';

class EditController extends GetxController {
  var userName = TextEditingController();
  var phone = TextEditingController();
  var imageUrl = ''.obs;
  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    fetchUserInfo();
  }

  Future<void> fetchUserInfo() async {
    final apiService = ApiService();
    final response = await apiService.getUserInfo();

    if (response['success']) {
      userName.text = response['data']['name'] ?? 'Guest';
      phone.text = response['data']['phone'] ?? '';
      imageUrl.value = response['data']['img'] ?? '';
    } else {
      print('Error user info: ${response['message']}');
    }
  }

  Future<void> pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      imageUrl.value = pickedFile.path;
    }
  }

  Future<void> saveProfile() async {
    final apiService = ApiService();
    final response = await apiService.editProfile(
      name: userName.text,
      phone: phone.text,
      imgUrl: imageUrl.value 
    );

    if (!response['success']) {
      await fetchUserInfo(); //iki ben kesimpen kyk shared prefen
      Get.snackbar('Error', response['message']);
    }
  }
}
