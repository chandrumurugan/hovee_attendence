import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hovee_attendence/controllers/batch_controller.dart';
import 'package:hovee_attendence/view/add_batch.dart';
import 'package:hovee_attendence/view/edit_batch_screen.dart';
import '../modals/getbatchlist_model.dart';

class BatchListConatiner extends StatelessWidget {
  final Data2 batch;

   BatchListConatiner({super.key, required this.batch});
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {
                          // Add edit functionality
                          Get.to(EditBatchScreen(batch: batch,));
                        },
                        icon: Icon(
                          Icons.edit,
                          color: Colors.blue,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          // Add delete functionality
                         batchController.deleteBatch(context,batch.sId!);
                        },
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
              Image.asset(
                'assets/Rectangle 18416.png',
                height: 150,
                fit: BoxFit.fill,
              ),
              const SizedBox(height: 20),
              _buildRow('Batch Name', batch.batchName),
              const SizedBox(height: 10),
              _buildRow('Tutor', batch.batchTeacher),
              const SizedBox(height: 10),
              _buildRow('Timing', '${batch.batchTimingStart} - ${batch.batchTimingEnd}'),
              const SizedBox(height: 10),
              _buildRow('Days', batch.batchDays.toString()),
              const SizedBox(height: 10),
              _buildRow('Mode', batch.batchMode),
              const SizedBox(height: 10),
              _buildRow('Fees', '${batch.fees}'),
              Divider(),
              TextButton(
                onPressed: () {
                  // Add chat functionality
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

  Widget _buildRow(String title, String? value) {
    final displayValue = title == 'Fees' ? '₹ ${value ?? 'N/A'} /month' : value ?? 'N/A';

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
        Text(
          displayValue,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w400,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
