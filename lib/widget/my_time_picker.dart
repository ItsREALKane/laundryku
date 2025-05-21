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
        _showDateTimePicker(context);
      },
    );
  }

  void _showDateTimePicker(BuildContext context) async {
    DateTime initialDate = DateTime.now();

    // Step 1: pilih tanggal dulu
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate == null) return; // batal pilih tanggal

    // Simpan tanggal yang dipilih
    DateTime selectedDate = pickedDate;

    int selectedHour = 8;
    int selectedMinute = 0;

    FixedExtentScrollController hourController =
        FixedExtentScrollController(initialItem: selectedHour);
    FixedExtentScrollController minuteController =
        FixedExtentScrollController(initialItem: selectedMinute);

    // Step 2: buka modal picker jam menit
    await showModalBottomSheet(
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
                        const Text(
                          'Pilih Jam',
                          style: TextStyle(
                              color: Color(0xFF00ADB5),
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                        TextButton(
                          onPressed: () {
                            // simpan tanggal + jam:menit di controller
                            final dateStr = "${selectedDate.year.toString()}-"
                                "${selectedDate.month.toString().padLeft(2, '0')}-"
                                "${selectedDate.day.toString().padLeft(2, '0')}";
                            final hourStr =
                                selectedHour.toString().padLeft(2, '0');
                            final minuteStr =
                                selectedMinute.toString().padLeft(2, '0');

                            widget.controller.text =
                                "$dateStr $hourStr:$minuteStr";

                            widget.controller.text =
                                "$dateStr $hourStr:$minuteStr";
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
                          child: Text(
                            'Jam',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF00ADB5)),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Menit',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF00ADB5)),
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
                              return Center(
                                child: Text(
                                  index.toString().padLeft(2, '0'),
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w500,
                                    color: selectedHour == index
                                        ? const Color(0xFF00ADB5)
                                        : Colors.grey.shade400,
                                  ),
                                ),
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
                              return Center(
                                child: Text(
                                  index.toString().padLeft(2, '0'),
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w500,
                                    color: selectedMinute == index
                                        ? const Color(0xFF00ADB5)
                                        : Colors.grey.shade400,
                                  ),
                                ),
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
}
