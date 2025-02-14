import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

// ignore: must_be_immutable
class CustomTextField extends StatefulWidget {
  final String placeholder;
  final String title;
  final bool showSurfix;
  final String? Function(String?)? validator;
  final TextInputType texttype;
  final bool isMobile;
  final int? maxLength;
  final bool? isHighlight;
  final bool? isFreeze;
  TextEditingController textEditingController;
  final bool? isFull;
  final String? initialValue;
  final bool? isEdit;

  CustomTextField({
    Key? key,
    this.isHighlight,
    required this.placeholder,
    required this.title,
    required this.showSurfix,
    this.validator,
    required this.texttype,
    required this.isMobile,
    this.maxLength,
    required this.textEditingController,
    this.isFreeze,
    this.isFull,
    this.initialValue,
    this.isEdit,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  // late TextEditingController _controller;
  bool _isValid = true;
  late List<TextInputFormatter> _inputFormatters;

  @override
  void initState() {
    super.initState();
    // widget.textEditingController = TextEditingController();
    _inputFormatters = [];
    // Conditionally add input formatters based on field type
    if (widget.showSurfix) {
      if (widget.isMobile) {
        _inputFormatters.add(
          MaskTextInputFormatter(
            // mask: '##########',
            mask: '+91 (###) ###-####',
            type: MaskAutoCompletionType.eager,
            filter: {"#": RegExp(r'[0-9]')},
          ),
        );
      } else {
        _inputFormatters.add(
            // DobInputFormatter()
            MaskTextInputFormatter(
          mask: '## | ## | ####',
          type: MaskAutoCompletionType.eager,
          filter: {"#": RegExp(r'[0-9]')},
        ));
      }
    }
  }

  // @override
  // void dispose() {
  //   widget.textEditingController.dispose(); // Dispose the controller when the widget is disposed
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.isFull != null && widget.isFull!
          ? 160
          : MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text(widget.title,
                  style: GoogleFonts.nunito(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: widget.isHighlight != null && widget.isHighlight!
                          ? Colors.black
                          : Colors.black.withOpacity(0.5))),
              Text('*',
                  style: GoogleFonts.nunito(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: widget.isHighlight != null && widget.isHighlight!
                          ? Colors.black
                          : Colors.red.withOpacity(0.6))),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            //  readOnly: widget.isEdit != null ? widget.isEdit! : false,
            readOnly: widget.isEdit ?? false,
            maxLength: widget.maxLength != null ? widget.maxLength : null,
            controller: widget.textEditingController,
            initialValue: widget.initialValue ?? null,
            keyboardType: widget.texttype,
            textInputAction: TextInputAction.done,
            // autofocus: true,
            inputFormatters: _inputFormatters,
            decoration: InputDecoration(
              isCollapsed: false,
              filled: true,
              fillColor: Color(0xffD9D9D9).withOpacity(0.2),
              hintText: "Enter here...",
              hintStyle: GoogleFonts.nunito(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black.withOpacity(0.5)),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: _isValid
                      ? Color(0xffD9D9D9).withOpacity(0.2)
                      : Colors.red,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(12)),
              ),
              errorText: _isValid
                  ? null
                  : widget.validator!(widget.textEditingController.text),
              suffixIcon: widget.showSurfix && !widget.isMobile
                  ? IconButton(
                      icon: const Icon(Icons.calendar_month_rounded),
                      onPressed: () async {
                        final pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2050),
                        );
                        if (pickedDate != null) {
                          setState(() {
                            widget.textEditingController.text =
                                DateFormat('dd | MM | yyyy').format(pickedDate);
                          });
                        }
                      },
                    )
                  : null,
            ),
            onChanged: (value) {
              setState(() {
                _isValid = widget.validator == null ||
                    widget.validator!(value) == null;
              });
            },
            validator: widget.validator != null
                ? (value) => widget.validator!(value)
                : null,
          )
        ],
      ),
    );
  }
}
