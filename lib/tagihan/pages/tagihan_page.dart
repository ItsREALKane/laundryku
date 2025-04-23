import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundryku/data/PostController.dart';
import 'package:laundryku/widget/my_laundry_card.dart';
import 'package:laundryku/widget/my_search_bar.dart';
import 'package:laundryku/widget/my_text.dart';

class TagihanPage extends StatelessWidget {
  TagihanPage({super.key});
  final PostController postController = Get.put(PostController());

  final List<LaundryItem> favoriteItems = [
    LaundryItem(
      imageUrl:
          'https://i.pinimg.com/736x/3a/5c/53/3a5c53166f8b0d3e479f251659032234.jpg',
      name: 'Bening Laundry',
      totalTagihan: 'Total Tagihan: Rp. 30.000',
       
    ),
    LaundryItem(
      imageUrl:
          'https://i.pinimg.com/736x/3a/5c/53/3a5c53166f8b0d3e479f251659032234.jpg',
      name: 'Naruto Laundry',
       
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            child: Image.asset(
              'assets/image/busa.png',
              width: 140,
            ),
          ),
          Container(
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
                const SizedBox(height: 30),
                const MyText(
                  text: "Tagihan",
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF000000),
                ),
                const SizedBox(height: 12),
                const Search(),
                const SizedBox(height: 12),
                Expanded(
                  child: ListView.builder(
                  itemCount: postController.postList.length,
                  itemBuilder: (context, index) {
                    final post = postController.postList[index];
                    return MyLaundryCard(
                      laundry: favoriteItems[index],
                      nama: post.nama,
                    );
                  },
                ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
