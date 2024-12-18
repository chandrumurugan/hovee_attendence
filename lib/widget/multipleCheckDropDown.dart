import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonDropdownInputFields extends StatelessWidget {
  final String title;
  final RxList<String> controllerValue;
  final RxList<String> selectedValue;
  final List<String> items;
  final Function(List<String>) onChanged;

  const CommonDropdownInputFields({
    Key? key,
    required this.title,
    required this.controllerValue,
    required this.selectedValue,
    required this.items,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
        final textController = TextEditingController();

    return Obx(() {
        final TextEditingController textController = TextEditingController();

    // Update the TextEditingController only when selectedValue changes
    selectedValue.listen((_) {
      textController.text =
          selectedValue.isEmpty ? 'Select' : selectedValue.join(', ');
    });// Show selected items as a comma-separated string

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
        controller:textController,
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
              Text(
                "Select $title",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              ListView.builder(
                itemCount: items.length,
                shrinkWrap: true, // Ensures the ListView doesn't expand infinitely
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.only(bottom: 8),
                itemBuilder: (context, index) {
                  final isSelected = selectedValue.contains(items[index]);
                  return SizedBox(
                    height: 33,
                    child: CheckboxListTile(
                      contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                      title: Text(items[index]),
                      value: isSelected,
                      onChanged: (bool? value) {
                        if (value == true) {
                          // Add the item to the selected list
                          selectedValue.add(items[index]);
                        } else {
                          // Remove the item from the selected list
                          selectedValue.remove(items[index]);
                        }
                        controllerValue.assignAll(selectedValue); // Update controller value
                        onChanged(selectedValue); // Trigger the callback
                      },
                    ),
                  );
                },
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the modal
                },
                child: const Text("Done"),
              ),
            ],
          ),
        );
      },
    );
  }
}
