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
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
         // height: 180, // Adjust height as needed
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
      
            children: [
              Text("Select $title", style: TextStyle(fontWeight: FontWeight.bold)),
              ListView.builder(
                itemCount: items.length,
                   shrinkWrap: true, // Ensures the ListView doesn't expand infinitely
                            physics: const NeverScrollableScrollPhysics(),
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
                },
              ),
            ],
          ),
        );
      },
    );
  }
}



class CommonDropdownInputFieldDays extends StatelessWidget {
  final String title;
  final RxList<String> selectedValues; // Updated to RxList for multiple selections
  final List<String> items;
  final Function(List<String>) onChanged;

  CommonDropdownInputFieldDays({
    Key? key,
    required this.title,
    required this.selectedValues,
    required this.items,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Display selected items joined by commas or "Select" if empty
      String displayText = selectedValues.isEmpty
          ? 'Select $title'
          : selectedValues.join(', ');

      return TextField(
        decoration: InputDecoration(
          suffixIcon: Icon(Icons.keyboard_arrow_down),
          filled: true,
          fillColor: Colors.grey[200],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14.0),
            borderSide: BorderSide.none,
          ),
        ),
        readOnly: true,
        onTap: () {
          _showMultiSelectDropdown(context);
        },
        controller: TextEditingController(text: displayText),
      );
    });
  }

  void _showMultiSelectDropdown(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Select $title",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              ListView.builder(
                itemCount: items.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.only(bottom: 8),
                itemBuilder: (context, index) {
                  final isSelected = selectedValues.contains(items[index]);
                  return CheckboxListTile(
                    title: Text(items[index]),
                    value: isSelected,
                    onChanged: (isChecked) {
                      if (isChecked == true) {
                        selectedValues.add(items[index]);
                      } else {
                        selectedValues.remove(items[index]);
                      }
                      onChanged(selectedValues); // Notify parent widget
                    },
                  );
                },
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Done'),
              ),
            ],
          ),
        );
      },
    );
  }
}

