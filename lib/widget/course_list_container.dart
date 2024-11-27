import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hovee_attendence/constants/colors_constants.dart';
import 'package:hovee_attendence/controllers/courseDetails_controller.dart';
import 'package:hovee_attendence/controllers/course_controller.dart';
import 'package:hovee_attendence/modals/getCouseList_model.dart';
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
      required this.batchname, required this.tutorname, required this.type, required this.id, required this.course});

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
                        Container(
                          height: 15,
                          width: 1.5,
                          color: Colors.black.withOpacity(0.5),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Row(
                  mainAxisAlignment: MainAxisAlignment.end,
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
                          courseController.deleteCourse(context, id);
                        },
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                    ],
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
                        group != null
                            ? Text(
                                group,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15),
                              )
                            : Container(),
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
                                       context,className,subject,tutorId,tutorname):Container();
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
      required this.batchname, required this.tutorname, required this.type, required this.id,});

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
                        group != null
                            ? Text(
                                group,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15),
                              )
                            : Container(),
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
                                       context,className,subject,tutorId,tutorname):Container();
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

