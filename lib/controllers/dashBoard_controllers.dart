import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hovee_attendence/services/webServices.dart';

class DashboardController extends GetxController {
   var selectedIndex = 0.obs; // Observable for selected index
  late PageController pageController; // PageController instance
  GlobalKey<ScaffoldState> tuteeScaffoldKey = GlobalKey<ScaffoldState>();

  Uint8List? qrcodeImageData;
  var isLoading = true.obs;
  var  qrcodeImage;
  @override
  void onInit() {
    super.onInit();
    pageController = PageController();
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


  void onPageChanged(int index) {
    selectedIndex.value = index;
  }

  void onItemTapped(int index) {
    selectedIndex.value = index;
    pageController.jumpToPage(index);
  }
  //  void onItemTapped(int index) {
  //   // Allow only the "Home" tab (index 0) to be clicked
  //   if (index == 0) {
  //     selectedIndex.value = index;
  //     pageController.jumpToPage(index);
  //   }
  // }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}