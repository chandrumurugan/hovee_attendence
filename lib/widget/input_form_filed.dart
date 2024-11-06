import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InputFormField extends StatefulWidget {
  const InputFormField(
      {super.key,
      required this.title,
      required this.controller,
      this.keyboardType,
      required this.inputAction,
      required this.showSuffix,
      required this.icon,
      required this.suffixIconOnTap,
      this.readOnly});
  final String title;
  final bool showSuffix;
  final Widget? icon;
  final bool? readOnly;
  final Function()? suffixIconOnTap;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final TextInputAction inputAction;

  @override
  State<InputFormField> createState() => _InputFormFieldState();
}

class _InputFormFieldState extends State<InputFormField> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
          child: TextFormField(
            readOnly: widget.readOnly!,
            controller: widget.controller,
            keyboardType: widget.keyboardType,
            decoration: InputDecoration(
              suffixIconColor: Colors.black,
              suffixIcon: widget.showSuffix
                  ? IconButton(
                      onPressed: widget.suffixIconOnTap!, icon: widget.icon!)
                  : null,
              enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14.0),
                borderSide: const BorderSide(
                  color: Colors.pink,
                  width: 1.5,
                ),
              ),
              filled: true,
              fillColor: Colors.grey[200],
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter ${widget.title}';
              }
              return null;
            },
            textInputAction: widget.inputAction,
          ),
        ),
        Positioned(
          left: MediaQuery.sizeOf(context).width * 0.07,
          top: -MediaQuery.sizeOf(context).height * 0.001,
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 1),
            child: Text(
              widget.title,
              style: GoogleFonts.nunito(color: Colors.black),
            ),
          ),
        ),
      ],
    );
  }
}