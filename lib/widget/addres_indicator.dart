import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hovee_attendence/widget/custom_texts.dart';

class AddressIndicator extends StatelessWidget {
  const AddressIndicator({
    super.key,
    required this.address, required this.name,
  });
  final String address,name;

  @override
  Widget build(BuildContext context) {
    return Padding(
  padding: const EdgeInsets.only(top: 20),
  child: Align(
    alignment: Alignment.topCenter,
    child: Container(
      height: 180,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CircleAvatar(
            radius: 30, // Adjust size as needed
            backgroundColor: Color.fromRGBO(186, 1, 97, 1), // Customize color
            child: Icon(
              Icons.person, // Customize icon if needed
              color: Colors.white,
              size: 40,
            ),
          ), // Add some space between avatar and text
          regularText(
                text: name,
                fontSize: 20,
              ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
               Icon(Icons.location_on,size: 40,color: Colors.red,),
               
              Expanded(
                child: regularText(
                  text: address,
                  fontSize: 12,
                  maxlines: 3,
                  textOverflow:  TextOverflow
                            .ellipsis
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  ),
)
;
  }
}
