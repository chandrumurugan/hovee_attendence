

import 'package:flutter/material.dart';
import 'package:hovee_attendence/utils/customAppBar.dart';

class AccoiuntSetup extends StatelessWidget {
  final String roleId;
  final String roleTypeId;
  const AccoiuntSetup({super.key, required this.roleId, required this.roleTypeId,});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        resizeToAvoidBottomInset: true,
      appBar: AppBarHeader(
        needGoBack: true,
        navigateTo: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}