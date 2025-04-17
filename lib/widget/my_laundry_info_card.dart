import 'package:flutter/material.dart';
import 'package:laundryku/widget/my_text.dart';

class LaundryInfoCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<LaundryService> services;
  final Color backgroundColor;
  final Color textColor;
  final double borderRadius;
  final EdgeInsets padding;
  final double elevation;

  const LaundryInfoCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.services,
    this.backgroundColor = const Color(0xFF71C9CE),
    this.textColor = Colors.white,
    this.borderRadius = 12.0,
    this.padding = const EdgeInsets.all(16.0),
    this.elevation = 2.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      margin: EdgeInsets.zero,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        padding: padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyText(
              text: title,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
            const SizedBox(height: 4),
            MyText(
              text: subtitle,
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: textColor.withOpacity(0.9),
            ),
            const SizedBox(height: 16),
            Row(
              children: services.map((service) {
                return Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Row(
                    children: [
                      Icon(
                        service.icon,
                        color: textColor,
                        size: 20,
                      ),
                      const SizedBox(width: 6),
                      MyText(
                        text: service.name,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: textColor,
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class LaundryService {
  final String name;
  final IconData icon;

  const LaundryService({
    required this.name,
    required this.icon,
  });
}
