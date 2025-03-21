import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovee_attendence/controllers/batch_controller.dart';
import 'package:hovee_attendence/utils/search_filter_tabber.dart';
import 'package:hovee_attendence/view/dashboard_screen.dart';
import 'package:hovee_attendence/widget/batch_list_container.dart';
import 'package:hovee_attendence/widget/single_custom_button.dart';
import 'package:hovee_attendence/widget/tutee_list.dart';

class TutorBatchList extends StatelessWidget {
  final String type;
  final String? firstname, lastname, wowid;
  TutorBatchList(
      {super.key,
      required this.type,
      this.firstname,
      this.lastname,
      this.wowid});
  final BatchController batchController = Get.put(BatchController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section
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
                                firstname: firstname,
                                lastname: lastname,
                                wowid: wowid,
                              ));
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
                        'Batches',
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
                          Obx(() => Text(
                                '${batchController.totalCount.value}',
                                style: GoogleFonts.nunito(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                ),
                              )),
                          Text(
                            'Total',
                            style: GoogleFonts.nunito(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                          ),
                          Obx(() => Text(
                                '${batchController.activeCount.value}',
                                style: GoogleFonts.nunito(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                ),
                              )),
                          Text(
                            'Active',
                            style: GoogleFonts.nunito(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                          ),
                          Obx(() => Text(
                                '${batchController.inactiveCount.value}',
                                style: GoogleFonts.nunito(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                ),
                              )),
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

          // Search and Filter Section
          SearchfiltertabBar(
            title: 'Batch list',
            onSearchChanged: (searchTerm) {
              // Trigger the search functionality by passing the search term
              batchController.fetchBatchList(searchTerm: searchTerm);
            },
            filterOnTap: () {
              // Implement filter logic here if needed
            },
          ),
          Obx(() {
            if (batchController.isLoading.value) {
              return Center(child: CircularProgressIndicator());
            } else if (batchController.initialLoad.value) {
              return Center(
                  child:
                      CircularProgressIndicator()); // Show loader during initial load
            } else if (batchController.batchList.isEmpty) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  children: [
                    SizedBox(height: 30),
                    Image.asset(
                      'assets/logo/No_Verification_Found_Image_app.png',
                      height: 200,
                    ),
                    SizedBox(height: 30),
                    Center(
                      child: Text(
                        "No listing found",
                        style: GoogleFonts.nunito(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: batchController.batchList.length,
                  itemBuilder: (context, index) {
                    final batch = batchController.batchList[index];
                    return GestureDetector(
                      onTap: () {
                       Get.to(() => TuteeList(batchId: batch.sId));
                      },
                      child: BatchListConatiner(batch: batch,wowid: wowid,));
                  },
                ),
              );
            }
          }),
        ],
      ),
      bottomNavigationBar: GetBuilder<BatchController>(
  builder: (controller) {
    return (controller.instituteId == null || controller.instituteId == '')
        ? SingleCustomButtom(
            btnName: 'Add',
            isPadded: false,
            onTap: () {
              controller.navigateToAddBatchScreen();
            },
          )
        : SizedBox.shrink();
  },
),

    );
  }
}
