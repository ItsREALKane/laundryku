import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// MyText component
class MyText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;
  final double? letterSpacing;
  final double? height;
  final TextDecoration? decoration;

  const MyText({
    Key? key,
    required this.text,
    required this.fontSize,
    required this.fontWeight,
    required this.color,
    this.textAlign,
    this.overflow,
    this.maxLines,
    this.letterSpacing,
    this.height,
    this.decoration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        letterSpacing: letterSpacing,
        height: height,
        decoration: decoration,
      ),
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
    );
  }
}
