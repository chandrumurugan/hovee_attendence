import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovee_attendence/controllers/course_controller.dart';
import 'package:hovee_attendence/utils/customAppBar.dart';
import 'package:hovee_attendence/utils/search_filter_tabber.dart';
import 'package:hovee_attendence/widget/course_list_container.dart';
import 'package:hovee_attendence/widget/single_custom_button.dart';

class TutorCourseList extends StatefulWidget {
   final String type;
  const TutorCourseList({super.key, required this.type});

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
      appBar: AppBarHeader(needGoBack:true, navigateTo: (){
         courseController.navigateBack();

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
                        width: MediaQuery.of(context).size.width* 0.9,
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
            title: 'Course List',
            onSearchChanged: (searchTerm) {
              courseController.fetchCourseList(searchTerm: searchTerm);
            },
            filterOnTap: () {
            },
          ),
          Expanded(
            child: Obx(() {
              if (courseController.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              } else if (courseController.courseList.isEmpty) {
                print(courseController.courseList);
                // Display "No data found" when the list is empty
                return Center(
                  child: Text(
                    'No data found',
                    style: GoogleFonts.nunito(
                      color: Colors.black54,
                      fontSize: 16,
                    ),
                  ),
                );
              } else {
                // Display the list of batches
                return ListView.separated(
                    itemBuilder: (context, int index) {
                      final course = courseController.courseList[index];
                      return CourseListContainer(
                          arrowIcon: true,
                          image: '',
                          subject: course.subject!,
                          subjectCode: course.courseCode!,
                          std: course.className!,
                          medium: course.board!,
                          group: course.categories ?? '',         
                          groupcode: course.courseCode!, className: '', tutorId: '', batchname: course.batchName!, tutorname:'', type: widget.type,);
                    },
                    separatorBuilder: (context, int index) {
                      return const SizedBox(
                        height: 5,
                      );
                    },
                    itemCount: courseController.courseList.length);
              }
            }),
          )
        ],
      ),
      // Bottom Button
      bottomNavigationBar: SingleCustomButtom(
        btnName: 'Add',
        isPadded: false,
        onTap: () {
          courseController.navigateToAddCourseScreen();
        },
      ),
    );
  }
}
