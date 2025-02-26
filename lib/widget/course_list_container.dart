import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hovee_attendence/constants/colors_constants.dart';
import 'package:hovee_attendence/controllers/courseDetails_controller.dart';
import 'package:hovee_attendence/controllers/course_controller.dart';
import 'package:hovee_attendence/modals/getCouseList_model.dart';
import 'package:hovee_attendence/utils/customDialogBox.dart';
import 'package:hovee_attendence/view/edit_batch_screen.dart';
import 'package:hovee_attendence/view/edit_course_screen.dart';

class CourseListContainer extends StatelessWidget {
  final String image;
  final String subject;
  final String subjectCode;
  final String std;
  final String medium;
  final String group;
  final bool arrowIcon;
  final String groupcode;
  final String className;
  final String tutorId;
  final String batchname;
  final String tutorname;
  final String type;
  final String id;
  final Data1 course;
  final String batchMaximumSlots;
  final String batchTimingStart;
  final String batchTimingEnd;
  final String instituteId;
  CourseListContainer(
      {super.key,
      required this.image,
      required this.subject,
      required this.subjectCode,
      required this.std,
      required this.medium,
      required this.group,
      required this.groupcode,
      required this.arrowIcon,
      required this.className,
      required this.tutorId,
      required this.batchname, required this.tutorname, required this.type, required this.id, required this.course, required this.batchMaximumSlots, required this.batchTimingStart, required this.batchTimingEnd, required this.instituteId});

  final CourseDetailController controller = Get.put(CourseDetailController());
  final CourseController courseController = Get.put(CourseController());
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0),
      child: Card(
        elevation: 10,
        shadowColor: Colors.black,
        surfaceTintColor: Colors.white,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              // Image.asset(image),

              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          subject,
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 15),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                       Container(
                          height: 15,
                          width: 1.5,
                          color: Colors.black.withOpacity(0.5),
                        ),
                       
                        const SizedBox(
                          width: 30,
                        ),

                        type=='Tutor'?
                         Text(
                          "$batchname",
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 14),
                        ):
                        Text(
                          "$subjectCode /month",
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 14),
                        ),
                        
                        //  type=='Tutor'?
                        //  Text(
                        //   "$batchname",
                        //   style: const TextStyle(
                        //       color: Colors.black,
                        //       fontWeight: FontWeight.w400,
                        //       fontSize: 14),
                        // ):
                        // Text(
                        //   "$subjectCode /month",
                        //   style: const TextStyle(
                        //       color: Colors.black,
                        //       fontWeight: FontWeight.w400,
                        //       fontSize: 14),
                        // ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                      Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              std,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              height: 1,
                              width: 10,
                              color: Colors.black.withOpacity(0.5),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              medium,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14),
                            ),
                            
                          ],
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                       
            
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      
                            // Visibility(
                            //   visible:   group != null,
                            //   child: Text(
                            //       group,
                            //       style: const TextStyle(
                            //           color: Colors.black,
                            //           fontWeight: FontWeight.w400,
                            //           fontSize: 15),
                            //     ),
                            // ),
                          
                        Text(
                          groupcode,
                          style: const TextStyle(
                              color: Color.fromRGBO(46, 91, 181, 1),
                              fontWeight: FontWeight.w400,
                              fontSize: 14),
                        ),
                      courseController. instituteId==null || courseController.instituteId == ''?
                        Row(
                  // mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {
                          // Add edit functionality
                         Get.to(EditCourseScreen(batch:course,));
                        },
                        icon: Icon(
                          Icons.edit,
                          color: Colors.blue,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          // Add delete functionality
                           // Navigator.pop(context);
                                           _showConfirmationDialog(
                                              context, id);
                        },
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ):SizedBox.shrink(),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                         type!='Tutor'?
                        RichText(
  text: TextSpan(
    children: [
      const TextSpan(
        text: "Tutor name: ",
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),
      ),
      TextSpan(
        text: tutorname,
        style: const TextStyle(
          color: Color.fromRGBO(46, 91, 181, 1),
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),
      ),
    ],
  ),
):Container(),


                        // arrowIcon
                        //     ? IconButton(
                        //         onPressed: () {
                        //           // Navigate to course details screen
                        //           type=='Tutee'?
                        //            controller. getClassTuteeById(
                        //                context,className,subject,tutorId,tutorname):Container();
                        //         },
                        //         icon: const Icon(
                        //           Icons.arrow_forward_ios_rounded,
                        //           size: 20,
                        //         ))
                        //     :

                             Visibility(
                              visible: !arrowIcon,
                               child: InkWell(
                                  onTap: () {},
                                  child: const CircleAvatar(
                                    radius: 25,
                                    backgroundColor: AppConstants.primaryColor,
                                    child: Text(
                                      'Punch',
                                      style: TextStyle(
                                          fontSize: 11, color: Colors.white),
                                    ),
                                  ),
                                ),
                             ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

     void _showConfirmationDialog(BuildContext context, String id) {
    showDialog(
      context: context,
      builder: (context) {
        return CustomDialogBox(
          title1: 'Do you want to delete this course?',
          title2: '',
          subtitle: 'Do you want to delete this course?',
          icon: const Icon(
            Icons.help_outline,
            color: Colors.white,
          ),
          color: const Color(0xFF833AB4), // Set the primary color
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
            courseController.deleteCourse(context, id);
            // classController.tabController.animateTo(1);
            // classController.handleTabChange(1);
            Navigator.of(context).pop();
          },
        );
      },
    );
  }
}

class CourseListContainer1 extends StatelessWidget {
  final String image;
  final String subject;
  final String subjectCode;
  final String std;
  final String medium;
  final String group;
  final bool arrowIcon;
  final String groupcode;
  final String className;
  final String tutorId;
  final String batchname;
  final String tutorname;
  final String type;
  final String id;
    final String batchMaximumSlots;
  final String batchTimingStart;
  final String batchTimingEnd;
  final String address;
  final String courseId;
  final String ratings;
  CourseListContainer1(
      {super.key,
      required this.image,
      required this.subject,
      required this.subjectCode,
      required this.std,
      required this.medium,
      required this.group,
      required this.groupcode,
      required this.arrowIcon,
      required this.className,
      required this.tutorId,
      required this.batchname, required this.tutorname, required this.type, required this.id, required this.batchMaximumSlots, required this.batchTimingStart, required this.batchTimingEnd, required this.address, required this.courseId, required this.ratings,});

  final CourseDetailController controller = Get.put(CourseDetailController());
  final CourseController courseController = Get.put(CourseController());
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
      child: Card(
        elevation: 10,
        shadowColor: Colors.black,
        surfaceTintColor: Colors.white,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              // Image.asset(image),

              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          subject,
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 15),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        // Container(
                        //   height: 15,
                        //   width: 1.5,
                        //   color: Colors.black.withOpacity(0.5),
                        // ),
                        const SizedBox(
                          width: 10,
                        ),
                        //  type=='Tutor'?
                         Text(
                          "$batchname",
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 14),
                        )
                        // Text(
                        //   "$subjectCode /month",
                        //   style: const TextStyle(
                        //       color: Colors.black,
                        //       fontWeight: FontWeight.w400,
                        //       fontSize: 14),
                        // ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                      Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              std,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              height: 1,
                              width: 10,
                              color: Colors.black.withOpacity(0.5),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              medium,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14),
                            ),
                            
                          ],
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          height: 15,
                          width: 1.5,
                          color: Colors.black.withOpacity(0.5),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
            type=='Tutor'?
                         Text(
                          "$batchname",
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 14),
                        ):
                        Text(
                          "$subjectCode /month",
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 14),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // group != null
                        //     ? Text(
                        //         group,
                        //         style: const TextStyle(
                        //             color: Colors.black,
                        //             fontWeight: FontWeight.w400,
                        //             fontSize: 15),
                        //       )
                        //     : Container(),
                        Text(
                          groupcode,
                          style: const TextStyle(
                              color: Color.fromRGBO(46, 91, 181, 1),
                              fontWeight: FontWeight.w400,
                              fontSize: 14),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                         type!='Tutor'?
                        RichText(
  text: TextSpan(
    children: [
      const TextSpan(
        text: "Tutor name: ",
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),
      ),
      TextSpan(
        text: tutorname,
        style: const TextStyle(
          color: Color.fromRGBO(46, 91, 181, 1),
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),
      ),
    ],
  ),
):Container(),


                        arrowIcon
                            ? IconButton(
                                onPressed: () {
                                  // Navigate to course details screen
                                  type=='Tutee'?
                                   controller. getClassTuteeById(
                                       context,className,subject,tutorId,tutorname,subjectCode,batchMaximumSlots,batchTimingStart,batchTimingEnd,address,courseId,ratings):Container();
                                },
                                icon: const Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 20,
                                ))
                            : InkWell(
                                onTap: () {},
                                child: const CircleAvatar(
                                  radius: 25,
                                  backgroundColor: AppConstants.primaryColor,
                                  child: Text(
                                    'Punch',
                                    style: TextStyle(
                                        fontSize: 11, color: Colors.white),
                                  ),
                                ),
                              ),
                      ],
                    ),
                    Container(
                      width: 80,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 3),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,),
                              child: Row(
                                children: [
                                   Text(ratings ?? '0',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14.0,
                                        color: Colors.black,
                                      )),
                                      SizedBox(width: 5),
                                  Image.asset('assets/tutorHomeImg/star 1.png')
                                ],
                              ),
                            ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

