import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hovee_attendence/utils/keyBoardActiontils.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class CommonInputField extends StatelessWidget {
 // final String title; // Title of the input field
  final RxString controllerValue; // Reactive controller value
  final RxString selectedValue; // Selected value to display
  final Function(String)? onChanged; // Function called on text change
  final Function() onTap; // Function called on tap
  final TextInputType? keyboardType; // Keyboard type for the text field
  final List<TextInputFormatter>? inputFormatters; // Input formatters
  final String? suffixText; // Suffix text
  final String? prefixText; // Prefix text
  final String? hintText; // Hint text to display when field is empty
  final TextEditingController? controller;
   final bool? readonly;
  CommonInputField({
    Key? key,
    //required this.title,
    required this.controllerValue,
    required this.selectedValue,
    required this.controller,
    this.onChanged,
    required this.onTap,
    this.keyboardType,
    this.inputFormatters,
    this.prefixText,
    this.suffixText,
    this.hintText, this.readonly, // Add hintText parameter
  }) : super(key: key);
   final FocusNode _focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final textEditingController =
        TextEditingController(text: controllerValue.value);

    // Update the controller value when the text changes
    textEditingController.addListener(() {
      controllerValue.value = textEditingController.text;
    });
      return KeyboardActions(
          disableScroll: true,
         config: KeyboardActionsUtils.getKeyboardActionsConfig(_focusNode,keyboardType ?? TextInputType.name),
        child: TextField(
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          focusNode: _focusNode,
          decoration: InputDecoration(
            hintText: hintText, // Set the hint text here
            //labelText: title, // Optional: Use title as label text
            prefixText: prefixText,
            suffixText: suffixText,
            filled: true,
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.0),
              borderSide: BorderSide.none,
            ),
          ),
          readOnly: readonly ?? false,
          onTap: () {
            onTap();
          },
        controller: controller,
        ),
      );
    });
  }
}
