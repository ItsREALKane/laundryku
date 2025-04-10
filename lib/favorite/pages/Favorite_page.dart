import 'package:flutter/material.dart';
import 'package:laundryku/widget/my_laundry_card.dart';
import 'package:laundryku/widget/my_search_bar.dart';
import 'package:laundryku/widget/my_text.dart';

class FavoritePage extends StatelessWidget {
  FavoritePage({super.key});

  final List<LaundryItem> favoriteItems = [
    LaundryItem(
      imageUrl:
          'https://i.pinimg.com/736x/3a/5c/53/3a5c53166f8b0d3e479f251659032234.jpg',
      name: 'Bening Laundry',
      services: [
        'Cuci Pakaian',
        'Cuci Sprei',
        'Cuci Tas',
        'OKOKOKOKOKO',
        'OKOKOKOK',
      ],
    ),
    LaundryItem(
      imageUrl:
          'https://i.pinimg.com/736x/3a/5c/53/3a5c53166f8b0d3e479f251659032234.jpg',
      name: 'Naruto Laundry',
      services: ['Cuci Pakaian', 'Setrika Pakaian'],
    ),
    LaundryItem(
      imageUrl:
          'https://i.pinimg.com/736x/3a/5c/53/3a5c53166f8b0d3e479f251659032234.jpg',
      name: 'Example Laundry',
      services: ['Cuci Pakaian', 'Setrika Pakaian'],
    ),
    LaundryItem(
      imageUrl:
          'https://i.pinimg.com/736x/3a/5c/53/3a5c53166f8b0d3e479f251659032234.jpg',
      name: 'Naruto Laundry',
      services: ['Cuci Pakaian'],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
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
              child: ListView.builder(
                itemCount: favoriteItems.length,
                itemBuilder: (context, index) {
                  return MyLaundryCard(laundry: favoriteItems[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
