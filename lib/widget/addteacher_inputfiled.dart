import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonInputField extends StatelessWidget {
  final String label;
  final RxString controllerValue;
  final TextInputType keyboardType;
  final bool obscureText;
  final bool readOnly;
 final Function() onTap; // Add onTap function

  CommonInputField({
    Key? key,
    required this.label,
    required this.controllerValue,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.readOnly = false,
    required this.onTap, // Add the onTap parameter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textEditingController = TextEditingController(text: controllerValue.value);

    // Update the controller value when the text changes
    textEditingController.addListener(() {
      controllerValue.value = textEditingController.text;
    });

    return GestureDetector(
      onTap: readOnly? onTap():null, // Call onTap function from controller
      child: TextField(
        controller: textEditingController,
        readOnly: readOnly,
        keyboardType: keyboardType,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
