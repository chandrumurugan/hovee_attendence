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
          // labelText: title, 
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
  // Define a fixed height for each item and the maximum height
  const double itemHeight = 56.0; // Height for each RadioListTile
  const double maxHeight = 400.0; // Maximum height of the bottom sheet

  // Calculate the height based on the number of items
  final double sheetHeight = (items.length * itemHeight).clamp(0, maxHeight);

  showModalBottomSheet(
    context: context,
    isScrollControlled: true, // Allow the sheet to be scrollable if needed
    builder: (BuildContext context) {
      return Container(
        height: 220, // Set dynamic height based on item count
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Text("Select $title", style: TextStyle(fontWeight: FontWeight.bold)),
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return Obx(() {
                    final isSelected = selectedValue.value == items[index]; // Check if the item is selected
                    return SizedBox(
                      height: 40,
                      child: RadioListTile<String>(
                        contentPadding: EdgeInsets.symmetric(vertical: 0),
                        title: Text(items[index]),
                        value: items[index],
                        groupValue: selectedValue.value, // Track the selected item
                        onChanged: (value) {
                          selectedValue.value = value!; // Update the selected value
                          controllerValue.value = value; // Update controller value
                          onChanged(value); // Call the onChanged callback
                          Navigator.of(context).pop(); // Close the bottom sheet
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