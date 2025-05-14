import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:laundryku/data/model/laundry.dart';
import 'package:laundryku/data/service/API_service.dart';

class FavoriteController extends GetxController {
  RxList<Laundry> favoriteList = <Laundry>[].obs;
  late int userId;
  String? token;

  @override
  void onInit() {
    super.onInit();
    loadUserIdAndFavorites();
  }

  Future<void> loadUserIdAndFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    userId = prefs.getInt('user_id') ?? 0;
    token = prefs.getString('token');
    if (userId != 0 && token != null) {
      await fetchFavoritesFromServer();
    }
  }

  void printToken() {
    print('✅ Token di controller: $token');
  }

  Future<void> fetchFavoritesFromServer() async {
    final url = Uri.parse(ApiEndPoints.base + "/favorites");
    final response = await http.get(url, headers: {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    });

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body)['data'];
      favoriteList.value =
          data.map((e) => Laundry.fromJson(e['laundry'])).toList();
    } else {
      print("⚠️ Failed to load favorites: ${response.body}");
    }
  }

  bool isFavorite(Laundry laundry) {
    return favoriteList.any((item) => item.id == laundry.id);
  }

  Future<void> toggleFavorite(Laundry laundry) async {
    if (token == null) {
      final prefs = await SharedPreferences.getInstance();
      token = prefs.getString('token');
      print('🔁 Token baru di-load: $token');
      if (token == null) {
        print('❌ Token masih null, tidak bisa lanjut');
        return;
      }
    }

    if (isFavorite(laundry)) {
      await removeFromFavorite(laundry.id!);
    } else {
      await addToFavorite(laundry.id!);
    }
  }

  Future<void> addToFavorite(int laundryId) async {
    final url = Uri.parse(ApiEndPoints.base + "/favorites");
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      },
      body: jsonEncode({'id_laundry': laundryId}),
    );

    if (response.statusCode == 201) {
      await fetchFavoritesFromServer(); // refresh
    } else {
      print("⚠️ Gagal tambah favorite: ${response.body}");
    }
  }

  Future<void> removeFromFavorite(int laundryId) async {
    final url = Uri.parse(ApiEndPoints.base + "/favorites/$laundryId");
    final response = await http.delete(url, headers: {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    });

    if (response.statusCode == 200) {
      favoriteList.removeWhere((item) => item.id == laundryId);
    } else {
      print("⚠️ Gagal hapus favorite: ${response.body}");
    }
  }

  void clearFavorites() {
    favoriteList.clear(); // buat saat logout
  }
}
