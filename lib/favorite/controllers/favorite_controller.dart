import 'package:get/get.dart';
import 'package:laundryku/data/model/laundry.dart';

class FavoriteController extends GetxController {
  RxList<Laundry> favoriteList = <Laundry>[].obs;

  void toggleFavorite(Laundry laundry) {
    if (isFavorite(laundry)) {
      favoriteList.removeWhere((item) => item.id == laundry.id);
    } else {
      favoriteList.add(laundry);
    }
  }

  bool isFavorite(Laundry laundry) {
    return favoriteList.any((item) => item.id == laundry.id);
  }
}
