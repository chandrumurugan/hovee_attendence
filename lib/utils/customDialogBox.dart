

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:google_fonts/google_fonts.dart';

class CustomDialogBox extends StatefulWidget {
  const CustomDialogBox(
      {super.key,
      required this.title1,
      required this.title2,
      required this.subtitle,
      required this.btnName,
      required this.onTap,
      required this.icon,
      required this.color,
       this.color1,
      required this.singleBtn,
      this.btnName2,
      this.onTap2});
  final String title1;
  final String title2;
  final String subtitle;
  final Widget icon;
  final Color color;
  final Color? color1;
  final bool singleBtn;
  final String btnName;
  final Function() onTap;
  final String? btnName2;
  final Function()? onTap2;

  @override
  State<CustomDialogBox> createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 100,
      ),
      child: SizedBox(
         width: MediaQuery.sizeOf(context).width * 1,
        child: Dialog(
           backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.topCenter,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                height: MediaQuery.sizeOf(context).height * 0.28,
                width: MediaQuery.sizeOf(context).width * 0.8,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 25,
                    ),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: " ${widget.title1}",
                            style: GoogleFonts.nunito(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w400),
                          ),
                          TextSpan(
                            text: " ${widget.title2}",
                            style: GoogleFonts.nunito(
                                color: widget.color,
                                fontSize: 24,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Text(
                    //   widget.subtitle,
                    //   textAlign: TextAlign.center,
                    //   style: GoogleFonts.nunito(
                    //       color: Colors.grey.shade600,
                    //       fontSize: 14,
                    //       fontWeight: FontWeight.w400),
                    // ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: !widget.singleBtn
                          ? MainAxisAlignment.spaceEvenly
                          : MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: widget.onTap,
                          child: Container(
                            width: widget.singleBtn
                                ? MediaQuery.sizeOf(context).width * 0.35
                                : MediaQuery.sizeOf(context).width * 0.30,
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                               gradient: LinearGradient(
                                        colors: [
                                          widget.color,
                                          widget.color1 ??  widget.color,
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text(
                                widget.btnName,
                                style: GoogleFonts.nunito(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                        !widget.singleBtn
                            ? InkWell(
                                onTap: widget.onTap2!,
                                child: Container(
                                  width: MediaQuery.sizeOf(context).width * 0.3,
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          widget.color,
                                          widget.color1 ??  widget.color,
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Center(
                                    child: Text(
                                      widget.btnName2!,
                                      style: GoogleFonts.nunito(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 20),
                                    ),
                                  ),
                                ),
                              )
                            : const SizedBox(),
                      ],
                    )
                  ],
                ),
              ),
              Positioned(
                top: -40,
                left: 30,
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                      radius: 30,
                      backgroundColor: widget.color,
                      child: widget.icon),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


}
  class CustomDialogBox1 extends StatefulWidget {
  const CustomDialogBox1(
      {super.key,
      required this.title1,
      required this.title2,
      required this.subtitle,
      required this.btnName,
      required this.onTap,
      required this.icon,
      required this.color,
       this.color1,
      required this.singleBtn,
      this.btnName2,
      this.onTap2});
  final String title1;
  final String title2;
  final String subtitle;
  final Widget icon;
  final Color color;
  final Color? color1;
  final bool singleBtn;
  final String btnName;
  final Function() onTap;
  final String? btnName2;
  final Function()? onTap2;

  @override
  State<CustomDialogBox1> createState() => _CustomDialogBox1State();
}

class _CustomDialogBox1State extends State<CustomDialogBox1> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 100,
      ),
      child: SizedBox(
         width: MediaQuery.sizeOf(context).width * 1,
        child: Dialog(
           backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.topCenter,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                height: MediaQuery.sizeOf(context).height * 0.30,
                width: MediaQuery.sizeOf(context).width * 0.8,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 25,
                    ),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: " ${widget.title1}",
                            style: GoogleFonts.nunito(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w400),
                          ),
                          TextSpan(
                            text: " ${widget.title2}",
                            style: GoogleFonts.nunito(
                                color: widget.color,
                                fontSize: 24,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.subtitle,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.nunito(
                          color: Colors.grey.shade600,
                          fontSize: 15,
                          fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: !widget.singleBtn
                          ? MainAxisAlignment.spaceEvenly
                          : MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: widget.onTap,
                          child: Container(
                            width: widget.singleBtn
                                ? MediaQuery.sizeOf(context).width * 0.35
                                : MediaQuery.sizeOf(context).width * 0.30,
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                               gradient: LinearGradient(
                                        colors: [
                                          widget.color,
                                          widget.color1 ??  widget.color,
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text(
                                widget.btnName,
                                style: GoogleFonts.nunito(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                        !widget.singleBtn
                            ? InkWell(
                                onTap: widget.onTap2!,
                                child: Container(
                                  width: MediaQuery.sizeOf(context).width * 0.3,
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          widget.color,
                                          widget.color1 ??  widget.color,
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Center(
                                    child: Text(
                                      widget.btnName2!,
                                      style: GoogleFonts.nunito(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 20),
                                    ),
                                  ),
                                ),
                              )
                            : const SizedBox(),
                      ],
                    )
                  ],
                ),
              ),
              Positioned(
                top: -40,
                left: 30,
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                      radius: 30,
                      backgroundColor: widget.color,
                      child: widget.icon),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}