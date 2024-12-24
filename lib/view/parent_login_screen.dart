import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovee_attendence/controllers/parent_controller.dart';
import 'package:hovee_attendence/utils/customAppBar.dart';
import 'package:hovee_attendence/utils/inputTextField.dart';
import 'package:hovee_attendence/utils/snackbar_utils.dart';
import 'package:hovee_attendence/view/dashboard_screen.dart';
import 'package:hovee_attendence/view/parent_otp_screen.dart';
import 'package:share_plus/share_plus.dart';

class ParentLoginScreen extends StatelessWidget {
  final String rolename;
  final String? firstname,lastname,wowid;
  ParentLoginScreen({super.key, required this.rolename, this.firstname, this.lastname, this.wowid});
  final ParentController parentController = Get.put(ParentController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: AppBarHeader(
              needGoBack: true,
              navigateTo: () {
                Get.back()  ;
              },
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
                        child:  Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                            rolename=='Tutee'?  'Invite Parent' :'Invite children',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 24),
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
                Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.1),
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Card(
                            elevation: 10,
                            shadowColor: Colors.black,
                            surfaceTintColor: Colors.white,
                            color: Colors.white,
                            child: Obx(() {
                              return Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.3,
                                  width: MediaQuery.sizeOf(context).width,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    color: Colors.white,
                                  ),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(
                                                height: 14,
                                              ),
                                              Text(
                                                'Enter Phone no',
                                                style: GoogleFonts.nunito(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              InputTextField(
                                                suffix: false,
                                                readonly: false,
                                                inputFormatter: [
                                                  FilteringTextInputFormatter
                                                      .allow(
                                                    RegExp(
                                                      r"[a-zA-Z0-9\s@&_,-\/.']",
                                                    ),
                                                  ),
                                                ],
                                                hintText: 'Enter here...',
                                                keyboardType:
                                                    TextInputType.emailAddress,
                                                controller: parentController
                                                    .logInController,
                                              ),
                                              SizedBox(
                                                height: 30,
                                              ),
                                              Row(
                                                children: [
                                                  InkWell(
                                                    onTap: () async {
                                                      var response =
                                                          await parentController
                                                              .logIn(
                                                        parentController
                                                            .logInController
                                                            .text,
                                                        context,
                                                      );

                                                      if (response != null &&
                                                          response.statusCode ==
                                                              200) {
                                                        showDialog(
                                                          context: context,
                                                          barrierDismissible:
                                                              false,
                                                          builder: (BuildContext
                                                              context) {
                                                            return AlertDialog(
                                                              title: const Text(
                                                                  'Success'),
                                                              content: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                children: [
                                                                  Text(
                                                                      'Invitelink: ${response.mobileDeepLink}'),
                                                                  Text(
                                                                      'Code: ${response.code}'),
                                                                ],
                                                              ),
                                                              actions: [
                                                                TextButton(
                                                                  onPressed:
                                                                      () {
                                                                        if(rolename=='Tutee'){
                                                                    Clipboard.setData(
                                                                        ClipboardData(
                                                                            text:
                                                                                response.mobileDeepLink!));
                                                                    ScaffoldMessenger.of(
                                                                            context)
                                                                        .showSnackBar(
                                                                      const SnackBar(
                                                                        content:
                                                                            Text('Deeplink copied to clipboard!'),
                                                                      ),
                                                                    );
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop(); // Close the dialog
                                                                        Get.off(() => DashboardScreen(rolename: 'Tutee',firstname:firstname ,lastname:lastname ,wowid: wowid,));
                                                                        }else{
Clipboard.setData(
                                                                        ClipboardData(
                                                                            text:
                                                                                response.mobileDeepLink!));
                                                                    ScaffoldMessenger.of(
                                                                            context)
                                                                        .showSnackBar(
                                                                      const SnackBar(
                                                                        content:
                                                                            Text('Deeplink copied to clipboard!'),
                                                                      ),
                                                                    );
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop(); // Close the dialog
                                                                        Get.off(() => DashboardScreen(rolename: 'Parent',firstname:firstname ,lastname:lastname ,wowid: wowid,));
                                                                        }
                                                                  },
                                                                  child:
                                                                      const Text(
                                                                          'Copy'),
                                                                ),
                                                                TextButton(
                                                                  onPressed:
                                                                      () {
                                                                        if(rolename=='Tutee'){
                                                                    Share.share(
                                                                        response
                                                                            .mobileDeepLink!);
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop(); // Close the dialog
                                                                        Get.off(() =>  DashboardScreen(rolename: 'Tutee',firstname:firstname??'' ,lastname:lastname??'' ,wowid: wowid??'',));
                                                                        }else{
                                                                           Share.share(
                                                                        response
                                                                            .mobileDeepLink!);
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop(); // Close the dialog
                                                                        Get.off(() => DashboardScreen(rolename: 'Parent',firstname:firstname ??'',lastname:lastname??'' ,wowid: wowid??'',));
                                                                        }
                                                                  },
                                                                  child: const Text(
                                                                      'Share'),
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        );
                                                      } else {
                                                        SnackBarUtils
                                                            .showErrorSnackBar(
                                                          context,
                                                          response!.message!,
                                                        );
                                                      }
                                                    },
                                                    child: Container(
                                                      height: 48,
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        horizontal: 40,
                                                      ),
                                                      decoration:
                                                          const BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    8)),
                                                        gradient:
                                                            LinearGradient(
                                                          colors: [
                                                            Color(0xFFC13584),
                                                            Color(0xFF833AB4)
                                                          ],
                                                          begin: Alignment
                                                              .topCenter,
                                                          end: Alignment
                                                              .bottomCenter,
                                                        ),
                                                      ),
                                                      child: parentController
                                                              .isLoading.value
                                                          ? const Center(
                                                              child:
                                                                  CircularProgressIndicator(),
                                                            )
                                                          : const Center(
                                                              child: Text(
                                                                'Get invite link ',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                            ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ]));
                            }))))
              ],
            )));
  }
}
