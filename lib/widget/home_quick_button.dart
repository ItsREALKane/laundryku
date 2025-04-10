import 'package:flutter/material.dart';

class HomeQuickButton extends StatelessWidget {
  final IconData icon;
  final double size;
  final VoidCallback onTap;

  const HomeQuickButton({
    Key? key,
    required this.icon,
    this.size = 80,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: Color(0xFF00ADB5),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 4,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Center(
          child: Icon(
            icon,
            color: Colors.white,
            size: 40,
          ),
        ),
      ),
    );
  }
}
