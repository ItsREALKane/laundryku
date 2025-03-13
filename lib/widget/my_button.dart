import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final Color color;

  const MyButton(
      {required this.text,
      required this.onPressed,
      this.isLoading = false,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 50, right: 50, bottom: 10),
      child: SizedBox(
        height: 50,
        width: double.infinity, 
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            padding:
                const EdgeInsets.symmetric(vertical: 10), 
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          onPressed: isLoading ? null : onPressed,
          child: isLoading
              ? const CircularProgressIndicator(color: Colors.white)
              : Text(
                  text,
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
        ),
      ),
    );
  }
}
