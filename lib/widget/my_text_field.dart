import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  final String hintText;
  final bool isObscure;
  final TextEditingController controller;

  const MyTextField({
    Key? key,
    required this.hintText,
    required this.controller,
    this.isObscure = false,
  }) : super(key: key);

  @override
  _MyTextFieldState createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 50, right: 50, bottom: 10),
      child: SizedBox(
        height: 50,
        width: double.infinity,
        child: TextField(
          controller: widget.controller,
          obscureText: widget.isObscure && !_isPasswordVisible,
          decoration: InputDecoration(
            hintText: widget.hintText,
            fillColor: Color(0xFFE4E5E9),
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 20),
            suffixIcon: widget.isObscure
                ? IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  )
                : null,
          ),
        ),
      ),
    );
  }
}
