

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovee_attendence/controllers/batch_controller.dart';
import 'package:hovee_attendence/modals/getBatchtuteelistModel.dart';
import 'package:hovee_attendence/services/webServices.dart';
import 'package:hovee_attendence/utils/search_filter_tabber.dart';

class TuteeList extends StatefulWidget {
  final String batchId;
  const TuteeList({super.key, required this.batchId});

  @override
  State<TuteeList> createState() => _TuteeListState();
}
   final BatchController batchController = Get.put(BatchController());
class _TuteeListState extends State<TuteeList> {
   bool isLoading = true;
  List<Datum>? batchTuteeList ;
 Tutee? tutee;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
fetchBatchTuteeList(batchId: widget.batchId);
  }

  void fetchBatchTuteeList({String searchTerm = '', String?batchId}) async {
  try {
    isLoading = true; // Start loading
    // Prepare the request payload
    final requestPayload = 
{
    "batchId":batchId,
    "page":"",
    "limit":'',
    "search":""
};

    // Fetch batch list from the API
    var batchResponse = await WebService.fetchBatchTuteeList(requestPayload);

    if (batchResponse!.data != null) {
      setState(() {
         batchTuteeList = batchResponse.data;
         isLoading=false;
      });
      
    } else {
        isLoading=false;
    }
  } catch (e) {
  
    print('Error fetching batch list: $e');
  } finally {
    isLoading = false; // Stop loading
  }
}
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
                              Get.back();
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
            title: 'Student list',
            onSearchChanged: (searchTerm) {
              // Trigger the search functionality by passing the search term
            },
            filterOnTap: () {
              // Implement filter logic here if needed
            },
          ),
isLoading
    ? Center(child: CircularProgressIndicator())
    : (batchTuteeList == null ||
            batchTuteeList!.isEmpty ||
            batchTuteeList!.every((batch) => batch.tutees.isEmpty))
        ? Center(child: Text("No tutee found"))
        : Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                padding: EdgeInsets.zero,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, // 4 columns
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 0,
                  childAspectRatio: 0.1,
                ),
                scrollDirection: Axis.vertical,
                itemCount: batchTuteeList!
                    .fold(0, (sum, batch) => sum! + batch.tutees.length), 
                itemBuilder: (context, index) {
                  List<Tutee> allTutees = batchTuteeList!
                      .expand((batch) => batch.tutees)
                      .toList();

                  Tutee tutee = allTutees[index];

                  return Container(
                    margin: EdgeInsets.only(left: index == 0 ? 0 : 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.grey.shade200,
                          radius: 38,
                          child: tutee.profileUrl != null &&
                                  tutee.profileUrl!.isNotEmpty
                              ? ClipOval(
                                  child: Image.network(
                                    tutee.profileUrl!,
                                    fit: BoxFit.cover,
                                    width: 100,
                                    height: 100,
                                  ),
                                )
                              : const Icon(
                                  Icons.person,
                                  size: 36,
                                  color: Colors.black,
                                ),
                        ),
                        const SizedBox(height: 5),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.2,
                          child: Text(
                            '${tutee.firstName ?? ''} ${tutee.lastName ?? ''}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.4),
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          )

        ],
      ),
    );
  }
}