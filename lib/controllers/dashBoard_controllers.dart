import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hovee_attendence/services/webServices.dart';
import 'package:logger/logger.dart';

class DashboardController extends GetxController {
   var selectedIndex = 0.obs; // Observable for selected index
  late PageController pageController; // PageController instance
  GlobalKey<ScaffoldState> tuteeScaffoldKey = GlobalKey<ScaffoldState>();
  RxList<int> navigationStack = <int>[].obs;



  Uint8List? qrcodeImageData;
  var isLoading = true.obs;
  var  qrcodeImage;
   List<int> _navigationStack = [];
  @override
  void onInit() {
    super.onInit();
    pageController = PageController();
    fetchQrCodeImage();
       navigationStack.add(selectedIndex.value);
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
    Logger().d("getting nabvigation value==>${navigationStack.value}");
    // selectedIndex.value = index;
    // pageController.jumpToPage(index);
        if (navigationStack.isEmpty || navigationStack.last != index) {
      navigationStack.add(index); // Push the new index to the stack
      selectedIndex.value = index;
      pageController.jumpToPage(index);
    }else{
      Logger().i("getting not back");
    }
  }

    Future<bool> handleBackButton() async {
    if (navigationStack.length > 1) {
      // Pop the last index and navigate to the previous index
      navigationStack.removeLast();
      int previousIndex = navigationStack.last;
      selectedIndex.value = previousIndex;
      pageController.jumpToPage(previousIndex);
      return false; // Indicate that the back action was handled
    } else {
      return true; // Allow the system back action (exit app)
    }
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

   void navigateFunc() {
  if (_navigationStack.isNotEmpty) { // Check if the stack is not empty
    // Remove the last element and navigate to the previous bottom tab
    _navigationStack.removeLast();
    
    // Check again to ensure there's still an element in the stack
    if (_navigationStack.isNotEmpty) {
      selectedIndex = _navigationStack.last.obs;
      pageController.jumpToPage(selectedIndex.value);
    }
  } else {
    // Handle the case when the navigation stack is empty, if needed
    print("Navigation stack is empty, cannot navigate back.");
  }
}

}