import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class InputTextField extends StatefulWidget {
  final String hintText;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final bool? suffix;
  final bool? readonly;
  final bool? isDate;
  final List<TextInputFormatter>? inputFormatter; // Change here
  final DateTime? firstDate;
  final DateTime? lastDate;
  final DateTime? initialDate;
  final Function(String)? onChanged;

  const InputTextField({
    super.key,
    required this.hintText,
    required this.keyboardType,
    required this.controller,
    this.suffix,
    this.readonly,
    this.inputFormatter, // Change here
    this.isDate,
    this.firstDate,
    this.lastDate,
    this.initialDate,
    this.onChanged,
  });

  @override
  State<InputTextField> createState() => _InputTextFieldState();
}

class _InputTextFieldState extends State<InputTextField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 54,
      child: TextFormField(
        readOnly: widget.readonly ?? false,
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        inputFormatters: widget.inputFormatter ?? [], // Update here
        onChanged: widget.onChanged,
        decoration: InputDecoration(
          suffixIcon: widget.suffix == true
              ? IconButton(
                  onPressed: () async {
                    if (widget.isDate == true) {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: widget.initialDate ?? DateTime.now(),
                        firstDate: widget.firstDate ?? DateTime(1900),
                        lastDate: widget.lastDate ?? DateTime.now(),
                      );

                      if (pickedDate != null) {
                        String formattedDate =
                            DateFormat('dd-MM-yyyy').format(pickedDate);
                        setState(() {
                          widget.controller.text = formattedDate;
                        });
                      }
                    } else {
                      TimeOfDay? pickedTime = await showTimePicker(
                        initialEntryMode: TimePickerEntryMode.dial,
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );

                      if (pickedTime != null) {
                        DateTime now = DateTime.now();
                        DateTime selectedTime = DateTime(
                          now.year,
                          now.month,
                          now.day,
                          pickedTime.hour,
                          pickedTime.minute,
                        );
                        String formattedTime =
                            DateFormat('hh:mm a').format(selectedTime);
                        setState(() {
                          widget.controller.text = formattedTime;
                        });
                      }
                    }
                  },
                  icon: Icon(
                    widget.isDate == true ? Icons.calendar_month : Icons.timer,
                  ),
                )
              : null,
          hintStyle: TextStyle(
            color: Colors.grey[400],
            fontWeight: FontWeight.w400,
          ),
          hintText: widget.hintText,
          filled: true,
          fillColor: Colors.grey[200],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14.0),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}