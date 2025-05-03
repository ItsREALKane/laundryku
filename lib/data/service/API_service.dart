import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:laundryku/data/model/laundry.dart';
import 'package:laundryku/data/model/order.dart';
import 'package:shared_preferences/shared_preferences.dart'; 

class ApiService {
  final String baseUrl = 'https://laundryku.rplrus.com/api';

  Future<int?> getUserId() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getInt('user_id');
    } catch (e) {
      print('Error loading user ID: $e');
      return null;
    }
  }

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

  Future<Map<String, dynamic>> createOrder(Order order) async {
    try {
      // Ensure userId is not null
      if (order.idUser == null) {
        return {
          'success': false,
          'message': 'User ID tidak tersedia. Silakan login kembali.'
        };
      }

      // Convert boolean to int/string as needed by the API
      final orderData = order.toJson();
      
      // Convert boolean to int (1 for true, 0 for false)
      orderData['antar_sendiri'] = order.antarSendiri ? 1 : 0;
      
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
      
      // Handle successful creation
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
          // If response body is not valid JSON
          return {
            'success': true,
            'data': {'message': 'Pesanan berhasil dibuat'},
            'message': 'Pesanan berhasil dibuat'
          };
        }
      } 
      // Handle error responses
      else {
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
      return {
        'success': false,
        'message': 'Terjadi kesalahan koneksi: $e'
      };
    }
  }
}