import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundryku/data/post_controller.dart';
import 'package:laundryku/favorite/controllers/favorite_controller.dart';
import 'package:laundryku/route/my_app_route.dart';
import 'package:laundryku/widget/my_laundry_card.dart';
import 'package:laundryku/widget/my_search_bar.dart';
import 'package:laundryku/widget/my_text.dart';

class FavoritePage extends StatelessWidget {
  FavoritePage({super.key});
  final PostController postController = Get.put(PostController());
  final FavoriteController favoriteController = Get.put(FavoriteController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            child: Image.asset(
              'assets/image/busa2.png',
              width: 140,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Image.asset(
              'assets/image/busa.png',
              width: 140,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                const MyText(
                  text: "Favorit",
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF000000),
                ),
                const SizedBox(height: 12),
                const Search(),
                const SizedBox(height: 12),
                Expanded(
                  child: Obx(() {
                    final favoriteList = favoriteController.favoriteList;
                    if (favoriteList.isEmpty) {
                      return const Center(child: Text("Belum ada favorit"));
                    }

                    return ListView.builder(
                      itemCount: favoriteList.length,
                      itemBuilder: (context, index) {
                        final laundry = favoriteList[index];
                        return MyLaundryCard(
                          laundry: laundry,
                          onTap: () {
                            Get.toNamed(
                              MyappRoute.laundryDetailPage,
                              arguments: laundry, 
                            );
                          },
                          trailing: IconButton(
                            icon: const Icon(Icons.favorite, color: Colors.red),
                            onPressed: () {
                              favoriteController.toggleFavorite(laundry);
                            },
                          ),
                        );
                      },
                    );
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
