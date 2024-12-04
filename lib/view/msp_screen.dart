import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovee_attendence/controllers/msp_controller.dart';
import 'package:hovee_attendence/utils/search_filter_tabber.dart';
import 'package:hovee_attendence/view/dashboard_screen.dart';
import 'package:hovee_attendence/widget/single_custom_button.dart';

class MspScreen extends StatelessWidget {
  final String type;
   MspScreen({super.key, required this.type});
final MspController mspController = Get.put(MspController());
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
                              ));
                            },
                            icon: Icon(Icons.arrow_back, color: Colors.white),
                          ),
                        ],
                      ),
                      // Image.asset(
                      //   'assets/headerIcons/holiday 1 (1).png',
                      //   height: 35,
                      // ),
                      Text(
                        'MSP',
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
                          'Lorem Ipsum is simply dummy text of the printing and typesetting industry',
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

          // Search and Filter Section
          SearchfiltertabBar(
            title: 'MSP List',
            onSearchChanged: (searchTerm) {
              // Trigger the search functionality by passing the search term
              //batchController.fetchBatchList(searchTerm: searchTerm);
            },
            filterOnTap: () {
              // Implement filter logic here if needed
            },
          ),
          // Header Row
          //const SizedBox(height: 10),
          Obx(() {
             if (mspController.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              }else if(mspController.mspDataList.value.isEmpty){
                 return Center(child: Text("No data found"));
              }
          return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: GestureDetector(
                    child: ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemCount: mspController
                          .mspDataList.value.length, // Number of items
                      itemBuilder: (context, index) {
                        final holidayData =
                            mspController.mspDataList.value[index];
                        return 
                        Card(
          elevation: 10,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () {
                            // Add edit functionality
                            //Get.to(EditleaveScreen(batch: leave,));
                          },
                          icon: Icon(
                            Icons.edit,
                            color: Colors.blue,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            // Add delete functionality
                          // leaveController.deleteLeave(context,leave.sId!);
                          },
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                // Image.asset(
                //   'assets/Rectangle 18416.png',
                //   height: 150,
                //   fit: BoxFit.fill,
                // ),
                const SizedBox(height: 20),
                _buildRow('Batch Name', holidayData.batchDetails!.batchName),
                const SizedBox(height: 10),
                _buildRow('Board.', holidayData.courseDetails!.board),
                const SizedBox(height: 10),
                _buildRow('Subject', '${holidayData.courseDetails!.subject}'),
                const SizedBox(height: 10),
                _buildRow('Reason', '${holidayData.reason}'),
                 const SizedBox(height: 10),
                //_buildRow('Remark', '${holidayData.r}'),
                 _buildRow('Status', '${holidayData.status}'),
                Divider(),
        type == 'Tutor'
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {},
                              child: Container(
                                width: double.infinity,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  gradient: LinearGradient(
                                    colors: const [
                                      Color(0xFFBA0161),
                                      Color(0xFF510270)
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                ),
                                child: Text(
                                  "Submit",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.nunito(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: InkWell(
                              onTap: () {},
                              child: Container(
                                width: double.infinity,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  gradient: LinearGradient(
                                    colors: const [
                                      Color(0xFFBA0161),
                                      Color(0xFF510270)
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                ),
                                child: Text(
                                  "Reject",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.nunito(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : TextButton(
                        onPressed: () {
                          // Add chat functionality
                        },
                        child: Text(
                          'Resend',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
              ],
            ),
          ),
        );
                      },
                    ),
                  ),
                ),
              );
          }
              ),
        ],
      ),
      // bottomNavigationBar: SingleCustomButtom(
      //   btnName: 'Add',
      //   isPadded: false,
      //   onTap: () {
      //      mspController.navigateToAddHolidatScreen();
      //   },
      // ),
    );
  }

  Widget _buildRow(String title, String? value) {
    final displayValue =
        title == 'Fees' ? '₹ ${value ?? 'N/A'} /month' : value ?? 'N/A';

    // Determine the text color for the 'Status' row.
    Color textColor = Colors.black;
    if (title == 'Status') {
      switch (value?.toLowerCase()) {
        case 'approved':
          textColor = Colors.green;
          break;
        case 'pending':
          textColor = Colors.yellow;
          break;
        case 'rejected':
          textColor = Colors.red;
          break;
        default:
          textColor = Colors.black; // Default color if status is unknown
      }
    }

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
        Text(
          displayValue,
          style: TextStyle(
            color: title == 'Status' ? textColor : Colors.black,
            fontWeight: FontWeight.w400,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}