import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovee_attendence/controllers/leave_controller.dart';
import 'package:hovee_attendence/utils/customAppBar.dart';
import 'package:hovee_attendence/utils/search_filter_tabber.dart';
import 'package:hovee_attendence/view/dashboard_screen.dart';
import 'package:hovee_attendence/widget/leave_list_container.dart';
import 'package:hovee_attendence/widget/single_custom_button.dart';

class TuteeLeaveScreen extends StatelessWidget {
  final String type;
  final bool fromBottomNav;
  final String? firstname,lastname,wowid;
   TuteeLeaveScreen({super.key, required this.type, required this.fromBottomNav, this.firstname, this.lastname, this.wowid});

final TuteeLeaveController leaveController = Get.put(TuteeLeaveController());
  @override

  Widget build(BuildContext context) {
    return Scaffold(
         appBar: AppBarHeader(
        needGoBack: true,
        navigateTo: () {
          Get.offAll(DashboardScreen(
            rolename: type,
            firstname: firstname,
            lastname: lastname,
            wowid: wowid,
          ));
        },
      ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Container(
            height: 170,
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
              padding: const EdgeInsets.only(top: 25, left: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Row(
                      //   children: [
                      //     IconButton(
                      //       onPressed: () {
                      //         Get.offAll(DashboardScreen(
                      //           rolename: type,
                      //           firstname: firstname,
                      //           lastname: lastname,
                      //           wowid: wowid,
                      //         ));
                      //       },
                      //       icon: Icon(Icons.arrow_back, color: Colors.white),
                      //     ),
                      //   ],
                      // ),
                      SizedBox(height: 8,),
                      Image.asset(
                        'assets/tuteeHomeImg/leave 1.png',
                        height: 35,
                        color: Colors.white,
                        fit: BoxFit.contain,
                      ),
                      SizedBox(height: 8,),
                                            Text(
                        'Leave list',
                        style: GoogleFonts.nunito(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 22,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(right: 15),
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Text(
                          type=='Tutor'?
                          'Here, you can efficiently track and manage students planned leave, enabling precise scheduling and uninterrupted workflow for better organization and planning':'list your planned leaves for the upcoming year and keep everything well-organized ',
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
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
                    'Leave list',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
          ),
          //      SearchfiltertabBar(
          //   title: 'Leave list',
          //   onSearchChanged: (searchTerm) {
          //     // Trigger the search functionality by passing the search term
          //     //batchController.fetchBatchList(searchTerm: searchTerm);
          //   },
          //   filterOnTap: () {
          //     // Implement filter logic here if needed
          //   },
          // ),
              Obx(() {
            if (leaveController.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            } else if (leaveController.leaveList.isEmpty) {
              return Center(
                child: Text(
                  'No list found',
                  style: GoogleFonts.nunito(
                    color: Colors.black54,
                    fontSize: 16,
                  ),
                ),
              );
            } else {
              return Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: leaveController.leaveList.length,
                  itemBuilder: (context, index) {
                    final leaveData = leaveController.leaveList[index];
                    return Animate(
                      
                        effects: [
                                  SlideEffect(
                                    begin: const Offset(-1, 0), // Start from the left
                                    end: const Offset(
                                        0, 0), // End at the original position
                                    curve: Curves.easeInOut,
                                    duration: 500
                                        .ms, // Consistent timing for each item
                                    delay: 100.ms *
                                        index, // Add delay between items
                                  ),
                                  FadeEffect(
                                    begin: 0, // Start transparent
                                    end: 1, // End opaque
                                    duration: 500.ms,
                                    delay: 100.ms * index,
                                  ),
                                ],
                      child: LeaveListContainer(leave: leaveData, type: type,));
                  },
                ),
              );
            }
          })
        
            ],
          ),
          
          bottomNavigationBar: type == 'Tutor' || type == 'Parent'
                    ?SizedBox.fromSize()
         : SingleCustomButtom(
        btnName: 'Add Leave',
        isPadded: false,
        onTap: () {
         leaveController.navigateToAddBatchScreen();
        },
      ),);
  }
}