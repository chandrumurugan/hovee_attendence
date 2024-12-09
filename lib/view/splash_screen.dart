// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovee_attendence/constants/colors_constants.dart';
import 'package:hovee_attendence/controllers/auth_controllers.dart';
import 'package:hovee_attendence/controllers/splash_controllers.dart';
import 'package:hovee_attendence/widget/gifController.dart';

class SplashScreen extends StatelessWidget {
  //  final Future<void> Function() onInitializationComplete;
     SplashScreen({Key? key,})
      : super(key: key);
  final SplashController splashController = Get.put(SplashController());
  final AuthControllers classController = Get.put(AuthControllers());
  @override
  Widget build(BuildContext context) {
    // _startInitialization();
    return Scaffold(
      body: Stack(
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LogoGif(issplash: true),
                ],
              )
         
            ],
          ),
          Positioned(
            bottom: 14,
            left: MediaQuery.of(context).size.width * 0.2,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Your presence not your absence',
                      style: GoogleFonts.nunito(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    width: 97,
                    child: Obx(() {
                      return LinearProgressIndicator(
                        minHeight: 5.0,
                        backgroundColor: Colors.grey[200],
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          AppConstants.primaryColor,
                        ),
                        value: splashController.progressValue.value,
                        borderRadius: BorderRadius.circular(20),
                      );
                    }),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }


  //   Future<void> _startInitialization() async {
  //   // await Future.delayed(const Duration(seconds: 3)); // Splash screen delay
  //   await onInitializationComplete();
  // }
}
