import 'package:flutter/material.dart';
import 'package:laundryku/widget/my_text.dart';

class MyDescriptionDropdown extends StatefulWidget {
  final String title;
  final Widget content;
  final Color titleColor;
  final double titleFontSize;
  final FontWeight titleFontWeight;
  final bool initiallyExpanded;
  final EdgeInsets contentPadding;
  final Color contentBackgroundColor;
  
  const MyDescriptionDropdown({
    Key? key,
    required this.title,
    required this.content,
    this.titleColor = const Color(0xFF00ADB5),
    this.titleFontSize = 18,
    this.titleFontWeight = FontWeight.bold,
    this.initiallyExpanded = false,
    this.contentPadding = const EdgeInsets.all(12),
    this.contentBackgroundColor = const Color(0xFFF5F5F5),
  }) : super(key: key);

  @override
  State<MyDescriptionDropdown> createState() => _MyDescriptionDropdownState();
}

class _MyDescriptionDropdownState extends State<MyDescriptionDropdown> {
  late bool _isExpanded;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.initiallyExpanded;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyText(
                  text: widget.title,
                  fontSize: widget.titleFontSize,
                  fontWeight: widget.titleFontWeight,
                  color: widget.titleColor,
                ),
                Icon(
                  _isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                  color: widget.titleColor,
                ),
              ],
            ),
          ),
        ),
        AnimatedCrossFade(
          firstChild: Container(),
          secondChild: Container(
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 10),
            padding: widget.contentPadding,
            decoration: BoxDecoration(
              color: widget.contentBackgroundColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: widget.content,
          ),
          crossFadeState: _isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 300),
        ),
        const Divider(),
      ],
    );
  }
}