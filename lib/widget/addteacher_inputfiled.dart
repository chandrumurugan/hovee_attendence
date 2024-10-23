import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

// class CommonInputField extends StatelessWidget {
//   final String label;
//   final RxString controllerValue;
//   final TextInputType keyboardType;
//   final bool obscureText;
//   final bool readOnly;
//   final Function() onTap; // Add onTap function
//   final List<TextInputFormatter>? inputFormatters; // Add this line
//   final String? prefixText;
//   final String? suffixText;
//   final Widget? suffixIcon;
//   final RxString? selectedValue;
//    final Function(String)? onChanged;

//   CommonInputField({
//     Key? key,
//     required this.label,
//     required this.controllerValue,
//     this.keyboardType = TextInputType.text,
//     this.obscureText = false,
//     this.readOnly = false,
//     required this.onTap, // Add the onTap parameter
//     this.inputFormatters,
//     this.prefixText,
//     this.suffixText,
//      this.suffixIcon, 
//     this.selectedValue,
//     this.onChanged
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final textEditingController =
//         TextEditingController(text: controllerValue.value);

//     // Update the controller value when the text changes
//     textEditingController.addListener(() {
//       controllerValue.value = textEditingController.text;
//     });

//     return TextField(
//       //controller: textEditingController,
//       readOnly: readOnly,
//       keyboardType: keyboardType,
//       obscureText: obscureText,
//       inputFormatters: inputFormatters,
//       onTap: (){
//          onTap();
//       },
//       decoration: InputDecoration(
//         labelText: label,
//         border: OutlineInputBorder(),
        // prefixText: prefixText,
        // suffixText: suffixText,
//         suffixIcon: suffixIcon,
//       ),
//     );
//   }
// }


class CommonInputField extends StatelessWidget {
  final String title;
  final RxString controllerValue;
  final RxString selectedValue;
  final Function(String)? onChanged;
  final Function() onTap; 
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? suffixText;
  final String? prefixText;
  CommonInputField({
    Key? key,
    required this.title,
    required this.controllerValue,
    required this.selectedValue,
     this.onChanged,
    required this.onTap,
     this.keyboardType,
      this.inputFormatters,
    this.prefixText,
   this.suffixText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return TextField(
        keyboardType: keyboardType,
         inputFormatters: inputFormatters,
        decoration: InputDecoration(
           labelText: title,
                   prefixText: prefixText,
        suffixText: suffixText,
            filled: true,
          fillColor: Colors.grey[200],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14.0),
            borderSide: BorderSide.none,
          ),
        ),
        readOnly: true,
        onTap: () {
         onTap();
        },
        controller: TextEditingController(text: selectedValue.value),
      );
    });
  }
}