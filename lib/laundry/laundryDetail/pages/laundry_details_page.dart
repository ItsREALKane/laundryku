// lib/pages/laundry_details_page.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundryku/data/model/laundry.dart';
import 'package:laundryku/laundry/laundryDetail/controllers/laundry_details_controller.dart';
import 'package:laundryku/widget/my_button.dart';
import 'package:laundryku/widget/my_description_dropDown.dart';
import 'package:laundryku/widget/my_details_laundry_textField.dart';
import 'package:laundryku/widget/my_laundry_info_card.dart';
import 'package:laundryku/widget/my_text.dart';
import 'package:laundryku/widget/my_time_picker.dart';

class LaundryDetailsPage extends StatelessWidget {
  final Laundry laundry;

  const LaundryDetailsPage({super.key, required this.laundry});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LaundryDetailsController());

    // PENTING: Set laundry ID dan ambil harga
    controller.setSelectedLaundry(laundry);
    controller.getPrices();

    final screenHeight = MediaQuery.of(context).size.height;
    final imageHeight = screenHeight * 0.25;
    final cardHeight = 120.0;
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
                          top: Radius.circular(10),
                        ),
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
                                const SizedBox(height: 12),
                                MyText(
                                  text: 'Form Pesanan',
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                const SizedBox(height: 12),
                                // MyDetailsLaundryTextfield(
                                //   hintText: 'No. Telpon',
                                //   controller: controller.phoneController,
                                //   keyboardType: TextInputType.phone,
                                // ),
                                MyDetailsLaundryTextfield(
                                  hintText: 'Alamat',
                                  controller: controller.addressController,
                                  maxLines: 3,
                                ),
                                MyDetailsLaundryTextfield(
                                  hintText: 'Catatan',
                                  controller: controller.notesController,
                                  maxLines: 3,
                                ),
                                Obx(() {
                                  return controller.isSelfPickup.value
                                      ? Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            MyTimePickerTextField(
                                              hintText:
                                                  'Waktu Laundry Siap diambil',
                                              controller: controller
                                                  .pickupTimeController,
                                              validator: (value) {
                                                if (controller
                                                    .isSelfPickup.value) {
                                                  // jangan lupa sini juga
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'Waktu pengambilan harus diisi';
                                                  }
                                                }
                                                return null;
                                              },
                                            ),
                                          ],
                                        )
                                      : const SizedBox.shrink();
                                }),
                                const SizedBox(height: 10),
                                Obx(() => Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const MyText(
                                          text: "Metode Pengantaran",
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                        const SizedBox(height: 8),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            border: Border.all(
                                                color: Color(0xFF00ADB5)),
                                          ),
                                          child: Column(
                                            children: [
                                              CheckboxListTile(
                                                title: const Text(
                                                    "Ambil di Tempat Anda"),
                                                value: controller
                                                    .isSelfPickup.value,
                                                activeColor: Color(0xFF00ADB5),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(18),
                                                ),
                                                onChanged: (val) => controller
                                                    .togglePickupMethod(true),
                                              ),
                                              const Divider(
                                                  height: 0,
                                                  color: Color(0xFF00ADB5)),
                                              CheckboxListTile(
                                                title:
                                                    const Text("Antar sediri"),
                                                value: !controller
                                                    .isSelfPickup.value,
                                                activeColor: Color(0xFF00ADB5),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(18),
                                                ),
                                                onChanged: (val) => controller
                                                    .togglePickupMethod(false),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )),
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
                                  icon: controller.getIconForService(name),
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
                    final isFavorited =
                        controller.favoriteController.isFavorite(laundry);
                    return MyButton(
                      text: '',
                      onPressed: () {
                        controller.favoriteController.toggleFavorite(laundry);
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
                    child: Obx(() => MyButton(
                          text: controller.isLoading.value
                              ? 'Memproses...'
                              : 'Buat Pesanan',
                          onPressed: controller.isLoading.value
                              ? null
                              : () => controller.createOrder(laundry),
                          color: const Color(0xFF00ADB5),
                          icon: controller.isLoading.value
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white),
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
                        )),
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
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.center,
          child: const Icon(Icons.map, size: 40, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildPriceContent() {
    final controller = Get.find<LaundryDetailsController>();

    return Obx(() {
      if (controller.isLoadingPrices.value) {
        return const Center(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF00ADB5)),
            ),
          ),
        );
      }

      final kiloanItems = controller.getKiloanPrices();
      final satuanItems = controller.getSatuanPrices();

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Kiloan section
          MyText(
            text: 'Kiloan:',
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
          const SizedBox(height: 4),
          if (kiloanItems.isEmpty)
            const Padding(
              padding: EdgeInsets.only(left: 12),
              child: Text(
                'Tidak ada harga kiloan tersedia',
                style: TextStyle(fontSize: 13, color: Colors.grey),
              ),
            )
          else
            ...kiloanItems.map(
              (item) => _buildPriceItem('• ${item.namaItem}',
                  '${controller.formatPrice(item.harga)}/${item.satuan ?? "KG"}'),
            ),

          const SizedBox(height: 16),

          // Satuan section
          MyText(
            text: 'Satuan:',
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
          const SizedBox(height: 4),
          if (satuanItems.isEmpty)
            const Padding(
              padding: EdgeInsets.only(left: 12),
              child: Text(
                'Tidak ada item satuan tersedia',
                style: TextStyle(fontSize: 13, color: Colors.grey),
              ),
            )
          else
            ...satuanItems.map(
              (item) => _buildPriceItem('• ${item.namaItem}',
                  '${controller.formatPrice(item.harga)}${item.satuan != null ? "/${item.satuan}" : ""}'),
            ),
        ],
      );
    });
  }

  Widget _buildPriceItem(String name, String price) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, top: 2, bottom: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: MyText(
              text: name,
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.w400,
            ),
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
}
