import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundryku/widget/my_text.dart';

class MyTimePickerTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;

  const MyTimePickerTextField({
    Key? key,
    required this.hintText,
    required this.controller,
    this.validator,
  }) : super(key: key);

  @override
  State<MyTimePickerTextField> createState() => _MyTimePickerTextFieldState();
}

class _MyTimePickerTextFieldState extends State<MyTimePickerTextField> {
  int selectedHour = 8;
  int selectedMinute = 0;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      readOnly: true,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: GoogleFonts.poppins(color: Colors.grey),
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
          borderSide: const BorderSide(color: Color(0xFF00ADB5), width: 2),
        ),
        suffixIcon: Icon(Icons.access_time, color: Color(0xFF00ADB5)),
      ),
      validator: widget.validator,
      onTap: () {
        _showAlarmStyleTimePicker(context);
      },
    );
  }

  void _showAlarmStyleTimePicker(BuildContext context) {
    selectedHour = 8;
    selectedMinute = 0;

    if (widget.controller.text.isNotEmpty) {
      final parts = widget.controller.text.split(':');
      if (parts.length == 2) {
        selectedHour = int.tryParse(parts[0]) ?? selectedHour;
        selectedMinute = int.tryParse(parts[1]) ?? selectedMinute;
      }
    }

    FixedExtentScrollController hourController =
        FixedExtentScrollController(initialItem: selectedHour);

    FixedExtentScrollController minuteController =
        FixedExtentScrollController(initialItem: selectedMinute);

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext sheetContext) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setSheetState) {
            return Container(
              height: 400,
              child: Column(
                children: [
                  Container(
                    height: 60,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom:
                            BorderSide(color: Colors.grey.shade200, width: 1),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Icon(
                            Icons.close_sharp,
                            color: Color(0xFF00ADB5),
                            size: 30,
                          ),
                        ),
                        const MyText(
                          text: 'Pilih Jam',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF00ADB5),
                        ),
                        TextButton(
                          onPressed: () {
                            final hour =
                                selectedHour.toString().padLeft(2, '0');
                            final minute =
                                selectedMinute.toString().padLeft(2, '0');
                            widget.controller.text = '$hour:$minute';
                            Navigator.of(context).pop();
                          },
                          child: const Icon(
                            Icons.check_rounded,
                            color: Color(0xFF00ADB5),
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Label jam dan menit
                  const Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: MyText(
                            text: 'Jam',
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF00ADB5),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          child: MyText(
                            text: 'Menit',
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF00ADB5),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Picker jam dan menit
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ListWheelScrollView(
                            controller: hourController,
                            itemExtent: 70,
                            perspective: 0.005,
                            diameterRatio: 2.0,
                            physics: const FixedExtentScrollPhysics(),
                            children: List.generate(24, (index) {
                              return _buildAlarmTimeItem(
                                index.toString().padLeft(2, '0'),
                                index == selectedHour,
                              );
                            }),
                            onSelectedItemChanged: (index) {
                              setSheetState(() {
                                selectedHour = index;
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: ListWheelScrollView(
                            controller: minuteController,
                            itemExtent: 70,
                            perspective: 0.005,
                            diameterRatio: 2.0,
                            physics: const FixedExtentScrollPhysics(),
                            children: List.generate(60, (index) {
                              return _buildAlarmTimeItem(
                                index.toString().padLeft(2, '0'),
                                index == selectedMinute,
                              );
                            }),
                            onSelectedItemChanged: (index) {
                              setSheetState(() {
                                selectedMinute = index;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildAlarmTimeItem(String text, bool isSelected) {
    return Container(
      height: 70,
      alignment: Alignment.center,
      child: MyText(
        text: text,
        fontSize: 30,
        fontWeight: FontWeight.w500,
        color: isSelected ? const Color(0xFF00ADB5) : Colors.grey.shade400,
      ),
    );
  }
}
