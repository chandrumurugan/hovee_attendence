import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hovee_attendence/widget/custom_texts.dart';

class AddressIndicator extends StatelessWidget {
  const AddressIndicator({
    super.key,
    required this.address,
  });
  final String address;

  @override
  Widget build(BuildContext context) {
    return Padding(
  padding: const EdgeInsets.only(top: 50),
  child: Align(
    alignment: Alignment.topCenter,
    child: Padding(
      padding: const EdgeInsets.only(bottom: 70),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        constraints: BoxConstraints(minHeight: 60),
        width: Get.size.width * 0.7,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 2,
              offset: const Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 20, // Adjust size as needed
              backgroundColor: Colors.grey, // Customize color
              child: Icon(
                Icons.person, // Customize icon if needed
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(width: 10), // Add some space between avatar and text
            Expanded(
              child: regularText(
                text: address,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    ),
  ),
)
;
  }
}
