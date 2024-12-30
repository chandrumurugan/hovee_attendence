import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

class DeatilHeader extends StatelessWidget {
 // ignore: non_constant_identifier_names
 final String subject,Coursecode,address;
   const DeatilHeader({super.key,required this.subject,required this.Coursecode, required this.address,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(children: [
        Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.sizeOf(context).width * 0.05,
                  vertical: MediaQuery.sizeOf(context).height * 0.035),
              width: MediaQuery.sizeOf(context).width,
              height: 250,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        'assets/bgImage/detailpagebanner.jpg',
                      ))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      )),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                       subject,
                        style: GoogleFonts.nunito(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 24),
                      ),
                      Row(
                        children: [
                          Text(
                            Coursecode,
                            style: GoogleFonts.nunito(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 16),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                          Text(
                       address,
                        style: GoogleFonts.nunito(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              height: 80,
            )
          ],
        ),
        Positioned(
            left: 15,
            right: 15,
            bottom: 15,
            child: Container(
                padding: const EdgeInsets.all(15),
                width: MediaQuery.sizeOf(context).width,
                decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(0, 10),
                        color: Colors.grey,
                        spreadRadius: 1,
                        blurRadius: 20,
                      )
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(45)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.blueAccent,
                            backgroundImage:
                                AssetImage('assets/Ellipse 261.png'),
                          ),
                          Positioned(
                            left: 40, // Align to the right of the Stack
                            child: CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.amber,
                              backgroundImage:
                                  AssetImage('assets/Ellipse 261.png'),
                            ),
                          ),
                          Positioned(
                            left: 150, // Align to the right of the Stack
                            child: CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.brown,
                              backgroundImage:
                                  AssetImage('assets/Ellipse 261.png'),
                            ),
                          ),
                          Positioned(
                            left: 120, // Align to the right of the Stack
                            child: CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.green,
                              backgroundImage:
                                  AssetImage('assets/Ellipse 261.png'),
                            ),
                          ),
                          Positioned(
                            left: 80, // Align to the right of the Stack
                            child: CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.blue,
                              backgroundImage:
                                  AssetImage('assets/Ellipse 261.png'),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        '50 Students',
                        style: GoogleFonts.nunito(
                            color: Colors.grey, fontSize: 18),
                      ),
                    )
                  ],
                )))
      ]),
    );
  }
}
