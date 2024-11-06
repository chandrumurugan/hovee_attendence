import 'package:flutter/material.dart';
import '../modals/getbatchlist_model.dart';


class BatchListConatiner extends StatelessWidget {
  final Data2 batch;

  const BatchListConatiner({super.key, required this.batch});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0,),
      child: Card(
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Image.asset(
                'assets/Rectangle 18416.png',
                height: 150,
                fit: BoxFit.fill,
              ),
              SizedBox(height: 20),
              _buildRow('Batch Name', batch.batchName),
               const SizedBox(
                    height: 10,
                  ),
              _buildRow('Teacher', batch.batchTeacher),
               const SizedBox(
                    height: 10,
                  ),
              _buildRow('Timing', '${batch.batchTimingStart} - ${batch.batchTimingEnd}'),
               const SizedBox(
                    height: 10,
                  ),
              _buildRow('Days', batch.batchDays),
               const SizedBox(
                    height: 10,
                  ),
              _buildRow('Mode', batch.batchMode),
               const SizedBox(
                    height: 10,
                  ),
              _buildRow('Fees', batch.fees),
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,style:  TextStyle(
                            color: Colors.black.withOpacity(0.4),
                            fontWeight: FontWeight.w500,
                            fontSize: 14),),
        Text(value ?? 'N/A', style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 14),
                      ),
                      
      ],
    );
  }
}
