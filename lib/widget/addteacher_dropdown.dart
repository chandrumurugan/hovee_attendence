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
      return TextField(
        decoration: InputDecoration(
           //labelText: title,
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
        controller: TextEditingController(text: selectedValue.value),
      );
    });
  }

  void _showDropdown(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200, // Adjust height as needed
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Text("Select $title", style: TextStyle(fontWeight: FontWeight.bold)),
              Expanded(
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final isSelected = selectedValue.value == items[index];
                    return ListTile(
                      title: Text(
                        items[index],
                        style: TextStyle(
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          color: isSelected ? Colors.blue : Colors.black,
                        ),
                      ),
                      tileColor: isSelected ? const Color.fromARGB(255, 253, 253, 253) : null,
                      onTap: () {
                        selectedValue.value = items[index];
                        controllerValue.value = items[index]; // Update controller value
                        onChanged(items[index]);
                        Navigator.of(context).pop();
                      },
                    );
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
