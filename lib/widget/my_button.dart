// Enhanced MyButton component using MyText
import 'package:flutter/material.dart';
import 'package:laundryku/widget/my_text.dart';

class MyButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final Color color;
  final Color? textColor;
  final Color? loadingColor;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final double fontSize;
  final double borderRadius;
  final FontWeight fontWeight;
  final Widget? icon;
  final bool iconAfterText;
  final TextAlign? textAlign;
  final double? elevation;
  final bool useMyText;

  const MyButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    required this.color,
    this.textColor = Colors.white,
    this.loadingColor = Colors.white,
    this.width,
    this.height = 50.0,
    this.margin,
    this.padding,
    this.fontSize = 16.0,
    this.borderRadius = 30.0,
    this.fontWeight = FontWeight.normal,
    this.icon,
    this.iconAfterText = false,
    this.textAlign,
    this.elevation,
    this.useMyText = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          margin ?? const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
      child: SizedBox(
        height: height,
        width: width,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            foregroundColor: textColor,
            padding: padding ?? const EdgeInsets.symmetric(vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            elevation: elevation,
          ),
          onPressed: isLoading ? null : onPressed,
          child: isLoading
              ? SizedBox(
                  height: 24,
                  width: 24,
                  child: CircularProgressIndicator(color: loadingColor),
                )
              : _buildButtonContent(),
        ),
      ),
    );
  }

  Widget _buildButtonContent() {
    Widget textWidget = useMyText
        ? MyText(
            text: text,
            fontSize: fontSize,
            fontWeight: fontWeight,
            color: textColor ?? Colors.white,
            textAlign: textAlign,
          )
        : Text(
            text,
            style: TextStyle(
              fontSize: fontSize,
              color: textColor,
              fontWeight: fontWeight,
            ),
            textAlign: textAlign,
          );

    if (icon == null) {
      return textWidget;
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: iconAfterText
          ? [
              Flexible(child: textWidget),
              SizedBox(width: 8),
              icon!,
            ]
          : [
              icon!,
              SizedBox(width: 8),
              Flexible(child: textWidget),
            ],
    );
  }
}
