
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hovee_attendence/modals/getQrcode_model.dart';
import 'package:hovee_attendence/services/webServices.dart';
import 'package:logger/logger.dart';

class TutorHomeController extends GetxController{
    GlobalKey<ScaffoldState> tutorScaffoldKey = GlobalKey<ScaffoldState>();

       final List<Map<String, dynamic>> monitor = [
    // {
    //   'title': 'Institute',
    //   'image': 'assets/tutorHomeImg/leave 1.png',
    //   'desc': 'Lorem Ipsum is simply dummy ',
    //   'color': const Color.fromRGBO(240, 119, 33, 1)
    // },

       {
      'title': 'Attendance',
      'image': 'assets/tutorHomeImg/calendar (1) 1.png',
      'desc': 'Lorem Ipsum is simply dummy ',
      'color': const Color.fromRGBO(186, 1, 97, 1)
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
      'title': 'Teacher',
      'image': 'assets/tutorHomeImg/teacher (2) 1.png',
      'desc': 'Lorem Ipsum is simply dummy ',
      'color': const Color.fromRGBO(81, 2, 112, 1)
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
      {
      'title': 'Annoucement',
      'image': 'assets/tutorHomeImg/online-learning (1) 1.png',
      'desc': 'Lorem Ipsum is simply dummy ',
      'color': const Color.fromARGB(255, 240, 75, 226)
    },
    {
      'title': 'Enquiries',
      'image': 'assets/tuteeHomeImg/online-learning (1) 1.png',
      'desc': 'Lorem Ipsum is simply dummy ',
      'color': const Color.fromRGBO(81, 2, 112, 1)
    },
    {
      'title': 'Enrollment',
      'image': 'assets/tuteeHomeImg/leave 1.png',
      'desc': 'Lorem Ipsum is simply dummy ',
      'color': const Color.fromRGBO(240, 119, 33, 1)
    },
  ];
  var token = GetStorage();

   var isLoading = true.obs;

    var  qrcodeImage;

    Uint8List? qrcodeImageData;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    Logger().i(token.read('Token') ?? "");
    fetchQrCodeImage();
  }

 

void fetchQrCodeImage() async {
  try {
    isLoading(true);
    var qrcodeResponse = await WebService.fetchQrCode();
    print("API Response: ${qrcodeResponse.data}");

    if (qrcodeResponse.data != null) {
      qrcodeImage = qrcodeResponse.data!.qrCode;
      try{
        qrcodeImage = qrcodeImage.replaceFirst(RegExp(r'data:image\/\w+;base64,'), '');

      if (qrcodeImage.isNotEmpty) {
        // Decode the base64 string to Uint8List
        qrcodeImageData = base64Decode(qrcodeImage);
        print("Decoded QR Code Image Data: $qrcodeImageData");
      } else {
        print("Error: Base64 QR Code string is empty.");
      }
      }
      catch(e){
        print("123456667777==>$e");
      }
      // Remove potential metadata prefix
      
    } else {
      print("Error: qrcodeResponse.data is null.");
    }
  } catch (e) {
    print("Exception caught: $e");
  } finally {
    isLoading(false);
  }
}

}