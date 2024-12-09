import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovee_attendence/controllers/parent_controller.dart';
import 'package:hovee_attendence/utils/customAppBar.dart';
import 'package:hovee_attendence/utils/customDialogBox.dart';
import 'package:hovee_attendence/view/roleSelection.dart';
import 'package:pinput/pinput.dart';

class ParentOtpScreen extends StatelessWidget {
   ParentOtpScreen({super.key});
 final ParentController parentController = Get.put(ParentController());
  @override
  Widget build(BuildContext context) {
    const focusedBorderColor = Colors.blue;
    final defaultPinTheme = PinTheme(
      width: 50,
      height: 38,
      textStyle: const TextStyle(
        fontSize: 22,
        // color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        border: Border(right: BorderSide(color: Colors.grey.shade400)),
      ),
    );
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBarHeader(
          needGoBack: false,
          navigateTo: () {},
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 20, top: 10),
                      width: MediaQuery.sizeOf(context).width,
                      height: MediaQuery.sizeOf(context).height * 0.24,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/image 194.png'),
                          fit: BoxFit.cover,
                        ),
                        gradient: LinearGradient(
                          colors: [Color(0xFFC13584), Color(0xFF833AB4)],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Welcome !',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 24,
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              //SizedBox(height: MediaQuery.sizeOf(context).height * 0.2),
              Padding(
                padding: const EdgeInsets.only(top: 55),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Card(
                        elevation: 10,
                        shadowColor: Colors.black,
                        surfaceTintColor: Colors.white,
                        color: Colors.white,
                        child: Container(
                          height: 320,
                          width: MediaQuery.sizeOf(context).width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: Colors.white,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 10),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                            "Enter the OTP sent to your\nmobile number or email ID",
                                            style: GoogleFonts.nunito(
                                                fontSize: 16.0,
                                                color: const Color(0xFF000000),
                                                fontWeight: FontWeight.w600)),
                                        // Text(
                                        //   'Enter the otp sent to +91 ${authController.currentTabIndex == 0 ? authController.logInController.text : authController.phController.text}',
                                        //   style: const TextStyle(
                                        //     fontSize: 12,
                                        //     fontWeight: FontWeight.w400,
                                        //     color: Colors.grey,
                                        //   ),
                                        // )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      height: 50,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.grey.shade300,
                                        ),
                                        color: Colors.black.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(
                                          12,
                                        ),
                                      ),
                                      child: Directionality(
                                        // Specify direction if desired
                                        textDirection: TextDirection.ltr,
                                        child: Pinput(
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly
                                          ],
                                          length: 6,
                                          controller:
                                              parentController.otpController,
                                          focusNode: parentController.focusNode,
                                          // androidSmsAutofillMethod:
                                          //     AndroidSmsAutofillMethod
                                          //         .smsUserConsentApi,
                                          // listenForMultipleSmsOnAndroid:
                                          //     true,
                                          defaultPinTheme: defaultPinTheme,
                                          separatorBuilder: (index) =>
                                              const SizedBox(width: 8),
                                          validator: (value) {
                                            return value == '222222'
                                                ? null
                                                : null;
                                          },
                                          // onClipboardFound: (value) {
                                          //   debugPrint('onClipboardFound: $value');
                                          //   pinController.setText(value);
                                          // },
                                          hapticFeedbackType:
                                              HapticFeedbackType.lightImpact,
                                          onCompleted: (pin) {
                                            debugPrint('onCompleted: $pin');
                                          },
                                          onChanged: (value) {
                                            debugPrint('onChanged: $value');
                                          },
                                          cursor: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Container(
                                                margin: const EdgeInsets.only(
                                                  bottom: 0,
                                                ),
                                                width: 22,
                                                height: 1,
                                                color: focusedBorderColor,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                          onTap: () async {
                                            var value = await parentController
                                                .otp(context);
                                            if (value!.statusCode == 200) {      
                                              showModalBottomSheet(
                                                isDismissible: false,
                                                enableDrag: false,
                                                context: context,
                                                backgroundColor:
                                                    Colors.transparent,
                                                builder: (context) {
                                                  return CustomDialogBox(
                                                    title1: "Login Successfully",
                                                    title2: '',
                                                    subtitle: 'subtitle',
                                                    btnName: 'Ok',
                                                    onTap: () {
                                                      if (value.parentAccount!) {
                                                              showDialog(
                                                                
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Success'),
                content: Column(
                  children: [
                     _buildRow('Tutee name',  '${value.userDetail!.firstName} $value.userDetail!.lastName}',),
                                            _buildRow('Wow ID',value.userDetail!.wowId),
                                            _buildRow('Email', value.userDetail!.email),
                                             _buildRow('Phone number', '${value.userDetail!.phoneNumber}',),
                                           _buildRow('DOB', value.userDetail!.dob ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                  parentController.  updateEnrollment(context,value.parentDetail!.sId!,value.userDetail!.sId!);
                      Navigator.of(context).pop(); // Close the dialog
                    },
                    child: Text('Accept'),
                  ),
                  TextButton(
                    onPressed: () {
                  
                      Navigator.of(context).pop(); // Close the dialog
                    },
                    child: Text('Reject'),
                  ),
                ],
              );
            },
          );
                                                        
                                                      } else {
                                                        Get.offAll(() =>
                                                            const RoleSelection());
                                                      }
                                                    },
                                                    icon: const Icon(
                                                      Icons.check,
                                                      color: Colors.white,
                                                    ),
                                                    color:
                                                        const Color(0xFF833AB4),
                                                    singleBtn: true,
                                                  );
                                                },
                                              );
                                            }
                                          },
                                          child: Container(
                                            height: 48,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 40),
                                            decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8)),
                                              gradient: LinearGradient(
                                                colors: [
                                                  Color(0xFFC13584),
                                                  Color(0xFF833AB4)
                                                ],
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                              ),
                                            ),
                                            child:
                                            //  Obx(() {
                                              const Center(
                                                      child: Text(
                                                        'Verify Code',
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    )
                                            // }),
                                          ),
                                        ),
                                         Obx(() {
                                          if( parentController.code.value.isEmpty){
                                            return const SizedBox.shrink();
                                          }
                                         
                                          return Text(
                                              parentController.code.value);
                                        }),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    // Padding(
                                    //   padding: const EdgeInsets.symmetric(
                                    //     horizontal: 8,
                                    //   ),
                                    //   child: Align(
                                    //     alignment: Alignment.centerRight,
                                    //     child: Obx(() {
                                    //       return parentController.isTimerRunning
                                    //           ? Text(
                                    //               'Resend in ${parentController.timerValue} secs',
                                    //               style: GoogleFonts.nunito(
                                    //                 fontSize: 16,
                                    //                 fontWeight: FontWeight.w500,
                                    //                 color:
                                    //                     const Color(0xffD9D9D9),
                                    //               ),
                                    //             )
                                    //           : TextButton(
                                    //               onPressed: () {
                                    //                 parentController
                                    //                     .resendOtp(context);
                                    //               },
                                    //               child: Text(
                                    //                 'Didn\'t receive OTP? Resend OTP',
                                    //                 style: GoogleFonts.nunito(
                                    //                   fontSize: 16,
                                    //                   fontWeight:
                                    //                       FontWeight.w600,
                                    //                   color: const Color(
                                    //                       0xff0024A5),
                                    //                 ),
                                    //               ),
                                    //             );
                                    //     }),
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      children: [
                        Image.asset(
                          'assets/appConstantImg/loginSignupI/image 203.png',
                          height: 150,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
        );
  }

  Widget _buildRow(String title, String? value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
              color: Colors.black.withOpacity(0.4),
              fontWeight: FontWeight.w500,
              fontSize: 16),
        ),
        Text(
          value ?? '',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 14),
        ),
      ],
    );
  }
}
