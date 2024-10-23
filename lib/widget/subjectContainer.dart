
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovee_attendence/constants/colors_constants.dart';

class SubjectContainer extends StatelessWidget {
  const SubjectContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
      child: Card(
        elevation: 10,
        shadowColor: Colors.grey,
        surfaceTintColor: Colors.white,
        child: Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/tuteeHomeImg/image 193.png',
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Mathematics',
                    style: GoogleFonts.nunito(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '12th std',
                    style: GoogleFonts.nunito(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'CBSE',
                    style: GoogleFonts.nunito(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ],
              ),
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) =>
                      //              PunchView()));
                    },
                    child: const CircleAvatar(
                      radius: 25,
                      backgroundColor: AppConstants.primaryColor,
                      child: Text(
                        'Punch',
                        style: TextStyle(fontSize: 11, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Live',
                    style: GoogleFonts.nunito(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.amber),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}