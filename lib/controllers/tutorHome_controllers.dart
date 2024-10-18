
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TutorHomeController extends GetxController{
    GlobalKey<ScaffoldState> tutorScaffoldKey = GlobalKey<ScaffoldState>();

       final List<Map<String, dynamic>> monitor = [
    {
      'title': 'Institute',
      'image': 'assets/tutorHomeImg/leave 1.png',
      'desc': 'Lorem Ipsum is simply dummy ',
      'color': const Color.fromRGBO(240, 119, 33, 1)
    },
    {
      'title': 'Teacher',
      'image': 'assets/tutorHomeImg/teacher (2) 1.png',
      'desc': 'Lorem Ipsum is simply dummy ',
      'color': const Color.fromRGBO(81, 2, 112, 1)
    },
    {
      'title': 'Batches',
      'image': 'assets/tutorHomeImg/classroom 1 (1).png',
      'desc': 'Lorem Ipsum is simply dummy',
      'color': const Color.fromRGBO(240, 119, 33, 1)
    },
    {
      'title': 'Courses',
      'image': 'assets/tutorHomeImg/online-learning (2) 1 (1).png',
      'desc': 'Lorem Ipsum is simply dummy',
      'color': const Color.fromRGBO(126, 113, 255, 1).withOpacity(0.7)
    },
    {
      'title': 'Classes',
      'image': 'assets/tutorHomeImg/online-learning (2) 1 (1).png',
      'desc': 'Lorem Ipsum is simply dummy',
      'color': const Color.fromRGBO(126, 113, 255, 1).withOpacity(0.7)
    },
    {
      'title': 'Attendance',
      'image': 'assets/tutorHomeImg/calendar (1) 1.png',
      'desc': 'Lorem Ipsum is simply dummy ',
      'color': const Color.fromRGBO(186, 1, 97, 1)
    },
    {
      'title': 'Leave',
      'image': 'assets/tutorHomeImg/leave 1.png',
      'desc': 'Lorem Ipsum is simply dummy ',
      'color': const Color.fromRGBO(126, 113, 255, 1)
    },
    {
      'title': 'MSB',
      'image': 'assets/tutorHomeImg/online-learning (1) 1.png',
      'desc': 'Lorem Ipsum is simply dummy ',
      'color': const Color.fromRGBO(100, 155, 80, 1)
    },
    {
      'title': 'Holiday',
      'image': 'assets/tutorHomeImg/holiday 1 (1).png',
      'desc': 'Lorem Ipsum is simply dummy ',
      'color': const Color.fromRGBO(186, 1, 97, 1)
    },
  ];
}