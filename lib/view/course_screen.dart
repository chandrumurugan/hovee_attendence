

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovee_attendence/controllers/course_controller.dart';
import 'package:hovee_attendence/utils/search_filter_tabber.dart';
import 'package:hovee_attendence/widget/single_custom_button.dart';


class TutorCourseList extends StatefulWidget {
  const TutorCourseList({super.key});

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
      body: Column(
        children: [
          // Header Section
          Container(
            height: 200,
            decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(0)),
          image: DecorationImage(
              image: AssetImage('assets/Course_BG_Banner.png',),
               
              fit: BoxFit.cover),
        ),
            child: Padding(
              padding: EdgeInsets.only(top: 25,left: 15),
              child:
                   Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(onPressed:(){
                   courseController.navigateBack();
                  },icon:  Icon(Icons.arrow_back, color: Colors.white)),
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
                // const SizedBox(
                //   height: 10,
                // ),
                Text(
                  'Lorem ipsum is simply dummy text\n of the printing industry',
                  style: GoogleFonts.nunito(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 14),
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
                searchOnTap: () {},
                filterOnTap: () {},
              ),
          // Course List Section
        ],
      ),
      // Bottom Button
        bottomNavigationBar: SingleCustomButtom(
        btnName: 'Add',
        isPadded: false,
        onTap: () {
         
        },
      ),
    );
  }

}
