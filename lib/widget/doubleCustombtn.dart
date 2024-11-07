import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovee_attendence/constants/colors_constants.dart';

class DoubleCustomButtom extends StatelessWidget {
  const DoubleCustomButtom(
      {super.key,
      required this.btnName1,
      required this.isPadded,
      required this.onTap1,
      required this.btnName2,
      required this.onTap2});

  final String btnName1;
  final String btnName2;
  final bool isPadded;
  final Function() onTap1;
  final Function() onTap2;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      decoration: BoxDecoration(
          //color: isPadded ? Colors.white : AppConstants.buttonColor,
          gradient: LinearGradient(
                colors: [Color(0xFFBA0161), Color(0xFF510270)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            onTap: () {
              onTap1();
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 7),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                 // color: AppConstants.buttonColor,
                  ),
              child: Text(
                btnName1,
                style: GoogleFonts.nunito(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    color: Colors.white),
              ),
            ),
          ),
          Container(
            height: 30,
            width: 2,
            color: Colors.white,
          ),
          InkWell(
            onTap: () {
              onTap2();
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 7),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                 // border: Border.all(color: AppConstants.buttonColor)
                  ),
              child: Text(
                btnName2,
                style: GoogleFonts.nunito(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    color: isPadded ? AppConstants.buttonColor : Colors.white
                   ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
