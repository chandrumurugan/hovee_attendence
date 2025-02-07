import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovee_attendence/controllers/course_controller.dart';
import 'package:hovee_attendence/utils/customAppBar.dart';
import 'package:hovee_attendence/utils/search_filter_tabber.dart';
import 'package:hovee_attendence/view/dashboard_screen.dart';
import 'package:hovee_attendence/widget/course_list_container.dart';
import 'package:hovee_attendence/widget/single_custom_button.dart';

class TutorCourseList extends StatefulWidget {
  final String type;
  final String? firstname,lastname,wowid;
  const TutorCourseList({super.key, required this.type, this.firstname, this.lastname, this.wowid});

  @override
  State<TutorCourseList> createState() => _TutorCourseListState();
}

class _TutorCourseListState extends State<TutorCourseList> {
  final CourseController courseController = Get.put(CourseController());

  @override
  void initState() {
    super.initState();
    // Replace 'YOUR_AUTH_TOKEN' with the actual token
    courseController.fetchCourseList();
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      appBar: AppBarHeader(
          needGoBack: true,
          navigateTo: () {
            Get.offAll(DashboardScreen(
              rolename: widget.type,
              firstname:widget.firstname ,lastname:widget.lastname ,wowid:widget. wowid,
            ));
          }),
      body: Column(
        children: [
          // Header Section
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
                        'Course',
                        style: GoogleFonts.nunito(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 22),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
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
            title: 'Course list',
            onSearchChanged: (searchTerm) {
              courseController.fetchCourseList(searchTerm: searchTerm);
            },
            filterOnTap: () {},
          ),
          Expanded(
  child: Obx(() {
    if (courseController.isLoading.value) {
      return Center(child: CircularProgressIndicator());
    } else if (courseController.initialLoad.value) {
      // Show loader during the initial load
      return Center(child: CircularProgressIndicator());
    } else if (courseController.courseList.isEmpty) {
      // Display "No data found" only after the initial load is complete
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
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      // Display the list of courses
      return ListView.separated(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemBuilder: (context, int index) {
          final course = courseController.courseList[index];
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
            child: CourseListContainer(
              arrowIcon: true,
              image: '',
              subject: course.subject!,
              subjectCode: course.courseCode!,
              std: course.className!,
              medium: course.board!,
              group: course.categories ?? '',
              groupcode: course.courseCode!,
              className: '',
              tutorId: '',
              batchname: course.batchName!,
              tutorname: '',
              type: widget.type,
              id: course.sId!,
              course: course,
              batchMaximumSlots: '',
              batchTimingStart: '',
              batchTimingEnd: '', instituteId: course.institudeId ?? '',
            ),
                        );
        },
        separatorBuilder: (context, int index) {
          return const SizedBox(height: 1);
        },
        itemCount: courseController.courseList.length,
      );
    }
  }),
),

        ],
      ),
      // Bottom Button
     bottomNavigationBar: GetBuilder<CourseController>(
  builder: (controller) {
    return (courseController.instituteId ==null || courseController.instituteId == '')
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
//        Obx(() {
//          if (courseController.isLoading.value) {
//               return Center(child: CircularProgressIndicator());
//             }
//            else if (courseController.instituteId ==null || courseController.instituteId == '') {
// return SingleCustomButtom(
//         btnName: 'Add',
//         isPadded: false,
//         onTap: () {
//           courseController.navigateToAddCourseScreen();
//         },
//       );
//             } else  {
//               return SizedBox.shrink();
//             }
//              }),
    );
  }
}
