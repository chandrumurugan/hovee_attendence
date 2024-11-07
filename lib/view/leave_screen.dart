import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hovee_attendence/controllers/leave_controller.dart';
import 'package:hovee_attendence/utils/customAppBar.dart';
import 'package:hovee_attendence/widget/single_custom_button.dart';

class TuteeLeaveScreen extends StatelessWidget {
   TuteeLeaveScreen({super.key});

final TuteeLeaveController leaveController = Get.put(TuteeLeaveController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarHeader(
          needGoBack: true,
          navigateTo: () {
            Get.back();
          }),
          body: Column(
            children: [

            ],
          ),
          bottomNavigationBar: SingleCustomButtom(
        btnName: 'Add Leave',
        isPadded: false,
        onTap: () {
         leaveController.navigateToAddBatchScreen();
        },
      ),);
  }
}