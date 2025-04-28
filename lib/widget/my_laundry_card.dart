import 'package:flutter/material.dart';
import 'package:laundryku/data/model/laundry.dart'; 
import 'package:laundryku/widget/my_text.dart';

class MyLaundryCard extends StatelessWidget {
  final Laundry laundry;
  final VoidCallback? onTap;
  final Widget? trailing; 

  const MyLaundryCard({
    super.key,
    required this.laundry,
    this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> jasaList =
        laundry.jasa.split(',').map((e) => e.trim()).toList();

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16, left: 8, right: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 6,
              spreadRadius: 0,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFF71C9CE),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  laundry.img,
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(
                      text: laundry.nama,
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 6),
                    Wrap(
                      spacing: 6,
                      runSpacing: 4,
                      children: jasaList.map((jasa) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFF00ADB5),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: MyText(
                            text: jasa,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
