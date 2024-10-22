import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CommonInputField extends StatelessWidget {
  final String label;
  final RxString controllerValue;
  final TextInputType keyboardType;
  final bool obscureText;
  final bool readOnly;
  final Function() onTap; // Add onTap function
  final List<TextInputFormatter>? inputFormatters; // Add this line
  final String? prefixText;
  final String? suffixText;

  CommonInputField({
    Key? key,
    required this.label,
    required this.controllerValue,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.readOnly = false,
    required this.onTap, // Add the onTap parameter
    this.inputFormatters,
    this.prefixText,
    this.suffixText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textEditingController =
        TextEditingController(text: controllerValue.value);

    // Update the controller value when the text changes
    textEditingController.addListener(() {
      controllerValue.value = textEditingController.text;
    });

    return GestureDetector(
      onTap: readOnly ? onTap() : null, // Call onTap function from controller
      child: TextField(
        controller: textEditingController,
        readOnly: readOnly,
        keyboardType: keyboardType,
        obscureText: obscureText,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
          prefixText: prefixText,
          suffixText: suffixText,
        ),
      ),
    );
  }
}
