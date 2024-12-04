import 'package:flutter/material.dart';
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
   TuteeLeaveScreen({super.key, required this.type});

final TuteeLeaveController leaveController = Get.put(TuteeLeaveController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
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
                              Get.offAll(DashboardScreen(
                                rolename: type,
                              ));
                            },
                            icon: Icon(Icons.arrow_back, color: Colors.white),
                          ),
                        ],
                      ),
                      Image.asset(
                        'assets/headerIcons/holiday 1 (1).png',
                        height: 35,
                      ),
                      Text(
                        'Leave list',
                        style: GoogleFonts.nunito(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 22,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 15),
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Text(
                          'list your planned leave for the upcoming year and keep everything well-organized',
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
               SearchfiltertabBar(
            title: 'Leave List',
            onSearchChanged: (searchTerm) {
              // Trigger the search functionality by passing the search term
              //batchController.fetchBatchList(searchTerm: searchTerm);
            },
            filterOnTap: () {
              // Implement filter logic here if needed
            },
          ),
              Obx(() {
            if (leaveController.isLoading.value) {
              return Center(child: CircularProgressIndicator());
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
                    return LeaveListContainer(leave: leaveData, type: type,);
                  },
                ),
              );
            }
          })
        
            ],
          ),
          bottomNavigationBar: SingleCustomButtom(
        btnName: 'Add Leave',
        isPadded: false,
        onTap: () {
         leaveController.navigateToAddBatchScreen();
        },
      ),);
  }
}