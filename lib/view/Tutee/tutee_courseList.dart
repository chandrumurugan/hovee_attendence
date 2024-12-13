import 'package:flutter/material.dart';
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
  const GetTopicsCourses({super.key, required this.type});

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
    filteredfetchList('All','');
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
  var response = await WebService.singleCourseListfetch(type,searchTerm);
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
      appBar: AppBarHeader(
          needGoBack: true,
          navigateTo: () {
           Get.offAll(DashboardScreen(rolename: widget.type,));
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
              filteredfetchList(categories[index],'');
            },
            primaryColor: AppConstants.primaryColor, // Example primary color
          ),

            //SizedBox(height: 10,),
            SearchfiltertabBar(
            title: 'Course List',
            onSearchChanged: (searchTerm) {
             filteredfetchList('',searchTerm);
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
                              return GestureDetector(
                                onTap: (){
                                 controller.getClassTuteeById(context,filteredList![index].className!,filteredList![index].subject!,filteredList![index].tutorId!,filteredList![index].tutorName!);
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
                                    arrowIcon: true, className: filteredList![index].className!, tutorId: filteredList![index].tutorId!, batchname: filteredList![index].batchName!, tutorname: filteredList![index].tutorName!, type: widget.type, id: '',),
                              );
                            }))
          ],
        ),
      ),
    );
  }

 
}
