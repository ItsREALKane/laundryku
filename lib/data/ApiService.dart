import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:laundryku/data/Laundry.dart';

class ApiService {
  final String baseUrl = 'https://laundryku.rplrus.com';

Future<List<Laundry>> fetchLaundries() async {
  final response = await http.get(Uri.parse('$baseUrl/api/laundry'));

  print("Status code: ${response.statusCode}");
  print("Response body: ${response.body}");

  if (response.statusCode == 200) {
    List<dynamic> jsonData = jsonDecode(response.body);

    // Mengembalikan list Laundry
    return jsonData.map((item) => Laundry.fromJson(item)).toList();
  } else {
    throw Exception('Gagal memuat data laundry');
  }
}


}