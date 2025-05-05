import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundryku/data/model/laundry.dart';
import 'package:laundryku/data/api_controller.dart';
import 'package:laundryku/route/my_app_route.dart';
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
  final ApiController postController = Get.put(ApiController());
  String selectedCategory = 'Semua';
  List<String> categories = ['Semua'];

  @override
  void initState() {
    super.initState();
    _populateCategories();
  }

  void _populateCategories() {
    List<String> allCategories = ['Semua'];

    for (var laundry in postController.postList) {
      final categoriesFromLaundry = laundry.getCategories();
      for (var category in categoriesFromLaundry) {
        if (!allCategories.contains(category)) {
          allCategories.add(category);
        }
      }
    }

    setState(() {
      categories = allCategories;
    });
  }

  List<Laundry> filterByCategory(List<Laundry> posts, String category) {
    if (category.toLowerCase() == 'semua' ||
        category.toLowerCase() == 'category') {
      return posts;
    }

    return posts.where((item) {
      final jasaList = item.getCategories();
      return jasaList.contains(category.toLowerCase());
    }).toList();
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
                onCategorySelected: (value) {
                  setState(() {
                    selectedCategory = value;
                  });
                },
              ),
              const SizedBox(height: 8),
              Expanded(
                child: Obx(() {
                  if (postController.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final filteredList = filterByCategory(
                    postController.postList,
                    selectedCategory,
                  );

                  if (filteredList.isEmpty) {
                    return const Center(
                      child: MyText(
                        text: 'Tidak ada laundry untuk kategori ini.',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: filteredList.length,
                    itemBuilder: (context, index) {
                      final laundry = filteredList[index];
                      return MyLaundryCard(
                        laundry: laundry,
                        onTap: () {
                          Get.toNamed(
                            MyappRoute.laundryDetailPage,
                            arguments: laundry, // model Laundry
                          );
                        },
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
