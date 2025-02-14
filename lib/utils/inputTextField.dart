// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:hovee_attendence/utils/keyBoardActiontils.dart';
// import 'package:intl/intl.dart';
// import 'package:keyboard_actions/keyboard_actions.dart';

// class InputTextField extends StatefulWidget {
//   final String hintText;
//   final TextInputType keyboardType;
//   final TextEditingController controller;
//   final bool? suffix;
//   final bool? readonly;
//   final bool? isDate;
//   final List<TextInputFormatter>? inputFormatter; // Change here
//   final DateTime? firstDate;
//   final DateTime? lastDate;
//   final DateTime? initialDate;
//    final String? suffixText; // Suffix text
//   final String? prefixText;
//   final Function(String)? onChanged;

//   const InputTextField({
//     super.key,
//     required this.hintText,
//     required this.keyboardType,
//     required this.controller,
//     this.suffix,
//     this.readonly,
//     this.inputFormatter, // Change here
//     this.isDate,
//     this.firstDate,
//     this.lastDate,
//     this.initialDate,
//     this.onChanged, this.suffixText, this.prefixText,
//   });

//   @override
//   State<InputTextField> createState() => _InputTextFieldState();
// }

// class _InputTextFieldState extends State<InputTextField> {
//    final FocusNode _focusNode = FocusNode();
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 54,
//       child: KeyboardActions(
//          disableScroll: true,
//          config: KeyboardActionsUtils.getKeyboardActionsConfig(_focusNode,widget.keyboardType),
//         child: TextFormField(
//           focusNode: _focusNode,
//           textInputAction: TextInputAction.done,
//           readOnly: widget.readonly ?? false,
//           controller: widget.controller,
//           keyboardType: widget.keyboardType,
//           inputFormatters: widget.inputFormatter ?? [], // Update here
//           onChanged: widget.onChanged,
//           decoration: InputDecoration(
//             suffixText: widget.suffixText ?? "",
//             prefixText: widget.prefixText ?? "",
//             suffixIcon: widget.suffix == true
//                 ? IconButton(
//                     onPressed: () async {
//                       if (widget.isDate == true) {
//                         DateTime? pickedDate = await showDatePicker(
//                           context: context,
//                           initialDate: widget.initialDate ?? DateTime.now(),
//                           firstDate: widget.firstDate ?? DateTime(1900),
//                           lastDate: widget.lastDate ?? DateTime.now(),
//                         );

//                         if (pickedDate != null) {
//                           String formattedDate =
//                               DateFormat('dd-MM-yyyy').format(pickedDate);
//                           setState(() {
//                             widget.controller.text = formattedDate;
//                           });
//                         }
//                       } else {
//                         TimeOfDay? pickedTime = await showTimePicker(
//                           initialEntryMode: TimePickerEntryMode.dial,
//                           context: context,
//                           initialTime: TimeOfDay.now(),
//                         );

//                         if (pickedTime != null) {
//                           DateTime now = DateTime.now();
//                           DateTime selectedTime = DateTime(
//                             now.year,
//                             now.month,
//                             now.day,
//                             pickedTime.hour,
//                             pickedTime.minute,
//                           );
//                           String formattedTime =
//                               DateFormat('hh:mm a').format(selectedTime);
//                           setState(() {
//                             widget.controller.text = formattedTime;
//                           });
//                         }
//                       }
//                     },
//                     icon: Icon(
//                       widget.isDate == true ? Icons.calendar_month : Icons.timer,
//                     ),
//                   )
//                 : null,
//             hintStyle: TextStyle(
//               color: Colors.grey[400],
//               fontWeight: FontWeight.w400,
//             ),
//             hintText: widget.hintText,
//             filled: true,
//             fillColor: Colors.grey[200],
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(14.0),
//               borderSide: BorderSide.none,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovee_attendence/constants/colors_constants.dart';
import 'package:hovee_attendence/utils/keyBoardActiontils.dart';
import 'package:intl/intl.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class InputTextField extends StatefulWidget {
  final String hintText;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final bool? suffix;
  final bool? readonly;
  final bool? isDate;
  final List<TextInputFormatter>? inputFormatter;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final DateTime? initialDate;
  final String? suffixText;
  final String? prefixText;
  final Function(String)? onChanged;
  final bool showVerifiedIcon; // New prop for "verified" status
  final Function? onSuffixIconPressed; // Callback for suffix icon click
  final Function? onVerifiedIconPressed; // Callback for verified icon click
  final bool accountVerified; // New prop to determine verification status

  const InputTextField({
    super.key,
    required this.hintText,
    required this.keyboardType,
    required this.controller,
    this.suffix,
    this.readonly,
    this.inputFormatter,
    this.isDate,
    this.firstDate,
    this.lastDate,
    this.initialDate,
    this.onChanged,
    this.suffixText,
    this.prefixText,
    this.showVerifiedIcon = false, // Default to false
    this.onSuffixIconPressed,
    this.onVerifiedIconPressed,
    this.accountVerified = false, // Default to not verified
  });

  @override
  State<InputTextField> createState() => _InputTextFieldState();
}

class _InputTextFieldState extends State<InputTextField> {
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 54,
      child: KeyboardActions(
        disableScroll: true,
        config: KeyboardActionsUtils.getKeyboardActionsConfig(
            _focusNode, widget.keyboardType),
        child: TextFormField(
          focusNode: _focusNode,
          textInputAction: TextInputAction.done,
          readOnly: widget.readonly ?? false,
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          inputFormatters: widget.inputFormatter ?? [],
          onChanged: widget.onChanged,
          decoration: InputDecoration(
            suffixText: widget.suffixText ?? "",
            prefixText: widget.prefixText ?? "",
            suffixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (widget.suffix == true) // Date or Time icon
                  IconButton(
                    onPressed: () async {
                      if (widget.isDate == true) {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: widget.initialDate ?? DateTime.now(),
                          firstDate: widget.firstDate ?? DateTime(1900),
                          lastDate: widget.lastDate ?? DateTime.now(),
                        );

                        if (pickedDate != null) {
                          String formattedDate =
                              DateFormat('dd-MM-yyyy').format(pickedDate);
                          setState(() {
                            widget.controller.text = formattedDate;
                          });
                        }
                      } else {
                        TimeOfDay? pickedTime = await showTimePicker(
                          initialEntryMode: TimePickerEntryMode.dial,
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );

                        if (pickedTime != null) {
                          DateTime now = DateTime.now();
                          DateTime selectedTime = DateTime(
                            now.year,
                            now.month,
                            now.day,
                            pickedTime.hour,
                            pickedTime.minute,
                          );
                          String formattedTime =
                              DateFormat('hh:mm a').format(selectedTime);
                          setState(() {
                            widget.controller.text = formattedTime;
                          });
                        }
                      }

                      // Optional API call when suffix icon is clicked
                      if (widget.onSuffixIconPressed != null) {
                        widget.onSuffixIconPressed!();
                      }
                    },
                    icon: Icon(
                      widget.isDate == true
                          ? Icons.calendar_month
                          : Icons.timer,
                    ),
                  ),
                if (widget.showVerifiedIcon)
                  IconButton(
                    onPressed: () {
                      // Handle "verified" or "arrow" icon click
                      if (widget.onVerifiedIconPressed != null) {
                        widget.onVerifiedIconPressed!();
                      }
                    },
                    icon: Icon(
                      widget.accountVerified
                          ? Icons
                              .verified // Show verified icon if accountVerified is true
                          : Icons
                              .arrow_circle_right_outlined, // Show arrow icon if accountVerified is false
                      color: widget.accountVerified
                          ? Colors.green // Green for verified
                          : AppConstants.primaryColor, // Grey for not verified
                    ),
                  ),
              ],
            ),
            hintStyle: TextStyle(
              color: Colors.grey[400],
              fontWeight: FontWeight.w400,
            ),
            hintText: widget.hintText,
            filled: true,
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.0),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }
}

class InputTextFieldEdit extends StatefulWidget {
  final String hintText;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final bool? suffix;
  final bool? readonly;
  final bool? isDate;
  final List<TextInputFormatter>? inputFormatter;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final DateTime? initialDate;
  final String? suffixText;
  final String? prefixText;
  final Function(String)? onChanged;
  final bool showVerifiedIcon; // New prop for "verified" status
  final Function? onSuffixIconPressed; // Callback for suffix icon click
  final Function? onVerifiedIconPressed; // Callback for verified icon click
  final bool accountVerified; // New prop to determine verification status

  const InputTextFieldEdit({
    super.key,
    required this.hintText,
    required this.keyboardType,
    required this.controller,
    this.suffix,
    this.readonly,
    this.inputFormatter,
    this.isDate,
    this.firstDate,
    this.lastDate,
    this.initialDate,
    this.onChanged,
    this.suffixText,
    this.prefixText,
    this.showVerifiedIcon = false, // Default to false
    this.onSuffixIconPressed,
    this.onVerifiedIconPressed,
    this.accountVerified = false, // Default to not verified
  });

  @override
  State<InputTextFieldEdit> createState() => _InputTextFieldEditState();
}

class _InputTextFieldEditState extends State<InputTextFieldEdit> {
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 54,
      child: KeyboardActions(
        disableScroll: true,
        config: KeyboardActionsUtils.getKeyboardActionsConfig(
            _focusNode, widget.keyboardType),
        child: TextFormField(
          focusNode: _focusNode,
          textInputAction: TextInputAction.done,
          readOnly: widget.readonly ?? false,
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          inputFormatters: widget.inputFormatter ?? [],
          onChanged: widget.onChanged,
          decoration: InputDecoration(
            suffixText: widget.suffixText ?? "",
            prefixText: widget.prefixText ?? "",
            suffixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (widget.suffix == true) // Date or Time icon
                  IconButton(
                    onPressed: () async {
                      if (widget.isDate == true) {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: widget.initialDate ?? DateTime.now(),
                          firstDate: widget.firstDate ?? DateTime(1900),
                          lastDate: widget.lastDate ?? DateTime.now(),
                        );

                        if (pickedDate != null) {
                          String formattedDate =
                              DateFormat('dd-MM-yyyy').format(pickedDate);
                          setState(() {
                            widget.controller.text = formattedDate;
                          });
                        }
                      } else {
                        TimeOfDay? pickedTime = await showTimePicker(
                          initialEntryMode: TimePickerEntryMode.dial,
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );

                        if (pickedTime != null) {
                          DateTime now = DateTime.now();
                          DateTime selectedTime = DateTime(
                            now.year,
                            now.month,
                            now.day,
                            pickedTime.hour,
                            pickedTime.minute,
                          );
                          String formattedTime =
                              DateFormat('hh:mm a').format(selectedTime);
                          setState(() {
                            widget.controller.text = formattedTime;
                          });
                        }
                      }

                      // Optional API call when suffix icon is clicked
                      if (widget.onSuffixIconPressed != null) {
                        widget.onSuffixIconPressed!();
                      }
                    },
                    icon: Icon(
                      widget.isDate == true
                          ? Icons.calendar_month
                          : Icons.timer,
                    ),
                  ),
                if (widget.showVerifiedIcon)
                  IconButton(
                    onPressed: () {
                      // Handle "verified" or "arrow" icon click
                      if (widget.onVerifiedIconPressed != null) {
                        widget.onVerifiedIconPressed!();
                      }
                    },
                    icon: Icon(
                       Icons
                              .edit_square // Show verified icon if accountVerified is true
                        , // Show arrow icon if accountVerified is false // Grey for not verified
                    ),
                  ),
              ],
            ),
            hintStyle: TextStyle(
              color: Colors.grey[400],
              fontWeight: FontWeight.w400,
            ),
            hintText: widget.hintText,
            filled: true,
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.0),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }
}

