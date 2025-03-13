import 'package:carousel_slider/carousel_slider.dart';
import 'package:five_pointed_star/five_pointed_star.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:hovee_attendence/modals/guest_searchModel.dart';
import 'package:hovee_attendence/services/webServices.dart';
import 'package:hovee_attendence/utils/customAppBar.dart';
import 'package:hovee_attendence/view/loginSignup/loginSingup.dart';
import 'package:hovee_attendence/modals/guestHome_modal.dart';

import '../../modals/fetchGuestUserHostelListModel.dart';

class SearchGuestScreen extends StatefulWidget {
  const SearchGuestScreen({super.key});

  @override
  State<SearchGuestScreen> createState() => _SearchGuestScreenState();
}

class _SearchGuestScreenState extends State<SearchGuestScreen> {
  TextEditingController _searchController = TextEditingController();
  GuestsearchModel? guestHomeData;
  bool isLoading = false;
  int mycount = 0;
  List<Institute> filteredInstitutes = [];
  List<Course> filteredCourses = [];
  List<Hostel> filteredHostels = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //fetchGuestUserSearch();
  }

  void fetchGuestUserSearch({String searchTerm = ''}) async {
    setState(() {
      isLoading = true;
    });
    final data = {
      'searchTerm': searchTerm,
    };
    var response = await WebService.fetchGuestUserSearch(data);
    if (response != null) {
      setState(() {
        guestHomeData = response;
        isLoading = false;
        filteredInstitutes = guestHomeData!.institutes
            .where((institute) =>
                institute.institudeName!
                    .toLowerCase()
                    .contains(searchTerm.toLowerCase()) ||
                institute.city!
                    .toLowerCase()
                    .contains(searchTerm.toLowerCase()))
            .toList();

        filteredCourses = guestHomeData!.courses
            .where((course) =>
                course.batchName!
                    .toLowerCase()
                    .contains(searchTerm.toLowerCase()) ||
                course.subject!
                    .toLowerCase()
                    .contains(searchTerm.toLowerCase()))
            .toList();

        filteredHostels = guestHomeData!.hostels
            .where((hostel) =>
                hostel.hostelName!
                    .toLowerCase()
                    .contains(searchTerm.toLowerCase()) ||
                hostel.doorNo!
                    .toLowerCase()
                    .contains(searchTerm.toLowerCase()) ||
                hostel.street!
                    .toLowerCase()
                    .contains(searchTerm.toLowerCase()) ||
                hostel.city!.toLowerCase().contains(searchTerm.toLowerCase()) ||
                hostel.state!
                    .toLowerCase()
                    .contains(searchTerm.toLowerCase()) ||
                hostel.country!
                    .toLowerCase()
                    .contains(searchTerm.toLowerCase()) ||
                hostel.pincode!
                    .toLowerCase()
                    .contains(searchTerm.toLowerCase()))
            .toList();
      });
    } else {
      setState(() {
        isLoading = false;
        filteredInstitutes = [];
        filteredCourses = [];
        filteredHostels = [];
      });
      debugPrint("Invalid response format");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarHeader(
        needGoBack: true,
        navigateTo: () {
          Get.back();
        },
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
         Container(
  width: double.infinity,
  height: 50,
  margin: EdgeInsets.all(10),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(5),
    border: Border.all(color: Colors.grey),
  ),
  child: Row(
    children: [
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Icon(Icons.search, color: Colors.grey),
      ),
      Expanded(
        child: TextField(
          controller: _searchController,
          onChanged: (value) {
            fetchGuestUserSearch(searchTerm: value);
          },
          textAlign: TextAlign.start, // Centers the text
          decoration: const InputDecoration(
            hintText: 'Search...',
            border: InputBorder.none,
          ),
        ),
      ),
      if (_searchController.text.isNotEmpty)
        IconButton(
          icon: const Icon(Icons.clear, color: Colors.grey),
          onPressed: () {
            fetchGuestUserSearch(searchTerm: '');
            _searchController.clear();
          },
        ),
    ],
  ),
),

          // Displaying the Data
          Expanded(
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : filteredInstitutes.isEmpty &&
                        filteredCourses.isEmpty &&
                        filteredHostels.isEmpty
                    ? Center(child: Text("No Results Found"))
                    : buildSearchResults(),
          ),
        ],
      ),
    );
  }

  Widget buildSearchResults() {
    return Expanded(
      child: ListView(
        children: [
          if (filteredInstitutes.isNotEmpty)
            ...filteredInstitutes.map((institute) => Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                  child: Card(
                    elevation: 10,
                    shadowColor: Colors.black,
                    surfaceTintColor: Colors.white,
                    child: GestureDetector(
                      onTap: (){
                        Get.to(LoginSignUp());
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Stack(
                              children: [
                                institute.institudeUrl != null
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          institute.institudeUrl!,
                                          width: 90,
                                          height: 100,
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return Image.asset(
                                              'assets/v2.jpg', // Fallback image
                                              width: 90,
                                              height: 100,
                                              fit: BoxFit.cover,
                                            );
                                          },
                                        ),
                                      )
                                    : ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.asset(
                                          'assets/v2.jpg',
                                          width: 90,
                                          height: 100,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                              ],
                            ),
                            SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width * 0.5,
                                      child: Text(
                                        institute.institudeName ?? '',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 4),
                                  ],
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.5,
                                  child: Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: "Address: ",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors
                                                .black, // Black color for "Address"
                                            fontWeight: FontWeight
                                                .normal, // Optional: Make it bold
                                          ),
                                        ),
                                        TextSpan(
                                          text:
                                              '${institute.address!.toString()}',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey[
                                                600], // Grey color for the address text
                                          ),
                                        ),
                                      ],
                                    ),
                                    maxLines: 5,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )),
          if (filteredCourses.isNotEmpty)
            ...filteredCourses.map((course) => Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                  child: Card(
                    elevation: 10,
                    shadowColor: Colors.black,
                    surfaceTintColor: Colors.white,
                    child: GestureDetector(
                      onTap: () {
                        Get.to(LoginSignUp());
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // Image.asset(image),
                            Stack(
                              children: [
                                //  course.institudeUrl != null
                                //   ? ClipRRect(
                                //     borderRadius: BorderRadius.circular(10),
                                //     child: Image.network(
                                //        institute.institudeUrl!,
                                //         width: 90,
                                //         height: 100,
                                //         fit: BoxFit.cover,
                                //         errorBuilder: (context, error, stackTrace) {
                                //           return Image.asset(
                                //             'assets/v2.jpg', // Fallback image
                                //               width: 90,
                                //         height: 100,
                                //             fit: BoxFit.cover,
                                //           );
                                //         },
                                //       ),
                                //   )
                                //   :
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset(
                                    'assets/tuteeHomeImg/image 193.png',
                                    width: 90,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        course.subject ?? '',
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 15),
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Container(
                                        height: 1,
                                        width: 10,
                                        color: Colors.black.withOpacity(0.5),
                                      ),
                                      const SizedBox(
                                        width: 6,
                                      ),
                                      // Container(
                                      //   height: 15,
                                      //   width: 1.5,
                                      //   color: Colors.black.withOpacity(0.5),
                                      // ),
                                      // const SizedBox(
                                      //   width: 6,
                                      // ),
                                      //  type=='Tutor'?
                                      Text(
                                        course.batchName ?? '',
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            course.className ?? '',
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
                                            course.board ?? '',
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )),
          if (filteredHostels.isNotEmpty)
            ...filteredHostels.map((hostel) => Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                  child: Card(
                    elevation: 10,
                    shadowColor: Colors.black,
                    surfaceTintColor: Colors.white,
                    child: GestureDetector(
                      onTap: () {
                        Get.to(LoginSignUp());
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Stack(
                              children: [
                                hostel.profileUrl != null
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          hostel.profileUrl!,
                                          width: 90,
                                          height: 100,
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return Image.asset(
                                              'assets/v2.jpg', // Fallback image
                                              width: 90,
                                              height: 100,
                                              fit: BoxFit.cover,
                                            );
                                          },
                                        ),
                                      )
                                    : ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.asset(
                                          'assets/v2.jpg',
                                          width: 90,
                                          height: 100,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                              ],
                            ),
                            SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width * 0.5,
                                      child: Text(
                                        hostel.hostelName ?? '',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 4),
                                  ],
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.5,
                                  child: Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: "Hostel type: ",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors
                                                .black, // Black color for "Address"
                                            fontWeight: FontWeight
                                                .normal, // Optional: Make it bold
                                          ),
                                        ),
                                        TextSpan(
                                          text: hostel.hostelType ?? '',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey[
                                                600], // Grey color for the address text
                                          ),
                                        ),
                                      ],
                                    ),
                                    maxLines: 5,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.5,
                                  child: Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: "Address: ",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors
                                                .black, // Black color for "Address"
                                            fontWeight: FontWeight
                                                .normal, // Optional: Make it bold
                                          ),
                                        ),
                                        TextSpan(
                                          text:
                                              '${hostel.doorNo!.toString()},${hostel.street!.toString()},${hostel.city!.toString()},${hostel.state!.toString()},${hostel.country!.toString()} -${hostel.pincode!.toString()}',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey[
                                                600], // Grey color for the address text
                                          ),
                                        ),
                                      ],
                                    ),
                                    maxLines: 5,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )),
        ],
      ),
    );
  }
}
