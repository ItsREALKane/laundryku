import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:laundryku/data/model/laundry.dart';
import 'package:laundryku/data/model/order.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  final String baseUrl = 'https://laundryku.rplrus.com/api';

  // Get user ID from SharedPreferences
  Future<int?> getUserId() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getInt('user_id');
      if (userId == null) {
        print('⚠️ WARNING: User ID teu kapanggih dina SharedPreferences');
        return null;
      }
      print('✅ User ID kahiji: $userId');
      return userId;
    } catch (e) {
      print('❌ Error dina keur maca User ID: $e');
      print('Stack trace: ${StackTrace.current}');
      return null;
    }
  }

  // Save user ID to SharedPreferences
  Future<bool> saveUserId(int userId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('user_id', userId);
      print('User ID disimpen: $userId');
      return true;
    } catch (e) {
      print('Error saat menyimpan user ID: $e');
      return false;
    }
  }

  // Fetches the laundry list from the API
  Future<List<Laundry>> fetchLaundries() async {
    final response = await http.get(Uri.parse('$baseUrl/laundry'));

    print("Status code: ${response.statusCode}");
    print("Response body: ${response.body}");

    if (response.statusCode == 200) {
      List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((item) => Laundry.fromJson(item)).toList();
    } else {
      throw Exception('Gagal memuat data laundry');
    }
  }

  // Create order and send to API
  Future<Map<String, dynamic>> createOrder(Order order) async {
    try {
      if (order.idUser == null) {
        final userId = await getUserId();
        if (userId == null) {
          return {
            'success': false,
            'message':
                'Punten, ID akun anjeun teu kapanggih. Mangga asup deui heula ka akun anjeun.'
          };
        }
        order.idUser = userId;
      }

      final orderData = order.toJson();
      orderData['antar_sendiri'] = (order.pengiriman == true) ? 1 : 0;

      print("Sending order data: $orderData");

      final response = await http.post(
        Uri.parse('$baseUrl/pesanan'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(orderData),
      );

      print("Status code: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode >= 200 && response.statusCode < 300) {
        Map<String, dynamic> responseData;
        try {
          responseData = jsonDecode(response.body);
          return {
            'success': true,
            'data': responseData,
            'message': responseData['message'] ?? 'Pesanan berhasil dibuat'
          };
        } catch (e) {
          return {
            'success': true,
            'data': {'message': 'Pesanan berhasil dibuat'},
            'message': 'Pesanan berhasil dibuat'
          };
        }
      } else {
        String errorMessage = 'Terjadi kesalahan saat membuat pesanan';

        try {
          final errorData = jsonDecode(response.body);
          if (errorData is Map<String, dynamic>) {
            if (errorData.containsKey('message')) {
              errorMessage = errorData['message'];
            } else if (errorData.containsKey('error')) {
              errorMessage = errorData['error'];
            }
          }
        } catch (e) {
          print('Error parsing error response: $e');
        }

        return {
          'success': false,
          'status_code': response.statusCode,
          'message': errorMessage
        };
      }
    } catch (e) {
      print('Exception during order creation: $e');
      return {'success': false, 'message': 'Terjadi kesalahan koneksi: $e'};
    }
  }

  // load username kaleh email
  Future<Map<String, dynamic>> getUserInfo() async {
    try {
      final userId = await getUserId();
      if (userId == null) {
        return {
          'success': false,
          'message': 'User ID not found, please log in again.'
        };
      }

      final response = await http.get(
        Uri.parse('${ApiEndPoints.base}/users/$userId'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> userData = jsonDecode(response.body);
        return {
          'success': true,
          'data': userData,
        };
      } else {
        return {
          'success': false,
          'message': 'Failed to fetch user info',
        };
      }
    } catch (e) {
      print('❌ Error fetching user info: $e');
      return {'success': false, 'message': 'Error fetching user info: $e'};
    }
  }

  //edit yo
  Future<Map<String, dynamic>> editProfile({
    required String name,
    required String phone,
    required String imgUrl,
  }) async {
    try {
      final userId = await getUserId();
      if (userId == null) {
        return {
          'success': false,
          'message': 'User ID not found, please log in again.'
        };
      }

      var request = http.MultipartRequest(
        'POST', // atau 'PUT' tapi hati-hati, beberapa server gak support PUT dengan multipart
        Uri.parse(
            '$baseUrl/users/$userId?_method=PUT'), // pakai _method buat override
      );

      request.fields['name'] = name;
      request.fields['phone'] = phone;

      if (imgUrl.isNotEmpty) {
        request.files.add(await http.MultipartFile.fromPath('img', imgUrl));
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        return {'success': true, 'message': 'Profile updated successfully'};
      } else {
        return {
          'success': false,
          'message': 'Failed to update profile ${response.statusCode}',
        };
      }
    } catch (e) {
      return {'success': false, 'message': 'Error: $e'};
    }
  }
}

Future<Map<String, dynamic>> getUserInfo(int userId) async {
  final response = await http.get(
    Uri.parse('${ApiEndPoints.base}/users/$userId'),
  );
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to fetch user info');
  }
}

class ApiEndPoints {
  static final String base = 'https://laundryku.rplrus.com/api';
  static _AuthEndPoints authEndpoints = _AuthEndPoints();
}

class _AuthEndPoints {
  final String registerEmail = '/register';
  final String loginEmail = '/login';
}
