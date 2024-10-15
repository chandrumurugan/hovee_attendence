

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hovee_attendence/controllers/splash_controllers.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatelessWidget {
  final SplashController splashController = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: SvgPicture.asset(
                  'assets/appConstantImg/app_icon.svg',
                  height: 50,
                ),
              ),
              const SizedBox(width: 6),
              Obx(() {
                return splashController.showSecondImage.value
                    ? SvgPicture.asset(
                        'assets/appConstantImg/logo_text.svg',
                        height: 40,
                        width: 40,
                      )
                    : SizedBox.shrink();
              }),
            ],
          ),
        ],
      ),
    );
  }
}