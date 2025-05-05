import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyDetailsLaundryTextfield extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final int maxLines;

  const MyDetailsLaundryTextfield({
    super.key,
    required this.hintText,
    required this.controller,
    this.keyboardType,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        style: GoogleFonts.poppins(),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: GoogleFonts.poppins(color: Colors.grey),
          filled: true,
          fillColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF00ADB5), width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF00ADB5), width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.red, width: 2),
          ),
        ),
      ),
    );
  }
}
