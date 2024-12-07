import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovee_attendence/controllers/leave_controller.dart';
import 'package:hovee_attendence/controllers/msp_controller.dart';
import 'package:hovee_attendence/modals/getLeaveListModel.dart';
import 'package:hovee_attendence/utils/customDialogBox.dart';
import 'package:hovee_attendence/view/editLeave_screen.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

class LeaveListContainer extends StatelessWidget {
  final String type;
  LeaveListContainer({super.key, required this.leave, required this.type});
  final LeaveData leave;
  @override
  Widget build(BuildContext context) {
    final TuteeLeaveController leaveController =
        Get.put(TuteeLeaveController());
    DateTime dateTime = DateFormat("dd-MM-yyyy").parse(leave.fromDate!);
    Logger().i("123456===>$dateTime");
    String formattedDate = DateFormat("ddMMMyy").format(dateTime);
    Logger().i("0987654===>$formattedDate");
    DateTime dateTime2 = DateFormat("dd-MM-yyyy").parse(leave.endDate!);
    Logger().i("123456===>$dateTime");
    String formattedDate2 = DateFormat("ddMMMyy").format(dateTime2);
    Logger().i("0987654===>$formattedDate");
    
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child:
         Card(
          color: Colors.white,
          surfaceTintColor: Colors.white,
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                          Image.asset(
                      'assets/Ellipse 261.png',
                      height: 70,
                    ),
                         SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('${leave.studentDetails!.firstName!} ${leave.studentDetails!.lastName!}',
                                  style: GoogleFonts.nunito(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      color: Colors.black)),
                              SizedBox(height: 4),
                              leave.enrollmentDetails!=null?
                              Text('Roll no: ${leave.enrollmentDetails!.rollNumber??''}',
                                  style: GoogleFonts.nunito(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      color: Colors.black)):SizedBox.shrink(),
                              SizedBox(height: 4),
                              Text('Date: $formattedDate - $formattedDate2',
                                  style: GoogleFonts.nunito(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      color: Colors.black)),
                                      SizedBox(height: 4),
                                      leave.batchDetails!=null?
                                       Text(
                                              'Batch name: ${leave.batchDetails!.batchName}',
                                              style: GoogleFonts.nunito(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14,
                                                  color: Colors.black),
                                            ):SizedBox.shrink(),
                                            SizedBox(height: 4),
                                      _buildRow('Status', '${leave.status}'),
                            ],
                          ),
                        ),
                         SizedBox(width: 8),
                        Container(
                          width: 60,
                          color: Colors.white,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                            
                              IconButton(
                                iconSize: 25,
                            onPressed: () {}, // No action needed here
                            icon: PopupMenuButton<String>(
                              icon: Icon(Icons.more_vert),
                              onSelected: (String value) {
                                // Optional if further actions are needed after selection
                              },
                              itemBuilder: (BuildContext context) {
                                return [
                                  if (type == 'Tutee' && (leave.status != 'Accepted' && leave.status != 'Rejected'))
                                  PopupMenuItem(
                                    value: 'Edit',
                                    child: ListTile(
                                      leading: Icon(Icons.edit),
                                      title: Text('Edit'),
                                      onTap: () {
                                        Navigator.pop(context); // Close the popup first
                                        Get.to(EditleaveScreen(
                                          batch: leave,
                                        ));
                                      },
                                    ),
                                  ),
                                  PopupMenuItem(
                                    value: 'Delete',
                                    child: ListTile(
                                      leading: Icon(Icons.delete),
                                      title: Text('Delete'),
                                      onTap: () {
                                        Navigator.pop(context);
                                         _showConfirmationDialogDelete(context, leave.sId!);
                                        //leaveController.deleteLeave(context, leave.sId!);
                                        //  Navigator.pop(context); // Close the popup first
                                        // leaveController.onInit();
                                      },
                                    ),
                                  ),
                                ];
                              },
                            ),
                          ),
                          
                              Container(
                                padding: EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                    color: Colors.amber,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Text(leave.leaveType!,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.nunito(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 12,
                                        color: Colors.red)),
                              ),
                             // SizedBox(height: 6,),
                                
                            ],
                          ),
                        ),
                      ],
                    ),
                    // SizedBox(
                    //   height: 4,
                    // ),
                    Divider(
                      //height: 100,
                      color: Colors.grey,
                      thickness: 1,
                      indent: 0,
                      endIndent: 0,
                    ),
                    Text('Reason',
                        style: GoogleFonts.nunito(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Colors.black)),
                    //SizedBox(height: 8),
                    Text(leave.reason!,
                        style: GoogleFonts.nunito(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Colors.black)),
                  ],
                ),
                leave.status != 'Accepted' && leave.status != 'Rejected'?
                Divider(
                  //height: 100,
                  color: Colors.grey,
                  thickness: 1,
                  indent: 0,
                  endIndent: 0,
                ):SizedBox(height: 8,),
                 buildActionButtons(type,leave.status!,leave.sId!,context)
                //SizedBox(height: 16),
    //             type == 'Tutor' && (leave.status != 'Accepted' && leave.status != 'Rejected')
    // ? Row(
    //     mainAxisAlignment: MainAxisAlignment.end,
    //     children: [
    //       Expanded(
    //         child: InkWell(
    //           onTap: () {
    //             _showConfirmationDialog(context, leave.sId!);
    //           },
    //           child: Container(
    //             width: double.infinity,
    //             padding: const EdgeInsets.symmetric(vertical: 10),
    //             decoration: BoxDecoration(
    //               borderRadius: BorderRadius.circular(8),
    //               gradient: LinearGradient(
    //                 colors: const [
    //                   Color(0xFFBA0161),
    //                   Color(0xFF510270)
    //                 ],
    //                 begin: Alignment.topCenter,
    //                 end: Alignment.bottomCenter,
    //               ),
    //             ),
    //             child: Text(
    //               "Accept",
    //               textAlign: TextAlign.center,
    //               style: GoogleFonts.nunito(
    //                   fontWeight: FontWeight.w500,
    //                   fontSize: 20,
    //                   color: Colors.white),
    //             ),
    //           ),
    //         ),
    //       ),
    //       const SizedBox(width: 10),
    //       Expanded(
    //         child: InkWell(
    //           onTap: () {
    //             _showConfirmationDialog1(context, leave.sId!);
    //           },
    //           child: Container(
    //             width: double.infinity,
    //             padding: const EdgeInsets.symmetric(vertical: 10),
    //             decoration: BoxDecoration(
    //               borderRadius: BorderRadius.circular(8),
    //               gradient: LinearGradient(
    //                 colors: const [
    //                   Color(0xFFBA0161),
    //                   Color(0xFF510270)
    //                 ],
    //                 begin: Alignment.topCenter,
    //                 end: Alignment.bottomCenter,
    //               ),
    //             ),
    //             child: Text(
    //               "Reject",
    //               textAlign: TextAlign.center,
    //               style: GoogleFonts.nunito(
    //                   fontWeight: FontWeight.w500,
    //                   fontSize: 20,
    //                   color: Colors.white),
    //             ),
    //           ),
    //         ),
    //       ),
    //     ],
    //   )
    

    //                 : TextButton(
    //                     onPressed: () {
    //                       // Add chat functionality
    //                     },
    //                     child: Text(
    //                       'Resend',
    //                       style: TextStyle(
    //                         color: Colors.blue,
    //                         fontWeight: FontWeight.bold,
    //                         fontSize: 16,
    //                       ),
    //                     ),
    //                   ),
              ],
            ),
          ),
        )
        // Card(
        //   elevation: 10,
        //   child: Padding(
        //     padding: const EdgeInsets.all(12.0),
        //     child: Column(
        //       crossAxisAlignment: CrossAxisAlignment.center,
        //       children: [
        //           Row(
        //             mainAxisAlignment: MainAxisAlignment.end,
        //               children: [
        //                 IconButton(
        //                   onPressed: () {
        //                     // Add edit functionality
        //                     Get.to(EditleaveScreen(batch: leave,));
        //                   },
        //                   icon: Icon(
        //                     Icons.edit,
        //                     color: Colors.blue,
        //                   ),
        //                 ),
        //                 IconButton(
        //                   onPressed: () {
        //                     // Add delete functionality
        //                    leaveController.deleteLeave(context,leave.sId!);
        //                   },
        //                   icon: Icon(
        //                     Icons.delete,
        //                     color: Colors.red,
        //                   ),
        //                 ),
        //               ],
        //             ),
        //         // Image.asset(
        //         //   'assets/Rectangle 18416.png',
        //         //   height: 150,
        //         //   fit: BoxFit.fill,
        //         // ),
        //         const SizedBox(height: 20),
        //         _buildRow('Batch Name', leave.courseName),
        //         const SizedBox(height: 10),
        //         _buildRow('Roll no.', leave.sId),
        //         const SizedBox(height: 10),
        //         _buildRow('Leave type', '${leave.leaveType}'),
        //         const SizedBox(height: 10),
        //         _buildRow('From date', leave.fromDate.toString()),
        //         const SizedBox(height: 10),
        //         _buildRow('To date', leave.endDate),
        //         const SizedBox(height: 10),
        //         _buildRow('Reason', '${leave.reason}'),
        //          _buildRow('Status', '${leave.status}'),
        //         Divider(),
        // TextButton(
        //   onPressed: () {
        //     // Add chat functionality
        //   },
        //   child: Text(
        //     'Resend',
        //     style: TextStyle(
        //       color: Colors.blue,
        //       fontWeight: FontWeight.bold,
        //       fontSize: 16,
        //     ),
        //   ),
        // )
        //       ],
        //     ),
        //   ),
        // ),

        );
  }

  Widget buildActionButtons(String type, String status, String sId,BuildContext context) {
  if (type == 'Tutor') {
    if (status != 'Accepted' && status != 'Rejected') {
      // Condition 1: Tutor with pending status - Show Accept and Reject buttons
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                _showConfirmationDialog(context, sId);
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  gradient: const LinearGradient(
                    colors: [Color(0xFFBA0161), Color(0xFF510270)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Text(
                  "Accept",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.nunito(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: InkWell(
              onTap: () {
                _showConfirmationDialog1(context, sId);
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  gradient: const LinearGradient(
                    colors: [Color(0xFFBA0161), Color(0xFF510270)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Text(
                  "Reject",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.nunito(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    } else {
      // Condition 2: Tutor with Accepted/Rejected status - Show nothing
      return const SizedBox.shrink();
    }
  } else if (type == 'Tutee' && status == 'Pending') {
    // Condition 3: Tutee with Pending status - Show Resend button
    return TextButton(
      onPressed: () {
        // Add chat functionality or resend logic here
      },
      child: const Text(
        'Resend',
        style: TextStyle(
          color: Colors.blue,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  } else {
    // Default case: Show nothing
    return const SizedBox.shrink();
  }
}

  Widget _buildRow(String title, String? value) {
    final displayValue =
        title == 'Fees' ? '₹ ${value ?? 'N/A'} /month' : value ?? 'N/A';

    // Determine the text color for the 'Status' row.
    Color textColor = Colors.black;
    if (title == 'Status') {
      switch (value?.toLowerCase()) {
        case 'Accepted':
          textColor = Colors.green;
          break;
        case 'pending':
          textColor = Color(0XFF74788D);
          break;
        case 'rejected':
          textColor = Colors.red;
          break;
        default:
          textColor = Colors.black; // Default color if status is unknown
      }
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.nunito(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Colors.black)
        ),
        Text(
          displayValue,
          style: TextStyle(
            color: title == 'Status' ? textColor : Colors.black,
            fontWeight: FontWeight.w900,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  void _showConfirmationDialog(
      BuildContext context, String id) {
    showDialog(
      context: context,
      builder: (context) {
            final TuteeLeaveController leaveController =
        Get.put(TuteeLeaveController());
        return CustomDialogBox(
          title1: 'Would you like to accept this leave?',
          title2: '',
          subtitle: 'Do you want to accept this leave?',
          icon: const Icon(Icons.help_outline, color: Colors.white),
          color: const Color(0xFF833AB4), // Set the primary color
          color1: const Color(0xFF833AB4), // Optional gradient color
          singleBtn: false, // Show both 'Yes' and 'No' buttons
          btnName: 'No',
          onTap: () {
            // Call the updateClass method when 'Yes' is clicked
            Navigator.of(context).pop();
          },
          btnName2: 'Yes',
          onTap2: () {
            // Close the dialog when 'No' is clicked
            leaveController.updateLeave(
              context,
                id, 'Accepted');
                // classController.tabController.animateTo(1);
                // classController.handleTabChange(1);
            Navigator.of(context).pop(); // Close the dialog after update
          },
        );
      },
    );
  }

  void _showConfirmationDialog1(
      BuildContext context,  String id) {
    showDialog(
      context: context,
      builder: (context) {
            final TuteeLeaveController leaveController =
        Get.put(TuteeLeaveController());
        return CustomDialogBox(
          title1: 'Would you like to reject this leave?',
          title2: '',
          subtitle: 'Do you want to reject this leave?',
          icon: const Icon(Icons.help_outline, color: Colors.white),
          color: const Color(0xFF833AB4), // Set the primary color
          color1: const Color(0xFF833AB4), // Optional gradient color
          singleBtn: false, // Show both 'Yes' and 'No' buttons
          btnName: 'No',
          onTap: () {
            // Call the updateClass method when 'Yes' is clicked
            Navigator.of(context).pop();
          },
          btnName2: 'Yes',
          onTap2: () {
            // Close the dialog when 'No' is clicked
            leaveController.updateLeave(
              context,
                id, 'Rejected');
            Navigator.of(context).pop(); // Close the dialog after update
          },
        );
      },
    );
  }

  void _showConfirmationDialogDelete(BuildContext context, String id) {
    showDialog(
      context: context,
      builder: (context) {
         final TuteeLeaveController leaveController =
        Get.put(TuteeLeaveController());
        return CustomDialogBox(
          title1: 'Do you want to make delete this leave?',
          title2: '',
          subtitle: 'Do you want to delete this leave?',
          icon: const Icon(
            Icons.help_outline,
            color: Colors.white,
          ),
          color: Color(0xFF833AB4), // Set the primary color
          color1: const Color(0xFF833AB4), // Optional gradient color
          singleBtn: false, // Show both 'Yes' and 'No' buttons
          btnName: 'No',
          onTap: () {
            // Call the updateClass method when 'Yes' is clicked
            // Close the dialog after update
            Navigator.of(context).pop();
          },
          btnName2: 'Yes',
          onTap2: () {
            // Close the dialog when 'No' is clicked
            leaveController.deleteLeave(context, id);
            // classController.tabController.animateTo(1);
            // classController.handleTabChange(1);
            Navigator.of(context).pop();
          },
        );
      },
    );
  }
}
