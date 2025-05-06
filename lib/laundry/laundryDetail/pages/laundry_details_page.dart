// lib/pages/laundry_details_page.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundryku/data/model/order.dart';
import 'package:laundryku/data/model/laundry.dart';
import 'package:laundryku/data/service/API_service.dart';
import 'package:laundryku/favorite/controllers/favorite_controller.dart';
import 'package:laundryku/widget/my_button.dart';
import 'package:laundryku/widget/my_description_dropDown.dart';
import 'package:laundryku/widget/my_details_laundry_textField.dart';
import 'package:laundryku/widget/my_laundry_info_card.dart';
import 'package:laundryku/widget/my_text.dart';

class LaundryDetailsPage extends StatefulWidget {
  final Laundry laundry;

  const LaundryDetailsPage({super.key, required this.laundry});

  @override
  State<LaundryDetailsPage> createState() => _LaundryDetailsPageState();
}

class _LaundryDetailsPageState extends State<LaundryDetailsPage> {
  final FavoriteController favoriteController = Get.find();
  final ApiService _orderService = ApiService();

  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final pickupTimeController = TextEditingController();
  final notesController = TextEditingController();
  bool isSelfPickup = false;
  bool isLoading = false;
  int? userId;

  @override
  void initState() {
    super.initState();
    _loadUserId();
  }
  
  Future<void> _loadUserId() async {
    final id = await _orderService.getUserId();
    setState(() {
      userId = id;
    });
    print('Loaded user ID in LaundryDetailsPage: $id');
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final imageHeight = screenHeight * 0.25;
    final cardHeight = 120.0;
    final laundry = widget.laundry;
    final image = (laundry.img.isEmpty)
        ? 'https://via.placeholder.com/600x300?text=No+Image'
        : laundry.img;

    final nama = laundry.nama.isEmpty ? "Nama tidak tersedia" : laundry.nama;
    final jasa = laundry.jasa.isEmpty ? "Layanan tidak tersedia" : laundry.jasa;
    final alamat =
        laundry.alamat.isEmpty ? "Alamat tidak tersedia" : laundry.alamat;
    final nomor = laundry.nomor.isEmpty ? "-" : laundry.nomor;

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Container(
            height: imageHeight,
            width: double.infinity,
            child: Image.network(image, fit: BoxFit.cover,
                errorBuilder: (c, e, s) {
              return Container(
                color: Colors.grey[300],
                child: const Center(child: Text("Gagal memuat gambar")),
              );
            }),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: imageHeight - 10),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: cardHeight / 2 + 20),
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MyDescriptionDropdown(
                                  title: 'Estimasi Harga',
                                  content: _buildPriceContent(),
                                ),
                                MyDescriptionDropdown(
                                  title: 'Lokasi',
                                  content: _buildLocationContent(alamat, nomor),
                                ),
                                const SizedBox(height: 12),
                                MyDetailsLaundryTextfield(
                                  hintText: 'No. Telpon',
                                  controller: phoneController,
                                  keyboardType: TextInputType.phone,
                                ),
                                MyDetailsLaundryTextfield(
                                  hintText: 'Alamat',
                                  controller: addressController,
                                  maxLines: 3,
                                ),
                                MyDetailsLaundryTextfield(
                                  hintText: 'Waktu Ambil Laundry',
                                  controller: pickupTimeController,
                                ),
                                MyDetailsLaundryTextfield(
                                  hintText: 'Catatan',
                                  controller: notesController,
                                  maxLines: 3,
                                ),
                                Row(
                                  children: [
                                    MyText(
                                      text: 'Antar sendiri',
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                    ),
                                    Switch(
                                      value: isSelfPickup,
                                      onChanged: (val) =>
                                          setState(() => isSelfPickup = val),
                                      activeColor: const Color(0xFF00ADB5),
                                      inactiveTrackColor: Colors.white,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 120),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: -cardHeight / 3,
                      left: 60,
                      right: 60,
                      child: LaundryInfoCard(
                        title: nama,
                        subtitle: jasa,
                        services: laundry.pengantaran
                            .split(',')
                            .map((e) => e.trim())
                            .map((name) => LaundryService(
                                  name: name,
                                  icon: _getIconForService(name),
                                ))
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            left: 10,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.7),
                borderRadius: BorderRadius.circular(20),
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Get.back(),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 2,
                    offset: Offset(0, -1),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Obx(() {
                    final isFavorited = favoriteController.isFavorite(laundry);
                    return MyButton(
                      text: '',
                      onPressed: () {
                        favoriteController.toggleFavorite(laundry);
                      },
                      color: isFavorited ? Colors.red : Colors.grey.shade300,
                      borderRadius: 12,
                      width: 60,
                      height: 60,
                      margin: EdgeInsets.zero,
                      padding: EdgeInsets.zero,
                      icon: Icon(
                        isFavorited ? Icons.favorite : Icons.favorite_border,
                        color: Colors.white,
                        size: 25,
                      ),
                    );
                  }),
                  const SizedBox(width: 10),
                  MyButton(
                    text: '',
                    onPressed: () {},
                    color: Colors.grey.shade200,
                    borderRadius: 12,
                    width: 60,
                    height: 60,
                    margin: EdgeInsets.zero,
                    padding: EdgeInsets.zero,
                    icon: const Icon(
                      Icons.chat,
                      color: Color(0xFF00ADB5),
                      size: 25,
                    ),
                    elevation: 0,
                    border: Border.all(color: const Color(0xFF00ADB5)),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: MyButton(
                      text: isLoading ? 'Memproses...' : 'Buat Pesanan',
                      onPressed: isLoading ? null : () => _createOrder(laundry),
                      color: const Color(0xFF00ADB5),
                      icon: isLoading 
                          ? SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                strokeWidth: 2,
                              ),
                            )
                          : const Icon(Icons.add, color: Colors.white),
                      borderRadius: 12,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      margin: EdgeInsets.zero,
                      height: 60,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationContent(String alamat, String nomor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyText(
          text: alamat,
          fontSize: 13,
          color: Colors.black87,
          fontWeight: FontWeight.w500,
        ),
        const SizedBox(height: 4),
        MyText(
          text: "Nomor hp : $nomor",
          fontSize: 13,
          color: Colors.black87,
          fontWeight: FontWeight.w500,
        ),
        const SizedBox(height: 12),
        Container(
          height: 120,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(8)),
          alignment: Alignment.center,
          child: const Icon(Icons.map, size: 40, color: Colors.grey),
        ),
      ],
    );
  }

  IconData _getIconForService(String name) {
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

  Widget _buildPriceContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MyText(
              text: 'Kiloan:',
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
            MyText(
              text: '5.000/KG',
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF00ADB5),
            ),
          ],
        ),
        const SizedBox(height: 8),
        MyText(
          text: 'Satuan:',
          fontSize: 14,
          color: Colors.black,
          fontWeight: FontWeight.w600,
        ),
        const SizedBox(height: 4),
        _buildSatuanItem('Tas', '10.000'),
        _buildSatuanItem('Sprei', '10.000'),
        _buildSatuanItem('Sepatu', '8.000/pasang'),
      ],
    );
  }

  Widget _buildSatuanItem(String name, String price) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, top: 2, bottom: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MyText(
            text: '• $name',
            fontSize: 14,
            color: Colors.black,
            fontWeight: FontWeight.w400,
          ),
          MyText(
            text: price,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF00ADB5),
          ),
        ],
      ),
    );
  }

  Future<void> _createOrder(Laundry laundry) async {
  // Form validation
  if (phoneController.text.isEmpty) {
    _showErrorDialog('Nomor telepon harus diisi');
    return;
  }
  
  if (addressController.text.isEmpty) {
    _showErrorDialog('Alamat harus diisi');
    return;
  }
  
  if (pickupTimeController.text.isEmpty) {
    _showErrorDialog('Waktu ambil laundry harus diisi');
    return;
  }

  // Set loading state
  setState(() {
    isLoading = true;
  });

  try {
    // Check if userId is available
    if (userId == null) {
      final loadedId = await _orderService.getUserId();
      if (loadedId == null) {
        _showErrorDialog('User ID tidak ditemukan. Silakan login kembali.');
        setState(() {
          isLoading = false;
        });
        return;
      }
      userId = loadedId;
      print('User ID berhasil diambil: $userId');
    }

    // Get current date for order date fields
    final now = DateTime.now();
    final String formattedDate = "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";
    final futureDate = now.add(const Duration(days: 30));
    final String formattedFutureDate = "${futureDate.year}-${futureDate.month.toString().padLeft(2, '0')}-${futureDate.day.toString().padLeft(2, '0')}";
    
    // Debug information
    print("Creating order with user ID: $userId");
    print("Creating order with laundry ID: ${laundry.id}");
    
    // Create order object
    final order = Order(
      idUser: userId, // Ayeuna userId pasti aya soalna geus dicek di luhur
      idLaundry: laundry.id,
      tanggalPesanan: formattedDate,
      status: 'Menunggu Konfirmasi',
      totalHarga: '0',
      jenisPembayaran: 'Cash',
      tglLanggananBerakhir: formattedFutureDate,
      alamat: addressController.text,
      waktuAmbil: pickupTimeController.text,
      catatan: notesController.text,
      antarSendiri: isSelfPickup,
      nomorHp: phoneController.text,
      namaLaundry: laundry.nama,
    );
    
    print("Order created with user ID: ${order.idUser}");

    // Use service to create order
    final result = await _orderService.createOrder(order);
    
    if (result['success']) {
      _showSuccessDialog(result['message']);
      
      // Reset form fields
      phoneController.clear();
      addressController.clear();
      pickupTimeController.clear();
      notesController.clear();
      setState(() {
        isSelfPickup = false;
      });
    } else {
      // Show detailed error information
      final errorMessage = result['message'] ?? 'Unknown error';
      final statusCode = result['status_code'] ?? 'N/A';
      _showErrorDialog('Error ($statusCode): $errorMessage');
    }
  } catch (e) {
    print('Exception in _createOrder: $e');
    _showErrorDialog('Terjadi kesalahan: $e');
  } finally {
    // Reset loading state
    setState(() {
      isLoading = false;
    });
  }
}

  void _showSuccessDialog(String message) {
    Get.dialog(
      AlertDialog(
        title: const Text('Sukses'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Get.back(); // Close dialog
              Get.back(); // Go back to previous screen
            },
            child: const Text('OK', style: TextStyle(color: Color(0xFF00ADB5))),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(String message) {
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