import 'package:get/get.dart';
import 'package:laundryku/data/model/laundry.dart';
import 'package:laundryku/data/service/API_service.dart';

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