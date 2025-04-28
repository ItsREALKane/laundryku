import 'package:laundryku/data/model/laundry.dart';

class Admin {
  final int id;
  final String name;
  final int idLaundry;
  final String password;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Laundry laundry;

  Admin({
    required this.id,
    required this.name,
    required this.idLaundry,
    required this.password,
    required this.createdAt,
    required this.updatedAt,
    required this.laundry,
  });

  factory Admin.fromJson(Map<String, dynamic> json) {
    return Admin(
      id: int.parse(json['id'].toString()),
      name: json['name'],
      idLaundry: int.parse(json['id_laundry'].toString()),
      password: json['password'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      laundry: Laundry.fromJson(json['laundry']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'id_laundry': idLaundry,
      'password': password,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'laundry': laundry.toJson(),
    };
  }
}
