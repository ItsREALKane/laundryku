import 'package:get/get.dart';
import 'package:laundryku/data/service/API_service.dart';

class ProfileController extends GetxController {
  var userName = ''.obs;
  var email = ''.obs;
  var imageUrl = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserInfo();
  }

  Future<void> fetchUserInfo() async {
    final apiService = ApiService();
    final response = await apiService.getUserInfo();

    if (response['success']) {
      userName.value = response['data']['name'] ?? 'Guest';
      email.value = response['data']['email'] ?? '';
      imageUrl.value = response['data']['email'] ?? '';
      await fetchUserInfo(); //iki ben kesimpen kyk shared prefance
    } else {
      print('Error user info: ${response['message']}');
    }
  }
  
}
