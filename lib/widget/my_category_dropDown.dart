import 'package:flutter/material.dart';
import 'package:laundryku/widget/my_text.dart';

class CategoryDropdown extends StatefulWidget {
  final List<String> categories;
  final Function(String) onCategorySelected;
  final String initialValue;

  const CategoryDropdown({
    Key? key,
    required this.categories,
    required this.onCategorySelected,
    this.initialValue = 'Kategori',
  }) : super(key: key);

  @override
  State<CategoryDropdown> createState() => _CategoryDropdownState();
}

class _CategoryDropdownState extends State<CategoryDropdown> {
  late String selectedCategory;
  bool isExpanded = false;
  final GlobalKey _key = GlobalKey();
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
    selectedCategory = widget.initialValue;
  }

  @override
  void dispose() {
    _removeDropdown();
    super.dispose();
  }

  void _removeDropdown() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _toggleDropdown() {
    if (isExpanded) {
      _removeDropdown();
    } else {
      _createOverlayEntry();
      Overlay.of(context).insert(_overlayEntry!);
    }
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  void _createOverlayEntry() {
    RenderBox renderBox = _key.currentContext!.findRenderObject() as RenderBox;
    Offset offset = renderBox.localToGlobal(Offset.zero);
    Size size = renderBox.size;

    _overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                _removeDropdown();
                setState(() {
                  isExpanded = false;
                });
              },
            ),
          ),
          Positioned(
            left: offset.dx,
            top: offset.dy + size.height + 5,
            width: 200,
            child: Material(
              color: Colors.transparent,
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: widget.categories.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedCategory = widget.categories[index];
                          isExpanded = false;
                        });
                        widget.onCategorySelected(widget.categories[index]);
                        _removeDropdown();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          border: index < widget.categories.length - 1
                              ? Border(
                                  bottom: BorderSide(
                                    color: Colors.grey.shade200,
                                    width: 1,
                                  ),
                                )
                              : null,
                        ),
                        child: MyText(
                          text: widget.categories[index],
                          fontSize: 14,
                          fontWeight:
                              selectedCategory == widget.categories[index]
                                  ? FontWeight.w700
                                  : FontWeight.w600,
                          color: selectedCategory == widget.categories[index]
                              ? const Color(0xFF54C5C1)
                              : Colors.black,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: _key,
      margin: const EdgeInsets.fromLTRB(10, 0, 0, 16),
      child: GestureDetector(
        onTap: _toggleDropdown,
        child: Container(
          width: 160,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFF54C5C1), width: 1.4),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyText(
                text: selectedCategory,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: selectedCategory == widget.initialValue
                    ? Colors.grey.shade600
                    : Colors.black,
              ),
              Icon(
                isExpanded
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down,
                color: const Color(0xFF54C5C1),
                size: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
