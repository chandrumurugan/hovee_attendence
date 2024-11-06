import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hovee_attendence/components/tutorHomeComponents.dart';
import 'package:hovee_attendence/constants/colors_constants.dart';
import 'package:hovee_attendence/controllers/tuteeHome_controllers.dart';
import 'package:hovee_attendence/view/Tutee/tutee_courseList.dart';
import 'package:hovee_attendence/view/attendanceCourseList_screen.dart';
import 'package:hovee_attendence/view/home_screen/tutor_home_screen.dart';
import 'package:hovee_attendence/view/sidemenu.dart';
import 'package:hovee_attendence/view/userProfile.dart';
import 'package:hovee_attendence/widget/gifController.dart';
import 'package:hovee_attendence/widget/subjectContainer.dart';
import 'package:logger/logger.dart';

class TuteeHome extends StatelessWidget {
  const TuteeHome({super.key});

  @override
  Widget build(BuildContext context) {
    final TuteeHomeController controller = Get.put(TuteeHomeController());

    return Scaffold(
      key: controller.tuteeScaffoldKey,
      drawer: SideMenu(
        isGuest: false,
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 5,
        shadowColor: Colors.grey.shade100,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () {
                    controller.tuteeScaffoldKey.currentState!.openDrawer();
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => const SideMenu()));
                  },
                  child: Image.asset(
                    'assets/appbar/Group 2322.png',
                    color: AppConstants.primaryColor,
                  ),
                ),
                const SizedBox(
                  width: 30,
                ),
                LogoGif()
                // SvgPicture.asset(
                //   'assets/appbar/hovee_attendance_app_icon_.svg',
                //   height: 40,
                // ),
                // Image.asset(
                //   'assets/appConstantImg/colorlogoword.png',
                //   height: 30,
                // ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey.shade200),
              child: Row(
                // mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset(
                    'assets/appbar/bell 5.png',
                    color: Colors.black.withOpacity(0.4),
                    height: 30,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => const ChatScreen()));
                    },
                    child: Icon(
                      Icons.message,
                      color: Colors.black.withOpacity(0.4),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        centerTitle: false,
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                
                  InkWell(
                    onTap: (){
                       Get.to(()=>UserProfile());
                    },
                    child: const HomePageHeader(
                      title: 'Attendance Monitoring',
                      userType: "Tutee",
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.18,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'My Classes',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                       InkWell(
                        onTap: (){
                          Get.to(() =>
                                AttendanceCourseListScreen()); 
                        },
                         child: const Text(
                          'See All',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                                               ),
                       ),
                    ],
                  ),
                   SubjectContainer(),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'My Listings',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 1.0,
                            crossAxisCount: 3,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10 // Number of columns
                            ),
                    itemBuilder: (context, int index) {
                      final item = controller.tuteeMonitorList[index];
                      return InkWell(
                        onTap: () {
                          if(index == 2){
                            var box = GetStorage();
                            Logger().i("${box.read('Token')}");
                            Get.to(()=>const GetTopicsCourses());
                          }
                         
                        },
                        child: Card(
                          elevation: 10,
                          shadowColor: Colors.grey,
                          surfaceTintColor: Colors.white,
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: const Color.fromRGBO(246, 244, 254, 1)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: controller.tuteeMonitorList[index]
                                          ['color']),
                                  child: Image.asset(
                                    controller.tuteeMonitorList[index]['image'],
                                    color: Colors.white,
                                    height: 30,
                                  ),
                                ),
                                Text(
                                    controller.tuteeMonitorList[index]['title'])
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: controller.tuteeMonitorList.length,
                  ),
                  
                ],
              ),
            ),
             Positioned(
                left: 20,
                right: 20,
                top: MediaQuery.sizeOf(context).height * 0.18,
                child: const LineChartSample(userType: 'Tutee',)),
          ],
        ),
      ),
    );
  }
}
