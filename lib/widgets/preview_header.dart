import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

class PreviewHeader extends StatelessWidget {
  const PreviewHeader({
    super.key,
    required this.bgImage,
    required this.title,
    required this.subtitle,
    required this.ratingCount,
  });
  final String bgImage;
  final String title;
  final String subtitle;
  final String ratingCount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 10,
        shadowColor: Colors.grey.shade100,
        surfaceTintColor: Colors.white,
        child: Container(
          height: MediaQuery.sizeOf(context).height * 0.18,
          padding: const EdgeInsets.all(10),
          width: MediaQuery.sizeOf(context).width,
          // height: MediaQuery.sizeOf(context).height * 0.3,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            image:
                DecorationImage(image: AssetImage(bgImage), fit: BoxFit.cover),
            gradient: const LinearGradient(
              colors: [Color(0xFFC13584), Color(0xFF833AB4)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.nunito(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 24),
              ),
              Row(
                children: [
                  Text(
                    subtitle,
                    style: GoogleFonts.nunito(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 16),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  
                ],
              ),
              const SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}


class PreviewHeaderHostel extends StatelessWidget {
  const PreviewHeaderHostel({
    super.key,
    required this.bgImage,
    required this.title,
    required this.subtitle,
    required this.ratingCount,
  });
  final String bgImage;
  final String title;
  final String subtitle;
  final String ratingCount;

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      child: Stack(
        children: [
          /// Background image with error handling
          SizedBox(
            width: MediaQuery.sizeOf(context).width,
            height: 180,
            child: Image.network(
              bgImage ?? '',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  'assets/v2.jpg', // Fallback image
                  fit: BoxFit.cover,
                );
              },
            ),
          ),

          /// Content Overlay
          Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.sizeOf(context).width * 0.05,
                  vertical: MediaQuery.sizeOf(context).height * 0.035,
                ),
                width: MediaQuery.sizeOf(context).width,
                height: 180,
                color: Colors.black.withOpacity(0.3), // Add overlay effect
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // IconButton(
                    //   onPressed: () {
                    //     Get.back();
                    //   },
                    //   icon: const Icon(
                    //     Icons.arrow_back,
                    //     color: Colors.white,
                    //   ),
                    // ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: GoogleFonts.nunito(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 24,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              subtitle,
                              style: GoogleFonts.nunito(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(width: 15),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          ratingCount,
                          style: GoogleFonts.nunito(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Container(
              //   color: Colors.white,
              //   height: 80,
              // ),
            ],
          ),
        ],
      ),
    );
    // Padding(
    //   padding: const EdgeInsets.all(8.0),
    //   child: Card(
    //     elevation: 10,
    //     shadowColor: Colors.grey.shade100,
    //     surfaceTintColor: Colors.white,
    //     child: Container(
    //       height: MediaQuery.sizeOf(context).height * 0.18,
    //       padding: const EdgeInsets.all(10),
    //       width: MediaQuery.sizeOf(context).width,
    //       // height: MediaQuery.sizeOf(context).height * 0.3,
    //       decoration: BoxDecoration(
    //         borderRadius: const BorderRadius.all(Radius.circular(8)),
    //         image:
    //             DecorationImage(image: AssetImage(bgImage), fit: BoxFit.cover),
    //         gradient: const LinearGradient(
    //           colors: [Color(0xFFC13584), Color(0xFF833AB4)],
    //           begin: Alignment.topCenter,
    //           end: Alignment.bottomCenter,
    //         ),
    //       ),
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.end,
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           Text(
    //             title,
    //             style: GoogleFonts.nunito(
    //                 color: Colors.white,
    //                 fontWeight: FontWeight.w400,
    //                 fontSize: 24),
    //           ),
    //           Row(
    //             children: [
    //               Text(
    //                 subtitle,
    //                 style: GoogleFonts.nunito(
    //                     color: Colors.white,
    //                     fontWeight: FontWeight.w400,
    //                     fontSize: 16),
    //               ),
    //               const SizedBox(
    //                 width: 15,
    //               ),
                  
    //             ],
    //           ),
    //           const SizedBox(
    //             height: 10,
    //           )
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  
  }
}
