import 'package:flutter/material.dart';
import 'package:hovee_attendence/constants/colors_constants.dart';


class WidgetToIcon extends StatelessWidget {
  const WidgetToIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
        color:AppConstants.secondaryColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Center(
        child: Container(
          height: 25,
          width: 25,
          decoration: BoxDecoration(
            color: AppConstants.primaryColor,
            borderRadius: BorderRadius.circular(12.5),
          ),
        ),
      ),
    );
  }
}
