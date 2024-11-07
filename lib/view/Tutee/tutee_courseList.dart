import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovee_attendence/constants/colors_constants.dart';
import 'package:hovee_attendence/controllers/addEnquery_controller.dart';
import 'package:hovee_attendence/controllers/courseDetails_controller.dart';
import 'package:hovee_attendence/modals/singleCoursecategorylist_modal.dart';
import 'package:hovee_attendence/services/webServices.dart';
import 'package:hovee_attendence/utils/customAppBar.dart';
import 'package:hovee_attendence/view/Tutee/tutee_courseDetails.dart';
import 'package:hovee_attendence/widget/course_list_container.dart';

class GetTopicsCourses extends StatefulWidget {
  const GetTopicsCourses({super.key});

  @override
  State<GetTopicsCourses> createState() => _GetTopicsCoursesState();
}

class _GetTopicsCoursesState extends State<GetTopicsCourses> {
  bool isLoadingcategory = false;
  List<String> categories = [];
  int selectedIndex = 0;

  List<Map<String, String>> filteredList = [];
  bool isLoadingcategoryList = false;

   final CourseDetailController controller = Get.put(CourseDetailController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchCourseCategory();
    filteredfetchList('All');
  }

  void fetchCourseCategory() async {
    // isLoadingcategory(true);
    setState(() {
      isLoadingcategory = true;
    });
    var response = await WebService.fetchCoursecategory();

    if (response.isNotEmpty) {
      setState(() {
        categories = response;
        isLoadingcategory = false;
      });
    } else {
      setState(() {
        isLoadingcategory = false;
      });
    }
  }

  void filteredfetchList(String type) async {
    setState(() {
      isLoadingcategoryList = true;
    });
    var response = await WebService.singleCourseListfetch(type);
    if (response != null && response!.statusCode == 200) {
      setState(() {
        filteredList = response.dataList;
        isLoadingcategoryList = false;
      });
    } else {
      setState(() {
        filteredList = [];
        isLoadingcategoryList = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // final AddEnqueryController controller = Get.put(AddEnqueryController());
    return Scaffold(
      appBar: AppBarHeader(
          needGoBack: true,
          navigateTo: () {
            Get.back();
          }),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Text(
              "Course based on categories",
              style: GoogleFonts.nunito(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 16),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 42,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  bool isSelected = selectedIndex == index;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });

                      filteredfetchList(categories[index]);
                      // controller.updateSelectedIndex(index);
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppConstants.primaryColor
                            : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black
                                .withOpacity(0.1), // Shadow color with opacity
                            offset: Offset(
                                0, 4), // X and Y shadow offset (0px, 4px)
                            blurRadius: 24, // Blur radius
                            spreadRadius: 0, // Spread radius
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          categories[index],
                          style: GoogleFonts.nunito(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: isSelected
                                ? Colors.white
                                : Colors.black.withOpacity(0.5),
                          ),
                          // style: TextStyle(
                          //   color: isSelected ? Colors.white : Colors.black,
                          //   fontWeight: FontWeight.bold,
                          // ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 10,),
            Expanded(
                child: isLoadingcategoryList
                    ? const Center(child: CircularProgressIndicator())
                    : filteredList.isEmpty
                        ? const Center(child: Text("No courses available"))
                        : ListView.builder(
                            // physics: NeverScrollableScrollPhysics(),
                            // shrinkWrap: true,
                            itemCount: filteredList.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: (){
                                 controller.getClassTuteeById(context,filteredList[index]["className"]!,filteredList[index]["subject"]!,filteredList[index]["TutorId"]!);
                                },
                                child: CourseListContainer(
                                    image: "",
                                    subject: filteredList[index]["subject"]!, //
                                    subjectCode:
                                        "₹ ${filteredList[index]["fees"]!}",
                                    std: filteredList[index]["className"]!,
                                    medium: filteredList[index]["batch_mode"]!,
                                    group: filteredList[index]["course_code"]!,
                                    groupcode:
                                        "${filteredList[index]["batch_timing_start"]!}-${filteredList[index]["batch_timing_end"]!}",
                                    arrowIcon: true),
                              );
                            }))
          ],
        ),
      ),
    );
  }

 
}
