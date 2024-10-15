// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:hovee_attendence/utils/customAppBar.dart';

class LoginSignUp extends StatefulWidget {
  const LoginSignUp({super.key});

  @override
  State<LoginSignUp> createState() => _LoginSignUpState();
}

class _LoginSignUpState extends State<LoginSignUp> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
         resizeToAvoidBottomInset: true,
          appBar: AppBarHeader(
            needGoBack: false,
            navigateTo: (){},
          ),
          // body: Stack(
          //   children: [
          //     SingleChildScrollView(
          //       child: Column(
          //           mainAxisAlignment: MainAxisAlignment.start,
          //              children: [
          //           Container(
          //             padding: const EdgeInsets.all(20),
          //             width: MediaQuery.sizeOf(context).width,
          //             height: MediaQuery.sizeOf(context).height * 0.24,
          //             decoration: const BoxDecoration(
          //               image: DecorationImage(
          //                   image: AssetImage('assets/image 194.png'),
          //                   fit: BoxFit.cover),
          //               gradient: LinearGradient(
          //                 colors: [Color(0xFFC13584), Color(0xFF833AB4)],
          //                 begin: Alignment.topCenter,
          //                 end: Alignment.bottomCenter,
          //               ),
          //             ),
          //             child: const Column(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               mainAxisAlignment: MainAxisAlignment.start,
          //               children: [
          //                 SizedBox(
          //                   height: 10,
          //                 ),
          //                 Text(
          //                   'Welcome !',
          //                   style: TextStyle(
          //                       color: Colors.white,
          //                       fontWeight: FontWeight.w400,
          //                       fontSize: 24),
          //                 ),
          //                 SizedBox(
          //                   height: 15,
          //                 ),
          //                 // const Text(
          //                 //   'Lorem Ipsum is simply dummy text\n of the printing and typesetting industry',
          //                 //   style: TextStyle(
          //                 //       color: Colors.white,
          //                 //       fontWeight: FontWeight.w400,
          //                 //       fontSize: 16),
          //                 // ),
          //               ],
          //             ),
          //           ),
          //           SizedBox(
          //             height: MediaQuery.sizeOf(context).height * 0.3,
          //           ),
          //           Align(
          //             alignment: Alignment.bottomCenter,
          //             child: Column(
          //               children: [
          //                 Visibility(
          //                   visible: tabController.index == 0,
          //                   child: Padding(
          //                     padding: const EdgeInsets.all(15.0),
          //                     child: Row(
          //                       mainAxisAlignment:
          //                           MainAxisAlignment.spaceBetween,
          //                       children: [
          //                         Container(
          //                           width: 150,
          //                           color: Colors.grey.shade400,
          //                           height: 2,
          //                         ),
          //                         const Padding(
          //                           padding:
          //                               EdgeInsets.symmetric(horizontal: 10.0),
          //                           child: Text(
          //                             'OR',
          //                             style: TextStyle(
          //                               fontSize: 16,
          //                               color: Colors.grey,
          //                             ),
          //                           ),
          //                         ),
          //                         Container(
          //                           width: 150,
          //                           color: Colors.grey.shade400,
          //                           height: 2,
          //                         ),
          //                       ],
          //                     ),
          //                   ),
          //                 ),
          //                 Visibility(
          //                   visible: tabController.index == 0,
          //                   child: Padding(
          //                     padding: const EdgeInsets.symmetric(
          //                         horizontal: 15.0, vertical: 10),
          //                     child: InkWell(
          //                       onTap: () {
          //                         controller.signInWithGoogle().then((value) {
          //                           if (value.user!.uid.isNotEmpty) {
          //                             if (context.mounted) {
          //                               Navigator.pushReplacement(
          //                                   context,
          //                                   MaterialPageRoute(
          //                                       builder: (context) =>
          //                                           const ChatRoom()));
          //                             }
          //                           }
          //                         });
          //                       },
          //                       child: Image.asset(
          //                         'assets/google_2504739.png',
          //                         height: 40,
          //                       ),
          //                     ),
          //                   ),
          //                 ),
          //                 Visibility(
          //                   visible: tabController.index == 0,
          //                   child: Image.asset(
          //                     'assets/image 203.png',
          //                     height: 150,
          //                   ),
          //                 )
          //               ],
          //             ),
          //           )
          //         ],

          //       ),
          //     )
          //   ],
          // ),

    );
  }
}