// Improved Order Page
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyOrderCard extends StatelessWidget {
  final String name;
  final String status;
  final String estimatedTime;
  final String orderDate;
  final String imagePath;
  final IconData actionIcon;

  const MyOrderCard({
    super.key,
    required this.name,
    required this.status,
    required this.estimatedTime,
    required this.orderDate,
    required this.imagePath,
    required this.actionIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16, left: 8, right: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            spreadRadius: 1 ,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        decoration: BoxDecoration(
          color: const Color(0xFF00ADB5),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                imagePath,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Status: $status',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Perkiraan selesai: $estimatedTime',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Tanggal pesanan: $orderDate',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(8),
              child: Icon(
                actionIcon,
                color: const Color(0xFF00ADB5),
                size: 22,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OrderItem {
  final String imagePath;
  final String name;
  final String status;
  final String estimatedTime;
  final String orderDate;
  final IconData actionIcon;

  OrderItem({
    required this.imagePath,
    required this.name,
    required this.status,
    required this.estimatedTime,
    required this.orderDate,
    required this.actionIcon,
  });
}
