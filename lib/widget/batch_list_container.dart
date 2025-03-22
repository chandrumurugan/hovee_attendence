import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hovee_attendence/controllers/batch_controller.dart';
import 'package:hovee_attendence/modals/getBatchtuteelistModel.dart';
import 'package:hovee_attendence/utils/customDialogBox.dart';
import 'package:hovee_attendence/view/add_batch.dart';
import 'package:hovee_attendence/view/chat_screen/live_chat_screen.dart';
import 'package:hovee_attendence/view/chat_screen/tutee_chat_list.dart';
import 'package:hovee_attendence/view/edit_batch_screen.dart';
import '../modals/getbatchlist_model.dart';

class BatchListConatiner extends StatelessWidget {
  final Data2 batch;
  String? wowid;
  BatchListConatiner({super.key, required this.batch, this.wowid});
  final BatchController batchController = Get.put(BatchController());
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Card(
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              batch.institudeId != null
                  ? SizedBox.shrink()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () {
                            // Add edit functionality
                            Get.to(EditBatchScreen(
                              batch: batch,
                            ));
                          },
                          icon: Icon(
                            Icons.edit,
                            color: Colors.blue,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            // Add delete functionality
                            //Navigator.pop(context);
                            _showConfirmationDialog(context, batch.sId!);
                          },
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
              Stack(
                children: [
                  Image.asset(
                    'assets/Rectangle 18416.png',
                    height: 150,
                    fit: BoxFit.fill,
                  ),
                  // Positioned(
                  //   bottom: -10,
                  //   child: Padding(
                  //   padding:
                  //       const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                  //   child: Card(
                  //     elevation: 10,
                  //     shadowColor: Colors.black,
                  //     surfaceTintColor: Colors.white,
                  //     child: Container(
                  //       width: 120,
                  //       padding: const EdgeInsets.symmetric(
                  //           horizontal: 10, vertical: 10),
                  //       decoration: BoxDecoration(
                  //         color: Colors.white,
                  //         borderRadius: BorderRadius.circular(40),
                  //       ),
                  //       child:   Row(
                  //         children: [
                  //           CircleAvatar(
                  //             radius: 20,
                  //             backgroundImage: NetworkImage( tutee.profileUrl?? ''), // Placeholder profile
                  //           ),
                  //           SizedBox(width: 10),
                  //           Text(tutee.firstName ?? '',style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                  //         ],
                  //       ),
                  //       ),)),
                  // )
                ],
              ),
              const SizedBox(height: 20),
              _buildRow('Batch name', batch.batchName, context),
              const SizedBox(height: 10),
              _buildRow('Tutor', batch.batchTeacher, context),
              const SizedBox(height: 10),
              _buildRow(
                  'Timing',
                  '${batch.batchTimingStart} - ${batch.batchTimingEnd}',
                  context),
              const SizedBox(height: 10),
              _buildRow('Days', batch.batchDays.toString(), context),
              const SizedBox(height: 10),
              _buildRow('Mode', batch.batchMode, context),
              const SizedBox(height: 10),
              _buildRow('Fees', '${batch.fees}', context),
              const SizedBox(height: 10),
              _buildRow(
                  'Batch start date', '${batch.startDate ?? ''}', context),
              const SizedBox(height: 10),
              _buildRow('Batch end date', '${batch.endDate ?? ''}', context),
              Divider(),
              TextButton(
                onPressed: () {
                  // Add chat functionality

                  Get.to(() => TuteeChatList(batchId: batch.sId!,wowid: wowid,));
                },
                child: Text(
                  'Chat',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRow(String title, String? value, BuildContext context) {
    final displayValue =
        title == 'Fees' ? '₹ ${value ?? 'N/A'} /month' : value ?? 'N/A';

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.black.withOpacity(0.4),
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          child: Text(
            displayValue,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }

  void _showConfirmationDialog(BuildContext context, String id) {
    showDialog(
      context: context,
      builder: (context) {
        return CustomDialogBox(
          title1: 'Do you want to delete this batch?',
          title2: '',
          subtitle: 'Do you want to delete this batch?',
          icon: const Icon(
            Icons.help_outline,
            color: Colors.white,
          ),
          color: const Color(0xFF833AB4), // Set the primary color
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
            batchController.deleteBatch(context, id);
            // classController.tabController.animateTo(1);
            // classController.handleTabChange(1);
            Navigator.of(context).pop();
          },
        );
      },
    );
  }
}
