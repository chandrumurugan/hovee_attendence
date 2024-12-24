import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:logger/logger.dart';

class CommonDropdownInputFieldDays extends StatelessWidget {
  final String title;
  final RxString controllerValue;
  final RxList<String> selectedValues; // RxList for reactive updates
  final List<String> items;
  final Function(List<String>) onChanged;
  final bool? onTap;

  const CommonDropdownInputFieldDays({
    super.key,
    required this.title,
    required this.controllerValue,
    required this.selectedValues,
    required this.items,
    required this.onChanged,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Use Obx to ensure that TextField observes controllerValue
    Logger().i("12345678==>${controllerValue.value}");
    selectedValues.value = controllerValue.value.split(', ');
    return Obx(() {
      String displayText = selectedValues.isEmpty
          ? 'Select' // Show "Select" if no item is selected
          : selectedValues.join(', '); // Show selected items as a comma-separated string

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
        // Use TextEditingController directly to bind with controllerValue
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
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Select $title", style: TextStyle(fontWeight: FontWeight.bold)),
              // Use Column and map over items to create CheckboxListTile
              ...items.map((item) {
                final isSelected = selectedValues.contains(item);
                return Obx(() {
                  return SizedBox(
                    height: 33,
                    child: CheckboxListTile(
                      contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                      title: Text(item),
                      value: selectedValues.contains(item),
                      onChanged: (bool? value) {
                        if (value == true) {
                          selectedValues.add(item); // Add to selected values
                        } else {
                          selectedValues.remove(item); // Remove from selected values
                        }
                        controllerValue.value = selectedValues.join(', '); // Update the controller value
                        onChanged(selectedValues); // Notify listeners of the updated selection
                      },
                    ),
                  );
                });
              }).toList(), // Converting the map result to a list
            ],
          ),
        );
      },
    );
  }
}
