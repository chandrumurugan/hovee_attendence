import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovee_attendence/controllers/myTutor_controller.dart';

class MyTutorScreen extends StatelessWidget {
   MyTutorScreen({super.key});

   final MytutorController mytutorController = Get.put(MytutorController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
           Container(
            height: 200,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(0)),
              image: DecorationImage(
                image: AssetImage(
                  'assets/Course_BG_Banner.png',
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(top: 25, left: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                            
                            },
                            icon: Icon(Icons.arrow_back, color: Colors.white),
                          ),
                        ],
                      ),
                      Image.asset(
                        'assets/headerIcons/tutorCourseicon.png',
                        height: 35,
                      ),
                      Text(
                        'Tutor',
                        style: GoogleFonts.nunito(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 22,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 15),
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Text(
                          'Streamline Your Tutoring: Set Up and Manage Your Batches Easily!',
                          overflow: TextOverflow.clip,
                          maxLines: 2,
                          style: GoogleFonts.nunito(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 25, right: 10, bottom: 10),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      decoration: const BoxDecoration(
                        color: Colors.white24,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          // Obx(() => Text(
                          //       '${mytutorController.totalCount.value}',
                          //       style: GoogleFonts.nunito(
                          //         color: Colors.white,
                          //         fontWeight: FontWeight.w400,
                          //         fontSize: 14,
                          //       ),
                          //     )),
                          Text(
                            'Total',
                            style: GoogleFonts.nunito(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                          ),
                          // Obx(() => Text(
                          //       '${mytutorController.activeCount.value}',
                          //       style: GoogleFonts.nunito(
                          //         color: Colors.white,
                          //         fontWeight: FontWeight.w400,
                          //         fontSize: 14,
                          //       ),
                          //     )),
                          Text(
                            'Active',
                            style: GoogleFonts.nunito(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                          ),
                          // Obx(() => Text(
                          //       '${batchController.inactiveCount.value}',
                          //       style: GoogleFonts.nunito(
                          //         color: Colors.white,
                          //         fontWeight: FontWeight.w400,
                          //         fontSize: 14,
                          //       ),
                          //     )),
                          Text(
                            'Inactive',
                            style: GoogleFonts.nunito(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}