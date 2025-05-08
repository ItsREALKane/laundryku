import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:laundryku/data/model/laundry.dart';

class FavoriteController extends GetxController {
  RxList<Laundry> favoriteList = <Laundry>[].obs;
  int? userId;

  void toggleFavorite(Laundry laundry) async {
    if (isFavorite(laundry)) {
      favoriteList.removeWhere((item) => item.id == laundry.id);
    } else {
      favoriteList.add(laundry);
    }
    await saveFavorites(); // simpan tiap ada perubahan
  }

  bool isFavorite(Laundry laundry) {
    return favoriteList.any((item) => item.id == laundry.id);
  }

  Future<void> loadUserIdAndFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    userId = prefs.getInt('user_id');
    if (userId != null) {
      final String? jsonString = prefs.getString('favorites_$userId');
      if (jsonString != null) {
        final List<dynamic> jsonData = jsonDecode(jsonString);
        favoriteList.value = jsonData.map((e) => Laundry.fromJson(e)).toList();
      }
    }
  }

  Future<void> saveFavorites() async {
    if (userId == null) return;
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(favoriteList.map((e) => e.toJson()).toList());
    await prefs.setString('favorites_$userId', jsonString);
  }

  Future<void> clearFavorites() async {
    if (userId == null) return;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('favorites_$userId');
    favoriteList.clear();
  }
}
