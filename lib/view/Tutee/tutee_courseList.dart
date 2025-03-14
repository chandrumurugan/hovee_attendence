import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovee_attendence/constants/colors_constants.dart';
import 'package:hovee_attendence/controllers/addEnquery_controller.dart';
import 'package:hovee_attendence/controllers/courseDetails_controller.dart';
import 'package:hovee_attendence/controllers/course_controller.dart';
import 'package:hovee_attendence/modals/singleCoursecategorylist_modal.dart';
import 'package:hovee_attendence/services/webServices.dart';
import 'package:hovee_attendence/utils/customAppBar.dart';
import 'package:hovee_attendence/utils/search_filter_tabber.dart';
import 'package:hovee_attendence/view/Tutee/tutee_courseDetails.dart';
import 'package:hovee_attendence/view/dashboard_screen.dart';
import 'package:hovee_attendence/widget/cateory_widget.dart';
import 'package:hovee_attendence/widget/course_list_container.dart';

class GetTopicsCourses extends StatefulWidget {
  final String type;
   final String? firstname,lastname,wowid;
  const GetTopicsCourses({super.key, required this.type, this.firstname, this.lastname, this.wowid});

  @override
  State<GetTopicsCourses> createState() => _GetTopicsCoursesState();
}

class _GetTopicsCoursesState extends State<GetTopicsCourses> {
  bool isLoadingcategory = false;
  List<String> categories = [];
  int selectedIndex = 0;

  List<Data>? filteredList = [];
  bool isLoadingcategoryList = false;

  final CourseDetailController controller = Get.put(CourseDetailController());
  final CourseController courseController = Get.put(CourseController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchCourseCategory();
    filteredfetchList('All', '');
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

  void filteredfetchList(String type, searchTerm) async {
    setState(() {
      isLoadingcategoryList = true;
    });

    // Fetch the data from the API with the search term
    var response = await WebService.singleCourseListfetch(type, searchTerm);
    if (response != null && response.statusCode == 200) {
      setState(() {
        filteredList = response.data; // Update the filtered list
        isLoadingcategoryList = false;
      });
    } else {
      setState(() {
        filteredList = []; // Clear the list if no data found
        isLoadingcategoryList = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // final AddEnqueryController controller = Get.put(AddEnqueryController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarHeader(
          needGoBack: true,
          navigateTo: () {
            Get.offAll(DashboardScreen(
              rolename: widget.type,
              firstname:widget. firstname,lastname:widget. lastname,wowid: widget.wowid,
            ));
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
            CategoryList(
              categories: categories,
              selectedIndex: selectedIndex,
              onCategorySelected: (index) {
                setState(() {
                  selectedIndex = index;
                });
                filteredfetchList(categories[index], '');
              },
              primaryColor: AppConstants.primaryColor, // Example primary color
            ),

            //SizedBox(height: 10,),
            SearchfiltertabBar(
              title: 'Course list',
              onSearchChanged: (searchTerm) {
                filteredfetchList('', searchTerm);
              },
              filterOnTap: () {
                // Implement filter logic here if needed
              },
            ),
            Expanded(
                child: isLoadingcategoryList
                    ? const Center(child: CircularProgressIndicator())
                    : filteredList!.isEmpty
                        ? const Center(child: Text("No courses available"))
                        : ListView.builder(
                            // physics: NeverScrollableScrollPhysics(),
                            // shrinkWrap: true,
                            itemCount: filteredList!.length,
                            itemBuilder: (context, index) {
                              final course = filteredList![index];
                              return Animate(
                                effects: [
                                  SlideEffect(
                                    begin: Offset(-1, 0), // Start from the left
                                    end: Offset(
                                        0, 0), // End at the original position
                                    curve: Curves.easeInOut,
                                    duration: 500
                                        .ms, // Consistent timing for each item
                                    delay: 100.ms *
                                        index, // Add delay between items
                                  ),
                                  FadeEffect(
                                    begin: 0, // Start transparent
                                    end: 1, // End opaque
                                    duration: 500.ms,
                                    delay: 100.ms * index,
                                  ),
                                ],
                                child: GestureDetector(
                                  onTap: () {
                                    controller.getClassTuteeById(
                                        context,
                                        filteredList![index].className!,
                                        filteredList![index].subject!,
                                        filteredList![index].tutorId!,
                                        filteredList![index].tutorName!,filteredList![index].fees!,
                                        filteredList![index].batchMaximumSlots!,
                                         filteredList![index].batchTimingStart!,
                                         filteredList![index].batchTimingEnd!,
                                         filteredList![index].tutorAddress!,
                                        filteredList![index].courseId! ,
                                        filteredList![index].ratings!=null? filteredList![index].ratings!.averageRating.toString() ?? '0' : '0',
                                        );
                                  },
                                  child: CourseListContainer1(
                                    image: "",
                                    subject: filteredList![index].subject!, //
                                    subjectCode:
                                        "₹ ${filteredList![index]!.fees!}",
                                    std: filteredList![index].className!,
                                    medium: filteredList![index].batchMode!,
                                    group: filteredList![index].courseCode!,
                                    groupcode:
                                        "${filteredList![index].batchTimingStart!}-${filteredList![index].batchTimingEnd!}",
                                    arrowIcon: true,
                                    className: filteredList![index].className!,
                                    tutorId: filteredList![index].tutorId!,
                                    batchname: filteredList![index].batchName!,
                                    tutorname: filteredList![index].tutorName!,
                                    type: widget.type,
                                    id: '',
                                     batchMaximumSlots: filteredList![index].batchMaximumSlots ?? '', 
                                     batchTimingStart:  filteredList![index].batchTimingStart??'', 
                                     batchTimingEnd: filteredList![index].batchTimingEnd??'',
                                      address:    filteredList![index].tutorAddress ??'', courseId: filteredList![index].courseId!, ratings: filteredList![index].ratings!=null? filteredList![index].ratings!.averageRating.toString() ?? '0' : '0',
                                  ),
                                ),
                              );
                            }))
          ],
        ),
      ),
    );
  }
}
