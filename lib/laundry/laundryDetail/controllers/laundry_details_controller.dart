import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundryku/data/model/laundry.dart';
import 'package:laundryku/data/model/order.dart';
import 'package:laundryku/data/service/API_service.dart';
import 'package:laundryku/favorite/controllers/favorite_controller.dart';
import 'package:http/http.dart' as http;

class PriceItem {
  final int id;
  final String namaItem;
  final String harga;
  final String? satuan;

  PriceItem({
    required this.id,
    required this.namaItem,
    required this.harga,
    this.satuan,
  });

  factory PriceItem.fromJson(Map<String, dynamic> json) {
    return PriceItem(
      id: json['id'],
      namaItem: json['nama_item'],
      harga: json['harga'],
      satuan: json['satuan'],
    );
  }
}

class PriceCategory {
  final int id;
  final int idLaundry;
  final String jenisHarga;
  final List<PriceItem> detailHargas;

  PriceCategory({
    required this.id,
    required this.idLaundry,
    required this.jenisHarga,
    required this.detailHargas,
  });

  factory PriceCategory.fromJson(Map<String, dynamic> json) {
    var detailList = json['detail_hargas'] as List;
    List<PriceItem> detailItems =
        detailList.map((item) => PriceItem.fromJson(item)).toList();

    return PriceCategory(
      id: json['id'],
      idLaundry: json['id_laundry'],
      jenisHarga: json['jenis_harga'],
      detailHargas: detailItems,
    );
  }
}

class LaundryDetailsController extends GetxController {
  final ApiService _orderService = ApiService();
  final FavoriteController favoriteController = Get.find();

  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final pickupTimeController = TextEditingController();
  final notesController = TextEditingController();

  final RxBool isSelfPickup = false.obs;
  final RxBool isLoading = false.obs;
  final Rx<int?> userId = Rx<int?>(null);
  final Rx<Laundry?> selectedLaundry = Rx<Laundry?>(null);

  final RxBool isLoadingPrices = true.obs;
  final RxList<PriceCategory> priceCategories = <PriceCategory>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadUserId();
    fetchPriceDetails();
  }

  @override
  void onClose() {
    phoneController.dispose();
    addressController.dispose();
    pickupTimeController.dispose();
    notesController.dispose();
    super.onClose();
  }

  Future<void> _loadUserId() async {
    final id = await _orderService.getUserId();
    userId.value = id;
    print('Loaded user ID in LaundryDetailsController: $id');
  }

  void setSelectedLaundry(Laundry laundry) {
    selectedLaundry.value = laundry;
  }

  void toggleSelfPickup(bool value) {
    isSelfPickup.value = value;
  }

  IconData getIconForService(String name) {
    switch (name.toLowerCase()) {
      case 'delivery':
        return Icons.local_shipping_outlined;
      case 'pick up':
        return Icons.shopping_bag_outlined;
      case 'antar':
        return Icons.delivery_dining_outlined;
      case 'ambil':
        return Icons.storefront_outlined;
      default:
        return Icons.miscellaneous_services;
    }
  }

//price details
  Future<void> fetchPriceDetails() async {
    isLoadingPrices.value = true;
    try {
      final response = await http
          .get(Uri.parse('https://laundryku.rplrus.com/api/detailHarga'));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        if (jsonData['status'] == true && jsonData['data'] != null) {
          final List<dynamic> data = jsonData['data'];
          priceCategories.value =
              data.map((item) => PriceCategory.fromJson(item)).toList();
          print('Price details loaded: ${priceCategories.length} categories');
        } else {
          print('API returned success=false or no data');
        }
      } else {
        print(
            'Failed to load price details. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching price details: $e');
    } finally {
      isLoadingPrices.value = false;
    }
  }
  List<PriceCategory> getPriceByLaundryId(int laundryId) {
    return priceCategories.where((category) => category.idLaundry == laundryId).toList();
  }

  // Get prices for the selected laundry
  List<PriceCategory> getPrices() {
    if (selectedLaundry.value == null) return [];
    return getPriceByLaundryId(selectedLaundry.value!.id);
  }

  // Get kiloan prices specifically
  List<PriceItem> getKiloanPrices() {
    final prices = getPrices();
    final kiloanCategory = prices.firstWhereOrNull(
      (category) => category.jenisHarga.toLowerCase() == 'kiloan'
    );
    
    if (kiloanCategory != null) {
      return kiloanCategory.detailHargas;
    }
    return [];
  }

  // Get satuan prices specifically
  List<PriceItem> getSatuanPrices() {
    final prices = getPrices();
    final satuanCategory = prices.firstWhereOrNull(
      (category) => category.jenisHarga.toLowerCase() == 'satuan'
    );
    
    if (satuanCategory != null) {
      return satuanCategory.detailHargas;
    }
    return [];
  }
  String formatPrice(String price) {
    try {
      double numPrice = double.parse(price);
      if (numPrice == numPrice.toInt()) {
        return "Rp${numPrice.toInt().toString().replaceAllMapped(
              RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}";
      } else {
        return "Rp${numPrice.toStringAsFixed(0).replaceAllMapped(
              RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}";
      }
    } catch (e) {
      return "Rp$price";
    }
  }


  bool validateForm() {
    if (phoneController.text.isEmpty) {
      showErrorDialog('Nomor telepon harus diisi');
      return false;
    }

    if (addressController.text.isEmpty) {
      showErrorDialog('Alamat harus diisi');
      return false;
    }

    if (pickupTimeController.text.isEmpty) {
      showErrorDialog('Waktu ambil laundry harus diisi');
      return false;
    }

    return true;
  }

  Future<void> createOrder(Laundry laundry) async {
    // Form
    if (!validateForm()) {
      return;
    }

    isLoading.value = true;

    try {
      if (userId.value == null) {
        final loadedId = await _orderService.getUserId();
        if (loadedId == null) {
          showErrorDialog('User ID tidak ditemukan. Silakan login kembali.');
          isLoading.value = false;
          return;
        }
        userId.value = loadedId;
        print('User ID berhasil diambil: ${userId.value}');
      }

      final now = DateTime.now();
      final String formattedDate =
          "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";
      final futureDate = now.add(const Duration(days: 30));
      final String formattedFutureDate =
          "${futureDate.year}-${futureDate.month.toString().padLeft(2, '0')}-${futureDate.day.toString().padLeft(2, '0')}";

      print("Creating order with user ID: ${userId.value}");
      print("Creating order with laundry ID: ${laundry.id}");

      final order = Order(
        idUser: userId.value,
        idLaundry: laundry.id,
        tanggalPesanan: formattedDate,
        status: 'Menunggu Konfirmasi',
        totalHarga: '0',
        jenisPembayaran: 'sekali',
        tglLanggananBerakhir: formattedFutureDate,
        alamat: addressController.text,
        waktuAmbil: pickupTimeController.text,
        catatan: notesController.text,
        antarSendiri: isSelfPickup.value,
        nomorHp: phoneController.text,
        namaLaundry: laundry.nama,
      );

      print("Order created with user ID: ${order.idUser}");

      final result = await _orderService.createOrder(order);

      if (result['success']) {
        showSuccessDialog(result['message']);
        phoneController.clear();
        addressController.clear();
        pickupTimeController.clear();
        notesController.clear();
        isSelfPickup.value = false;
      } else {
        final errorMessage = result['message'] ?? 'Unknown error';
        final statusCode = result['status_code'] ?? 'N/A';
        showErrorDialog('Error ($statusCode): $errorMessage');
      }
    } catch (e) {
      print('Exception in createOrder: $e');
      showErrorDialog('Terjadi kesalahan: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void showSuccessDialog(String message) {
    Get.dialog(
      AlertDialog(
        title: const Text('Sukses'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Get.back(); 
              Get.back(); 
            },
            child: const Text('OK', style: TextStyle(color: Color(0xFF00ADB5))),
          ),
        ],
      ),
    );
  }

  void showErrorDialog(String message) {
    Get.dialog(
      AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('OK', style: TextStyle(color: Color(0xFF00ADB5))),
          ),
        ],
      ),
    );
  }
}
