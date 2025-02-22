import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovee_attendence/controllers/annoument_controller.dart';
import 'package:hovee_attendence/utils/customAppBar.dart';
import 'package:hovee_attendence/view/dashboard_screen.dart';

class HostelAnnouncementScreen extends StatelessWidget {
   final String type;
  final String? firstname, lastname, wowid;
   HostelAnnouncementScreen({super.key, required this.type, this.firstname, this.lastname, this.wowid});
  final AnnoumentController anoumentController = Get.put(AnnoumentController());
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
                          'Announcement list',
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
                            'list your planned announcement for the upcoming year and keep everything well-organized',
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
                    'Announcement list',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
          ),
            // SearchfiltertabBar(
            //   title: 'Announcement list',
            //   onSearchChanged: (searchTerm) {
            //     // Trigger the search functionality by passing the search term
            //     //batchController.fetchBatchList(searchTerm: searchTerm);
            //   },
            //   filterOnTap: () {
            //     // Implement filter logic here if needed
            //   },
            // ),
            Obx(() {
              if (anoumentController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              } else if (anoumentController.announmentHostelList.isEmpty) {
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
                    itemCount: anoumentController.announmentHostelList.length,
                    itemBuilder: (context, index) {
                      final leaveData =
                          anoumentController.announmentHostelList[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Card(
                          elevation: 10,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      _buildRow(
                                          'Title', leaveData.title, context),
                                      const SizedBox(height: 10),
                                      _buildRow(
                                          'Hostel name',
                                          '${leaveData.hostelListsDetails!.hostelName}',
                                          context),
                                      const SizedBox(height: 10),
                                      _buildRow(
                                          'Hosteller name',
                                          leaveData.hostellerObjectId[index].hostellerFirstName,
                                          context),
                                      const SizedBox(height: 10),
                                      // _buildRow(
                                      //     'Class name',
                                      //     '${leaveData.courseDetails!.className}',
                                      //     context),
                                      // const SizedBox(height: 10),
                                      // _buildRow(
                                      //     'Subject',
                                      //     leaveData.courseDetails!.subject,
                                      //     context),
                                      // const SizedBox(height: 10),
                                      _buildRow('Description',
                                          leaveData.description, context),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
            })
          ],
        ),
             )
             ;
  }

  Widget _buildRow(String title, String? value, BuildContext context) {
    final displayValue =
        title == 'Fees' ? '₹ ${value ?? 'N/A'} /month' : value ?? 'N/A';

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.black.withOpacity(0.4),
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.4,
          child: Text(
            displayValue,
            maxLines: 3,
            style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: 14,
                overflow: TextOverflow.ellipsis),
          ),
        ),
      ],
    );
  }
}