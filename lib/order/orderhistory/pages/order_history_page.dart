// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:laundryku/widget/my_order_history_card.dart';
// import 'package:laundryku/widget/my_search_bar.dart';
// import 'package:laundryku/widget/my_text.dart';

// class OrderHistoryPage extends StatelessWidget {
//   const OrderHistoryPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final orders = [
//       MyOrderHistoryCard(
//         name: 'Bening Laundry',
//         serviceType: 'Pakaian 5 kilo, sepatu',
//         orderDate: '18/01/2024',
//         totalPrice: 'Rp. 30.000',
//         imagePath: 'assets/image/coba.jpeg',
//       ),
//       MyOrderHistoryCard(
//         name: 'Bening Laundry',
//         serviceType: 'Pakaian 5 kilo, sepatu',
//         orderDate: '18/01/2024',
//         totalPrice: 'Rp. 30.000',
//         imagePath: 'assets/image/coba.jpeg',
//       ),
//     ];

//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Container(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               GestureDetector(
//                 onTap: () {
//                   Get.back();
//                 },
//                 child: const Row(
//                   children: [
//                     Icon(Icons.arrow_back_ios, size: 18),
//                     SizedBox(width: 2),
//                     Text(
//                       'Kembali',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 20),
//               const MyText(
//                 text: "Riwayat pesanan",
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: Color(0xFF000000),
//               ),
//               const SizedBox(height: 16),
//               const Search(),
//               const SizedBox(height: 16),
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: orders.length,
//                   padding: const EdgeInsets.symmetric(vertical: 2),
//                   itemBuilder: (context, index) {
//                     return MyOrderHistoryCard(
//                       name: orders[index].name,
//                       orderDate: orders[index].orderDate,
//                       serviceType: orders[index].serviceType,
//                       totalPrice: orders[index].totalPrice,
//                       imagePath: orders[index].imagePath,
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
