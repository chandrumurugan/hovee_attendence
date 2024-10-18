import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';


class SingleCustomButtom extends StatelessWidget {
  const SingleCustomButtom(
      {super.key,
      required this.btnName,
      required this.isPadded,
      required this.onTap});
  final String btnName;
  final bool isPadded;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: isPadded ? const EdgeInsets.all(10) : const EdgeInsets.all(0),
      child: InkWell(
        onTap: () {
          onTap();
        },
        child: Container(
          width: double.infinity,
          padding: isPadded
              ? const EdgeInsets.symmetric(vertical: 10)
              : const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
              borderRadius: isPadded
                  ? BorderRadius.circular(8)
                  : BorderRadius.circular(0),
               gradient: LinearGradient(
                colors: [Color(0xFFBA0161), Color(0xFF510270)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),),
          child: Text(btnName,
              textAlign: TextAlign.center,
              style: GoogleFonts.nunito(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  color: Colors.white)),
        ),
      ),
    );
  }
}
