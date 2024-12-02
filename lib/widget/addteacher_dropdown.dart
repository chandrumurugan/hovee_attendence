import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonDropdownInputField extends StatelessWidget {
  final String title;
  final RxString controllerValue;
  final RxString selectedValue;
  final List<String> items;
  final Function(String) onChanged;
  final bool ?onTap;
  

  CommonDropdownInputField({
    Key? key,
    required this.title,
    required this.controllerValue,
    required this.selectedValue,
    required this.items,
    required this.onChanged,
    this.onTap
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
        controller: TextEditingController(text: displayText),
      );
    });
  }

  void _showDropdown(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 180, // Adjust height as needed
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Text("Select $title", style: TextStyle(fontWeight: FontWeight.bold)),
              Expanded(
                child: ListView.builder(
                  itemCount: items.length,
                  padding: EdgeInsets.only(bottom: 8),
                  itemBuilder: (context, index) {
                    final isSelected = selectedValue.value == items[index];
                    return SizedBox(
                        height: 33,
                        child: RadioListTile<String>(
                          contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 0),
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
                    // ListTile(
                    //   title: Text(
                    //     items[index],
                    //     style: TextStyle(
                    //       fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    //       color: isSelected ? Colors.blue : Colors.black,
                    //     ),
                    //   ),
                    //   tileColor: isSelected ? const Color.fromARGB(255, 253, 253, 253) : null,
                    //   onTap: () {
                    //     selectedValue.value = items[index];
                    //     controllerValue.value = items[index]; // Update controller value
                    //     onChanged(items[index]);
                    //     Navigator.of(context).pop();
                    //   },
                    // );
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
