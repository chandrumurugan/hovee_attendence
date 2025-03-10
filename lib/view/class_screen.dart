import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovee_attendence/constants/colors_constants.dart';
import 'package:hovee_attendence/controllers/class_controller.dart';
import 'package:hovee_attendence/utils/customAppBar.dart';
import 'package:hovee_attendence/utils/customDialogBox.dart';
import 'package:hovee_attendence/utils/search_filter_tabber.dart';
import 'package:hovee_attendence/view/dashboard_screen.dart';
import 'package:hovee_attendence/view/tution_class_preview_screen.dart';
import 'package:hovee_attendence/widget/single_button.dart';
import 'package:hovee_attendence/widget/single_custom_button.dart';

class TutorClassList extends StatelessWidget {
  final String type;
  final String? firstname, lastname, wowid;
  TutorClassList(
      {super.key,
      required this.type,
      this.firstname,
      this.lastname,
      this.wowid});

  final ClassController classController = Get.put(ClassController());
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
          }),
      body: Column(
        children: [
          Container(
            height: 150,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(0)),
              image: DecorationImage(
                  image: AssetImage(
                    'assets/Course_BG_Banner.png',
                  ),
                  fit: BoxFit.cover),
            ),
            child: Padding(
              padding: EdgeInsets.only(top: 25, left: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // IconButton(
                      //     onPressed: () {
                      //       courseController.navigateBack();
                      //     },
                      //     icon: Icon(Icons.arrow_back, color: Colors.white)),
                      Image.asset(
                        'assets/headerIcons/tutorCourseicon.png',
                        height: 35,
                      ),
                      //  const SizedBox(
                      //   height: 10,
                      // ),
                      Text(
                        'Classes',
                        style: GoogleFonts.nunito(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 22),
                      ),
                      // const SizedBox(
                      //   height: 10,
                      // ),
                      Container(
                        padding: EdgeInsets.only(right: 15),
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Text(
                          'Add your courses here to showcase your expertise and connect with eager learners',
                          maxLines: 2,
                          overflow: TextOverflow.clip,
                          style: GoogleFonts.nunito(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 14),
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
            title: 'Class list',
            onSearchChanged: (searchTerm) {
              classController.fetchClassesList('', searchTerm: searchTerm);
            },
            filterOnTap: () {},
          ),
          //Tabs for Active and Inactive
          TabBar(
              controller: classController.tabController,
              tabs: [
                Tab(text: 'Pending'),
                Tab(text: 'Live'),
              ],
              onTap: (value) {
                classController.handleTabChange(value);
              }),
          //Display List based on the selected tab
          Expanded(
            child: Obx(() {
              if (classController.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              } else if (classController.classesList.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Image.asset(
                        'assets/logo/No_Verification_Found_Image_app.png',
                        height: 200,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Center(
                          child: Text(
                        "No listing found",
                        style: GoogleFonts.nunito(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      )),
                    ],
                  ),
                );
              } else {
                return GetBuilder<ClassController>(
                  builder: (controller) => ListView.builder(
                    itemCount: classController.classesList.length,
                    itemBuilder: (context, index) {
                      final tutionCourseDetailsList =
                          classController.classesList[index];
                      return Animate(
                        effects: [
                          SlideEffect(
                            begin: Offset(-1, 0),
                            end: Offset(0, 0),
                            curve: Curves.easeInOut,
                            duration: 500.ms,
                            delay: 100.ms * index,
                          ),
                          FadeEffect(
                            begin: 0,
                            end: 1,
                            duration: 500.ms,
                            delay: 100.ms * index,
                          ),
                        ],
                        child: GestureDetector(
                          onTap: () {
                            Get.to(TutionClassPreviewScreen(
                              tutionCourseDetailsList: tutionCourseDetailsList,
                              firstname: firstname,
                            ));
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 5),
                            child: Card(
                              elevation: 10,
                              shadowColor: Colors.black,
                              surfaceTintColor: Colors.white,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildRow('Course code',
                                        tutionCourseDetailsList.courseCode),

                                    _buildRow('Batch name',
                                        tutionCourseDetailsList.batchName),

                                    _buildRow(
                                        'Board', tutionCourseDetailsList.board),

                                    _buildRow('Subject',
                                        tutionCourseDetailsList.subject),

                                    _buildRow(
                                        'Status',
                                        tutionCourseDetailsList.status ==
                                                "Public"
                                            ? "Live"
                                            : "Pending"),

                                    // Display the button only if selectedTabIndex is 0 (Draft tab)
                                    if (classController.instituteId == null ||
                                        classController.instituteId == '' &&
                                            classController
                                                    .selectedTabIndex.value ==
                                                0)
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SingleButton(
                                            btnName: 'Go live',
                                            onTap: () {
                                              //  classController.updateClass(
                                              //   context,
                                              //   tutionCourseDetailsList.courseCode!,
                                              //   tutionCourseDetailsList.courseId!,
                                              //   tutionCourseDetailsList.batchId!,
                                              //   tutionCourseDetailsList.batchName!,
                                              //   tutionCourseDetailsList.sId,
                                              // );
                                              _showConfirmationDialog(context,
                                                  tutionCourseDetailsList);
                                            },
                                          ),
                                          if (classController.instituteId ==
                                                  null ||
                                              classController.instituteId == '')
                                            IconButton(
                                              iconSize: 25,
                                              onPressed:
                                                  () {}, // No action needed here
                                              icon: PopupMenuButton<String>(
                                                icon:
                                                    const Icon(Icons.more_vert),
                                                onSelected: (String value) {
                                                  // Optional if further actions are needed after selection
                                                },
                                                itemBuilder:
                                                    (BuildContext context) {
                                                  return [
                                                    PopupMenuItem(
                                                      value: 'Delete',
                                                      child: ListTile(
                                                        leading: const Icon(
                                                            Icons.delete),
                                                        title: const Text(
                                                            'Delete'),
                                                        onTap: () {
                                                          Navigator.pop(
                                                              context);
                                                          _showConfirmationDeleteDialog(
                                                              context,
                                                              tutionCourseDetailsList
                                                                  .courseId!,tutionCourseDetailsList.status);
                                                        },
                                                      ),
                                                    ),
                                                  ];
                                                },
                                              ),
                                            ),
                                        ],
                                      ),
                                       classController
                                                    .selectedTabIndex.value ==
                                                1?
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        if (classController.instituteId ==
                                                null ||
                                            classController.instituteId == '')
                                          IconButton(
                                            iconSize: 25,
                                            onPressed:
                                                () {}, // No action needed here
                                            icon: PopupMenuButton<String>(
                                              icon: const Icon(Icons.more_vert),
                                              onSelected: (String value) {
                                                // Optional if further actions are needed after selection
                                              },
                                              itemBuilder:
                                                  (BuildContext context) {
                                                return [
                                                  PopupMenuItem(
                                                    value: 'Delete',
                                                    child: ListTile(
                                                      leading: const Icon(
                                                          Icons.delete),
                                                      title:
                                                          const Text('Delete'),
                                                      onTap: () {
                                                        Navigator.pop(context);
                                                        _showConfirmationDeleteDialog(
                                                            context,
                                                            tutionCourseDetailsList
                                                                .courseId!,tutionCourseDetailsList.status);
                                                      },
                                                    ),
                                                  ),
                                                ];
                                              },
                                            ),
                                          ),
                                      ],
                                    ):SizedBox.shrink()
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
            }),
          )
        ],
      ),
      bottomNavigationBar: GetBuilder<ClassController>(
        builder: (controller) {
          return (classController.instituteId == null ||
                  classController.instituteId == '')
              ? SingleCustomButtom(
                  btnName: 'Add',
                  isPadded: false,
                  onTap: () {
                    controller.navigateToAddCourseScreen();
                  },
                )
              : SizedBox.shrink();
        },
      ),

      //  Obx(() {
      //    if (classController.isLoading.value) {
      //         return Center(child: CircularProgressIndicator());
      //       }
      //      else if (classController.instituteId ==null || classController.instituteId == '') {
      //         return SingleCustomButtom(
      //   btnName: 'Add',
      //   isPadded: false,
      //   onTap: () {
      //     classController.navigateToAddCourseScreen();
      //   },
      // );
      //       } else  {
      //         return SizedBox.shrink();
      //       }
      //        }),
    );
  }

  Widget _buildRow(String title, String? value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
              color: Colors.black.withOpacity(0.4),
              fontWeight: FontWeight.w500,
              fontSize: 16),
        ),
        Text(
          value ?? '',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w400, fontSize: 16),
        ),
      ],
    );
  }

  void _showConfirmationDialog(
      BuildContext context, dynamic tutionCourseDetailsList) {
    showDialog(
      context: context,
      builder: (context) {
        return CustomDialogBox(
          title1: 'Start the class live now? Click Yes to begin the session.',
          title2: '',
          subtitle: 'Start the class live now? Click Yes to begin the session.',
          icon: const Icon(
            Icons.help_outline,
            color: Colors.white,
          ),
          color: Color(0xFF833AB4), // Set the primary color
          color1: const Color(0xFF833AB4), // Optional gradient color
          singleBtn: false, // Show both 'Yes' and 'No' buttons
          btnName: 'No',
          onTap: () {
            // Call the updateClass method when 'Yes' is clicked
            // Close the dialog after update
            Navigator.of(context).pop();
          },
          btnName2: 'Yes',
          onTap2: () {
            // Close the dialog when 'No' is clicked
            classController.updateClass(
              context,
              tutionCourseDetailsList.courseCode!,
              tutionCourseDetailsList.courseId!,
              tutionCourseDetailsList.batchId!,
              tutionCourseDetailsList.batchName!,
              tutionCourseDetailsList.sId,
            );
            // classController.tabController.animateTo(1);
            // classController.handleTabChange(1);
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  void _showConfirmationDeleteDialog(BuildContext context, String id,status) {
    showDialog(
      context: context,
      builder: (context) {
        return CustomDialogBox(
          title1: 'Do you want to delete this class?',
          title2: '',
          subtitle: 'Do you want to delete this class?',
          icon: const Icon(
            Icons.help_outline,
            color: Colors.white,
          ),
          color: Color(0xFF833AB4), // Set the primary color
          color1: const Color(0xFF833AB4), // Optional gradient color
          singleBtn: false, // Show both 'Yes' and 'No' buttons
          btnName: 'No',
          onTap: () {
            // Call the updateClass method when 'Yes' is clicked
            // Close the dialog after update
            Navigator.of(context).pop();
          },
          btnName2: 'Yes',
          onTap2: () {
            // Close the dialog when 'No' is clicked
            classController.deleteClass(context, id,status);
            // classController.tabController.animateTo(1);
            // classController.handleTabChange(1);
            Navigator.of(context).pop();
          },
        );
      },
    );
  }
}
