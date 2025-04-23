import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundryku/data/PostController.dart';
import 'package:laundryku/widget/my_category_dropDown.dart';
import 'package:laundryku/widget/my_laundry_card.dart';
import 'package:laundryku/widget/my_search_bar.dart';
import 'package:laundryku/widget/my_text.dart';

class LaundryListPage extends StatefulWidget {
  LaundryListPage({super.key});

  @override
  State<LaundryListPage> createState() => _LaundryListPageState();
}

class _LaundryListPageState extends State<LaundryListPage> {
  final PostController postController = Get.put(PostController());

  String selectedCategory = 'Category';
  List<LaundryItem> filteredItems = [];
  final List<String> categories = [
    'Semua',
    'Cuci Pakaian',
    'Cuci Sprei',
    'Cuci Tas',
    'Cuci Sepatu',
    'Cuci Helm',
    'Setrika Pakaian',
  ];

  final List<LaundryItem> allItems = [
    LaundryItem(
      imageUrl:
          'https://i.pinimg.com/736x/3a/5c/53/3a5c53166f8b0d3e479f251659032234.jpg',
      name: 'Bening Laundry',
      services: [
        'Cuci Pakaian',
        'Cuci Sprei',
      ],
    ),
    LaundryItem(
      imageUrl:
          'https://i.pinimg.com/736x/3a/5c/53/3a5c53166f8b0d3e479f251659032234.jpg',
      name: 'Bening Laundry',
      services: [
        'Cuci Pakaian',
        'Cuci Sprei',
        'Cuci Tas',
      ],
    ),
    LaundryItem(
      imageUrl:
          'https://i.pinimg.com/736x/3a/5c/53/3a5c53166f8b0d3e479f251659032234.jpg',
      name: 'DevClean',
      services: ['Cuci Helm', 'Cuci Sepatu'],
    ),
    LaundryItem(
      imageUrl:
          'https://i.pinimg.com/736x/3a/5c/53/3a5c53166f8b0d3e479f251659032234.jpg',
      name: 'DevClean',
      services: ['Cuci Helm', 'Cuci Sepatu'],
    ),
  ];

  @override
  void initState() {
    super.initState();
    filteredItems = allItems;
  }

  void filterLaundryItems(String category) {
    setState(() {
      if (category == 'Semua' || category == 'Category') {
        filteredItems = allItems;
      } else {
        filteredItems =
            allItems.where((item) => item.services.contains(category)).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: const Row(
                  children: [
                    Icon(Icons.arrow_back_ios, size: 18),
                    SizedBox(width: 2),
                    MyText(
                      text: 'kembali',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const MyText(
                text: "List Semua Laundry",
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF000000),
              ),
              const SizedBox(height: 16),
              const Search(),
              const SizedBox(height: 8),
              CategoryDropdown(
                categories: categories,
                onCategorySelected: filterLaundryItems,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: postController.postList.length,
                  itemBuilder: (context, index) {
                    final post = postController.postList[index];
                    return MyLaundryCard(
                      laundry: filteredItems[index],
                      nama: post.nama,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
