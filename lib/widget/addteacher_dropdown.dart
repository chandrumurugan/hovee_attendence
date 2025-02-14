import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonDropdownInputField extends StatelessWidget {
  final String title;
  final RxString controllerValue;
  final RxString selectedValue;
  final List<String> items;
  final Function(String) onChanged;
  final bool? onTap;
  final bool isNonEdit; // Flag to control editability

  CommonDropdownInputField({
    Key? key,
    required this.title,
    required this.controllerValue,
    required this.selectedValue,
    required this.items,
    required this.onChanged,
    required this.isNonEdit, // Pass this from controller
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Determine the text to show in the TextField
      String displayText = selectedValue.value.isEmpty
          ? 'Select' // Show "Select" if nothing is selected
          : selectedValue.value;

      return TextField(
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey[200],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14.0),
            borderSide: BorderSide.none,
          ),
          suffixIcon: isNonEdit
              ? null // Hide dropdown icon if editing is disabled
              : const Icon(Icons.keyboard_arrow_down),
        ),
        readOnly: true, // Disable editing if isNonEdit is true
        onTap: isNonEdit ? null : () => _showDropdown(context),
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
              Text("Select $title", style: const TextStyle(fontWeight: FontWeight.bold)),
              ListView.builder(
                itemCount: items.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.only(bottom: 8),
                itemBuilder: (context, index) {
                  final isSelected = selectedValue.value == items[index];
                  return SizedBox(
                    height: 33,
                    child: RadioListTile<String>(
                      contentPadding: EdgeInsets.zero,
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



// class CommonDropdownInputFieldDays extends StatelessWidget {
//   final String title;
//   final RxList<String> selectedValues; // For multiple selections
//   final RxString controllerValue; // For displaying the selected values
//   final List<String> items;
//   final Function(List<String>) onChanged;

//   CommonDropdownInputFieldDays({
//     Key? key,
//     required this.title,
//     required this.selectedValues,
//     required this.controllerValue,
//     required this.items,
//     required this.onChanged,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       // Update controllerValue whenever selectedValues change
//       controllerValue.value =
//           selectedValues.isEmpty ? '' : selectedValues.join(', ');

//       return TextField(
//         decoration: InputDecoration(
//           suffixIcon: const Icon(Icons.keyboard_arrow_down),
//           filled: true,
//           fillColor: Colors.grey[200],
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(14.0),
//             borderSide: BorderSide.none,
//           ),
//         ),
//         readOnly: true,
//         onTap: () {
//           _showMultiSelectDropdown(context);
//         },
//         controller: TextEditingController(text: controllerValue.value),
//       );
//     });
//   }

//   void _showMultiSelectDropdown(BuildContext context) {
//   showModalBottomSheet(
//   context: context,
//   isScrollControlled: true,
//   builder: (BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(10),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Text(
//             "Select $title",
//             style: const TextStyle(fontWeight: FontWeight.bold),
//           ),
//           // Use Obx only for widgets dependent on Rx variables
          
//              ListView.builder(
//               itemCount: items.length,
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               padding: const EdgeInsets.only(bottom: 8),
//               itemBuilder: (context, index) {
//                 final isSelected = selectedValues.contains(items[index]);
//                 return CheckboxListTile(
//                   contentPadding:
//                       const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
//                   title: Text(items[index]),
//                   value: isSelected,
//                   onChanged: (isChecked) {
//                     if (isChecked == true) {
//                       selectedValues.add(items[index]);
//                     } else {
//                       selectedValues.remove(items[index]);
//                     }

//                     // Update the controller value dynamically
//                     controllerValue.value = selectedValues.isEmpty
//                         ? ''
//                         : selectedValues.join(', ');

//                     onChanged(selectedValues); // Notify parent widget
//                   },
//                 );
//               },
//             ),
//           ElevatedButton(
//             onPressed: () {
//               Navigator.of(context).pop(); // Close the modal
//             },
//             child: const Text('Done'),
//           ),
//         ],
//       ),
//     );
//   },
// );


//   }
// }
// class CommonDropdownInputFieldDays extends StatelessWidget {
//   final String title;
//   final RxString controllerValue;
//   final RxList<String> selectedValues; // Changed to RxList
//   final List<String> items;
//   final Function(List<String>) onChanged;
//   final bool? onTap;

//   CommonDropdownInputFieldDays({
//     Key? key,
//     required this.title,
//     required this.controllerValue,
//     required this.selectedValues, // RxList for multiple selections
//     required this.items,
//     required this.onChanged,
//     this.onTap,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       // Combine the selected values as a string to display in the TextField
//       String displayText = selectedValues.isEmpty
//           ? 'Select' // Show "Select" if no item is selected
//           : selectedValues.join(', '); // Show selected items as a comma-separated string

//       return TextField(
//         decoration: InputDecoration(
//           suffixIcon: Icon(Icons.keyboard_arrow_down), // Down arrow icon
//           filled: true,
//           fillColor: Colors.grey[200],
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(14.0),
//             borderSide: BorderSide.none,
//           ),
//         ),
//         readOnly: true,
//         onTap: () {
//           _showDropdown(context);
//         },
//         controller: TextEditingController(text: displayText),
//       );
//     });
//   }

//   void _showDropdown(BuildContext context) {
//     showModalBottomSheet(
//   context: context,
//   isScrollControlled: true,
//   builder: (BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(10),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Text("Select $title", style: TextStyle(fontWeight: FontWeight.bold)),
//           // Using Column and mapping over items to create CheckboxListTile
//           ...items.map((item) {
//             final isSelected = selectedValues.contains(item);
//             return SizedBox(
//               height: 33,
//               child: CheckboxListTile(
//                 contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
//                 title: Text(item),
//                 value: isSelected,
//                 onChanged: (bool? value) {
//                   if (value == true) {
//                     selectedValues.add(item); // Add to selected values
//                   } else {
//                     selectedValues.remove(item); // Remove from selected values
//                   }
//                   controllerValue.value = selectedValues.join(', '); // Update the controller value
//                   onChanged(selectedValues); // Notify listeners of the updated selection
//                 },
//               ),
//             );
//           }).toList(), // Converting the map result to a list
//         ],
//       ),
//     );
//   },
// );

//   }
// }

