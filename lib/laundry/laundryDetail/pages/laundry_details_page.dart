import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundryku/widget/my_button.dart';
import 'package:laundryku/widget/my_description_dropDown.dart';
import 'package:laundryku/widget/my_details_laundry_textField.dart';
import 'package:laundryku/widget/my_laundry_info_card.dart';
import 'package:laundryku/widget/my_text.dart';

class LaundryDetailsPage extends StatefulWidget {
  const LaundryDetailsPage({super.key});

  @override
  State<LaundryDetailsPage> createState() => _LaundryDetailsPageState();
}

class _LaundryDetailsPageState extends State<LaundryDetailsPage> {
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final pickupTimeController = TextEditingController();
  final notesController = TextEditingController();
  bool isSelfPickup = false;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final imageHeight = screenHeight * 0.25;
    final cardHeight = 120.0;

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Container(
            height: imageHeight,
            width: double.infinity,
            child: Image.asset(
              'assets/image/bg.jpg',
              fit: BoxFit.cover,
            ),
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
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
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
                            padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MyDescriptionDropdown(
                                  title: 'Deskripsi',
                                  content: _buildDescriptionContent(),
                                ),
                                MyDescriptionDropdown(
                                  title: 'Estimasi Harga',
                                  content: _buildPriceContent(),
                                ),
                                MyDescriptionDropdown(
                                  title: 'Lokasi',
                                  content: _buildLocationContent(),
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
                                      onChanged: (val) {
                                        setState(() {
                                          isSelfPickup = val;
                                        });
                                      },
                                      activeColor: const Color(0xFF00ADB5),
                                      inactiveTrackColor: const Color.fromARGB(
                                          255, 255, 255, 255),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                    height:
                                        120), 
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
                        title: 'Bening Laundry',
                        subtitle: 'Pakaian, Sprei, Tas, Boneka',
                        services: const [
                          LaundryService(
                            name: 'Delivery',
                            icon: Icons.local_shipping_outlined,
                          ),
                          LaundryService(
                            name: 'Pick Up',
                            icon: Icons.shopping_bag_outlined,
                          ),
                        ],
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
                onPressed: () {
                  Get.back();
                },
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
                  MyButton(
                    text: '',
                    onPressed: () {},
                    color: Colors.red,
                    borderRadius: 12,
                    width: 60,
                    height: 60,
                    margin: EdgeInsets.zero,
                    padding: EdgeInsets.zero,
                    icon: const Icon(
                      Icons.favorite,
                      color: Colors.white,
                      size: 25,
                    ),
                  ),
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
                      text: 'Buat Pesanan',
                      onPressed: () {},
                      color: const Color(0xFF00ADB5),
                      icon: const Icon(Icons.add, color: Colors.white),
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
              fontWeight: FontWeight.w500,
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
          fontWeight: FontWeight.w500,
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

  Widget _buildDescriptionContent() {
    return MyText(
      text:
          'Bening Laundry menyediakan layanan cuci bersih, wangi, dan rapi. \n\n'
          'Kami menggunakan deterjen ramah lingkungan dan mesin cuci berkualitas tinggi.\n\n'
          'Layanan kami mencakup cuci reguler, cuci express, dan setrika saja.',
      fontSize: 13,
      color: Colors.black87,
      fontWeight: FontWeight.w400,
    );
  }

  Widget _buildLocationContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyText(
          text: 'Jl. Raya Kebayoran Lama No. 12',
          fontSize: 13,
          color: Colors.black87,
          fontWeight: FontWeight.w400,
        ),
        const SizedBox(height: 4),
        MyText(
          text: 'Jakarta Selatan, 12210',
          fontSize: 13,
          color: Colors.black87,
          fontWeight: FontWeight.w400,
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
}
