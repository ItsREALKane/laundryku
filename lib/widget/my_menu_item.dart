// Create a new widget file named menu_item.dart
import 'package:flutter/material.dart';
import 'package:laundryku/widget/my_text.dart';

class MenuItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  const MenuItem({
    Key? key,
    required this.icon,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 2,
      ),
      child: ListTile(
        dense: true,
        visualDensity: const VisualDensity(
          horizontal: -4,
          vertical: -2,
        ),
        leading: Icon(
          icon,
          color: Colors.black87,
          size: 22,
        ),
        title: MyText(
          text: text,
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
        onTap: onTap,
      ),
    );
  }
}
