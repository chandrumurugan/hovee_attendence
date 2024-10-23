import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonDropdownInputField extends StatelessWidget {
  final String title;
  final RxString controllerValue;
  final RxString selectedValue;
  final List<String> items;
  final Function(String) onChanged;

  CommonDropdownInputField({
    Key? key,
    required this.title,
    required this.controllerValue,
    required this.selectedValue,
    required this.items,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Determine the text to show in the TextField
      String displayText = selectedValue.value.isEmpty
          ? 'Select' // Show "Tap to select [title]" if nothing is selected
          : selectedValue.value;    // Show the selected value otherwise

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
        onTap: () {
          _showDropdown(context);
        },
        controller: TextEditingController(text: displayText), // Use displayText
      );
    });
  }

  void _showDropdown(BuildContext context) {
    const double itemHeight = 56.0; // Height for each RadioListTile
    const double maxHeight = 400.0; // Maximum height of the bottom sheet
    const double minHeight = 100.0;
    final double sheetHeight = (items.length * itemHeight).clamp(minHeight, maxHeight);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          height: sheetHeight,
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Text("Select $title", style: TextStyle(fontWeight: FontWeight.bold)),
              Expanded(
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return Obx(() {
                      final isSelected = selectedValue.value == items[index];
                      return SizedBox(
                        height: 40,
                        child: RadioListTile<String>(
                          contentPadding: EdgeInsets.symmetric(vertical: 0),
                          title: Text(items[index]),
                          value: items[index],
                          groupValue: selectedValue.value,
                          onChanged: (value) {
                            selectedValue.value = value!;
                            controllerValue.value = value;
                            onChanged(value);
                            Navigator.of(context).pop();
                          },
                        ),
                      );
                    });
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}


