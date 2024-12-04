import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovee_attendence/constants/colors_constants.dart';
import 'package:hovee_attendence/controllers/auth_controllers.dart';
import 'package:hovee_attendence/controllers/splash_controllers.dart';
import 'package:hovee_attendence/widget/gifController.dart';

class SplashScreen extends StatelessWidget {
  final SplashController splashController = Get.put(SplashController());
  final AuthControllers classController = Get.put(AuthControllers());
  @override
  Widget build(BuildContext context) {
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
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     ClipRRect(
              //       borderRadius: BorderRadius.circular(12.0),
              // child: SvgPicture.asset(
              //   'assets/appConstantImg/app_icon.svg',
              //   height: 50,
              // ),
              //     ),
              //     const SizedBox(width: 6),
              //     Obx(() {
              //       return splashController.showSecondImage.value
              //           ? SvgPicture.asset(
              //               'assets/appConstantImg/logo_text.svg',
              //               height: 40,
              //               width: 40,
              //             )
              //           : SizedBox.shrink();
              //     }),
              //   ],
              // ),

              // Align(
              //   alignment: Alignment.bottomCenter,
              //   child: Column(
              //     mainAxisSize: MainAxisSize.min,
              //     mainAxisAlignment: MainAxisAlignment.end,
              //     children: [
              //     ,
              //       // const SizedBox(height: 16),
              // SizedBox(
              //   width: 97,
              //   child: LinearProgressIndicator(
              //     minHeight: 5.0,
              //     backgroundColor: Colors.grey[200],
              //     valueColor:  AlwaysStoppedAnimation<Color>(
              //         AppConstants.primaryColor),
              //     value: splashController.progressValue.value,
              //     borderRadius: BorderRadius.circular(20),
              //   ),
              // ),
              //     ],
              //   ),
              // ),
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
}
