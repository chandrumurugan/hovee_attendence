import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonDropdownInputField1 extends StatelessWidget {
  final String title;
  final RxString controllerValue;
  final RxString selectedValue;
  final List<String> items;
  final Function(String) onChanged;
   final Function() onTap; 

  CommonDropdownInputField1({
    Key? key,
    required this.title,
    required this.controllerValue,
    required this.selectedValue,
    required this.items,
    required this.onChanged,
     required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Determine the text to show in the TextField
      String displayText = selectedValue.value.isEmpty
          ? 'elect' // Show "Tap to select [title]" if nothing is selected
          : selectedValue.value; // Show the selected value otherwise

      return TextField(
        decoration: InputDecoration(
          suffixIcon: Icon(Icons.keyboard_arrow_down), // Down arrow icon
          filled: true,
          fillColor: Colors.grey[200],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14.0),
            borderSide: BorderSide.none,
          ),
        ),
        readOnly: true,
        onTap: onTap,
        controller: TextEditingController(text: displayText), // Use displayText
      );
    });
  }

 
}
