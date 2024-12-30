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
      required this.onTap2,
      required this.isButton2Enabled});  // Added parameter to control button 2 state

  final String btnName1;
  final String btnName2;
  final bool isPadded;
  final Function() onTap1;
  final Function() onTap2;
  final bool isButton2Enabled;  // State to enable/disable the second button

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFBA0161), Color(0xFF510270)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
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
              ),
              child: Text(
                btnName1,
                style: GoogleFonts.nunito(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Container(
            height: 30,
            width: 2,
            color: Colors.white,
          ),
          InkWell(
            onTap: isButton2Enabled ? () {
              onTap2();
            } : null,  // Disable the tap action if button is not enabled
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 7),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                btnName2,
                style: GoogleFonts.nunito(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  color: isButton2Enabled
                      ? (isPadded ? AppConstants.buttonColor : Colors.white)  // Active color
                      : Colors.grey,  // Disabled color
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
