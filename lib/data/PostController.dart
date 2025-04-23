import 'package:get/get.dart';
import 'package:laundryku/data/Laundry.dart';
import 'package:laundryku/data/apiService.dart';

class PostController extends GetxController {
  var isLoading = true.obs;
  var postList = <Laundry>[].obs;

  @override
  void onInit() {
    fetchPosts();
    super.onInit();
  }

  void fetchPosts() async {
    try {
      isLoading(true);
      var posts = await ApiService().fetchLaundries();
      postList.assignAll(posts);
    } finally {
      isLoading(false);
    }
  }
}