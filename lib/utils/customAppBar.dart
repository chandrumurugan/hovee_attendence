import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hovee_attendence/constants/colors_constants.dart';
import 'package:hovee_attendence/widget/gifController.dart';

class AppBarHeader extends StatelessWidget implements PreferredSizeWidget {
  final bool needGoBack;
  final VoidCallback navigateTo;
   final bool? showDownload;
   final VoidCallback? onDownload;
  const AppBarHeader({
    super.key,
    required this.needGoBack,
    required this.navigateTo, this.showDownload, this.onDownload,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: needGoBack
          ? InkWell(
              onTap: () {
                navigateTo();
              },
              child: const Icon(Icons.arrow_back_ios_new))
          : null,
      elevation: 5,
      shadowColor: Colors.grey.shade100,
      title: LogoGif(),
      // Row(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   children: [
      //     SvgPicture.asset(
      //       'assets/appConstantImg/app_icon.svg',
      //       height: 40,
      //     ),
      //     Image.asset(
      //       'assets/appConstantImg/colorlogoword.png',
      //       height: 30,
      //     ),
      //   ],
      // ),
      centerTitle: true,
      surfaceTintColor: Colors.white,
      backgroundColor: Colors.white,
      actions: [
         if(showDownload != null && showDownload!)
                  IconButton(onPressed: () => onDownload!(), icon: Icon(Icons.download_outlined,color: AppConstants.secondaryColor,))
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
