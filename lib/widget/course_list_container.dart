
import 'package:flutter/material.dart';
import 'package:hovee_attendence/constants/colors_constants.dart';

class CourseListContainer extends StatelessWidget {
  final String image;
  final String subject;
  final String subjectCode;
  final String std;
  final String medium;
  final String group;
  final bool arrowIcon;
  final String groupcode;
  const CourseListContainer(
      {super.key,
      required this.image,
      required this.subject,
      required this.subjectCode,
      required this.std,
      required this.medium,
      required this.group,
      required this.groupcode,
      required this.arrowIcon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
      child: Card(
        elevation: 10,
        shadowColor: Colors.black,
        surfaceTintColor: Colors.white,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
           
             // Image.asset(image),
           
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          subject,
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 15),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          height: 15,
                          width: 1.5,
                          color: Colors.black.withOpacity(0.5),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          subjectCode,
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 14),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text(
                          std,
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 15),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          height: 1,
                          width: 10,
                          color: Colors.black.withOpacity(0.5),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          medium,
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 14),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                         group!=null?
                        Text(
                           group,  
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 15),
                        ):Container(),
                        Text(
                          groupcode,
                          style: const TextStyle(
                              color: Color.fromRGBO(46, 91, 181, 1),
                              fontWeight: FontWeight.w400,
                              fontSize: 14),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        arrowIcon
                            ? IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 20,
                                ))
                            : InkWell(
                                onTap: () {
                                 
                                },
                                child: const CircleAvatar(
                                  radius: 25,
                                  backgroundColor: AppConstants.primaryColor,
                                  child: Text(
                                    'Punch',
                                    style: TextStyle(
                                        fontSize: 11, color: Colors.white),
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
