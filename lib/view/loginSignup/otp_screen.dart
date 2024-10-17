import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hovee_attendence/controllers/auth_controllers.dart';
import 'package:hovee_attendence/utils/customAppBar.dart';
import 'package:hovee_attendence/utils/customDialogBox.dart';
import 'package:pinput/pinput.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //  final AuthControllers authController = Get.put(AuthControllers());
    // final authController = Get.put(AuthControllers());
    final authController = Get.find<AuthControllers>();
    const focusedBorderColor = Colors.white;
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
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  width: MediaQuery.sizeOf(context).width,
                  height: MediaQuery.sizeOf(context).height * 0.24,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/image 194.png'),
                        fit: BoxFit.cover),
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
                        height: 10,
                      ),
                      Text(
                        'Welcome !',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 24),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      // const Text(
                      //   'Lorem Ipsum is simply dummy text\n of the printing and typesetting industry',
                      //   style: TextStyle(
                      //       color: Colors.white,
                      //       fontWeight: FontWeight.w400,
                      //       fontSize: 16),
                      // ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.2,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    children: [
                      Visibility(
                        visible: authController.tabController.index == 0,
                        child: Image.asset(
                          'assets/appConstantImg/loginSignupI/image 203.png',
                          height: 150,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Card(
                elevation: 10,
                shadowColor: Colors.black,
                surfaceTintColor: Colors.white,
                color: Colors.white,
                child: Container(
                  height: 250,
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
                      TabBar(
                        dragStartBehavior: DragStartBehavior.down,
                        controller: authController.tabController,
                        onTap: (int index) {
                          authController.currentTabIndex.value = index;
                          authController.isLoading.value = false;
                        },
                        tabs: const [
                          Tab(
                            text: 'Login',
                          ),
                          Tab(
                            text: 'Sign up',
                          ),
                        ],
                        unselectedLabelColor: Colors.grey,
                        unselectedLabelStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        labelStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'OTP',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  'Enter the otp sent to +91 ${authController.currentTabIndex == 0 ? authController.logInController.text : authController.phController.text}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey,
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: 50,
                              padding: const EdgeInsets.symmetric(vertical: 5),
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
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  length: 6,
                                  controller: authController.otpController,
                                  focusNode: authController.focusNode,
                                  // androidSmsAutofillMethod:
                                  //     AndroidSmsAutofillMethod
                                  //         .smsUserConsentApi,
                                  // listenForMultipleSmsOnAndroid:
                                  //     true,
                                  defaultPinTheme: defaultPinTheme,
                                  separatorBuilder: (index) =>
                                      const SizedBox(width: 8),
                                  validator: (value) {
                                    return value == '222222' ? null : null;
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
                                    mainAxisAlignment: MainAxisAlignment.end,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () async {
                                    var valiue = await authController.otp();
                                    if (valiue == 200) {
                                      showModalBottomSheet(
                                        context: context,
                                        isDismissible: false,
                                        builder: (BuildContext context) {
                                          return CustomDialogBox(
                                            singleBtn: true,
                                            title1: 'Logged In ',
                                            title2: 'Successfully',
                                            color: const Color(0xFFC13584),
                                            color1: const Color(0xFF833AB4),
                                            icon: const Icon(
                                              Icons.check,
                                              color: Colors.white,
                                            ),
                                            subtitle:
                                                "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, ",
                                            btnName: 'Ok',
                                            onTap: () {
                                              // Navigator.pushReplacement(
                                              //     context,
                                              //     MaterialPageRoute(
                                              //         builder: (context) => const AccountSetup()));
                                              Get.snackbar("Development",
                                                  "Developmewnt is in progreess");

                                              // Navigator.pushReplacement(
                                              //     context,
                                              //     MaterialPageRoute(
                                              //         builder: (context) => const RoleSelection()));
                                            },
                                          );
                                        },
                                      );
                                    }
                                  },
                                  child: Container(
                                    height: 48,
                                    // width: 168,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 40,
                                    ),
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(8),
                                      ),
                                      gradient: LinearGradient(
                                        colors: [
                                          Color(0xFFC13584),
                                          Color(0xFF833AB4)
                                        ],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                      ),
                                    ),
                                    child: Obx(() {
                                      return authController.isLoading.value
                                          ? const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            )
                                          : const Center(
                                              child: Text(
                                                'Verify Code',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            );
                                    }),
                                    // child: _isLoading1
                                    //     ? const ButtonLoader()
                                    // : const Center(
                                    //     child: Text(
                                    //       'Verify Code',
                                    //       style:
                                    //           TextStyle(
                                    //         fontSize: 16,
                                    //         fontWeight:
                                    //             FontWeight
                                    //                 .w600,
                                    //         color: Colors
                                    //             .white,
                                    //       ),
                                    //     ),
                                    //   ),
                                  ),
                                ),
                                Text(
                                    "${authController.currentTabIndex == 0 ? authController.loginResponse.value.otp : authController.registerResponse.value.data!.otp!}"),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
