import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppBarHeader extends StatelessWidget implements PreferredSizeWidget {
  final bool needGoBack;
  final VoidCallback navigateTo;
  const AppBarHeader({
    super.key,
    required this.needGoBack,
    required this.navigateTo,
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
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/appConstantImg/app_icon.svg',
            height: 40,
          ),
          Image.asset(
            'assets/appConstantImg/colorlogoword.png',
            height: 30,
          ),
        ],
      ),
      centerTitle: true,
      surfaceTintColor: Colors.white,
      backgroundColor: Colors.white,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
