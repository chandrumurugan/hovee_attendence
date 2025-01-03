import 'package:carousel_slider/carousel_slider.dart';
import 'package:five_pointed_star/five_pointed_star.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovee_attendence/constants/colors_constants.dart';
import 'package:hovee_attendence/modals/guestHome_modal.dart';
import 'package:hovee_attendence/services/webServices.dart';
import 'package:hovee_attendence/view/Tutee/tutee_courseList.dart';
import 'package:hovee_attendence/view/loginSignup/loginSingup.dart';
import 'package:hovee_attendence/view/sidemenu.dart';
import 'package:hovee_attendence/widget/gifController.dart';

class GuestHomeScreen extends StatefulWidget {
  const GuestHomeScreen({super.key});

  @override
  State<GuestHomeScreen> createState() => _GuestHomeScreenState();
}

class _GuestHomeScreenState extends State<GuestHomeScreen> {
  int _currentIndex = 0;
  GlobalKey<ScaffoldState> guestScaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoading = false;
  Data? guestHomeData;
  int mycount = 0;
  int _currentIndexSlider = 0;
  @override
  void initState() {
    super.initState();
    getHomeData();
  }

  void getHomeData() async {
    setState(() {
      isLoading = true;
    });
    var response = await WebService.fetchGuestUser();
    if (response != null && response.statusCode == 200) {
      setState(() {
        guestHomeData = response.data;
        isLoading = false;
      });

      // guestHomeData.teacherList
    }
  }

  final List<Map<String, String>> testimonials = [
    {
      "name": "John Hook",
      "location": "Chennai",
      "image":
          "assets/tutorHomeImg/Rectangle 18373.png", // Replace with your image URL
      "text":
          "It is a long-established fact that a reader will be distracted by the readable content of a page when looking."
    },
    {
      "name": "Jane Doe",
      "location": "Mumbai",
      "image": "assets/tutorHomeImg/Rectangle 18373.png",
      "text":
          "The quick brown fox jumps over the lazy dog, providing an example of a sentence that uses every letter."
    },
    {
      "name": "Emily Smith",
      "location": "Bangalore",
      "image": "assets/tutorHomeImg/Rectangle 18373.png",
      "text":
          "Flutter is an open-source UI software development toolkit created by Google."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: guestScaffoldKey,
        backgroundColor: Colors.white,
        drawer: SideMenu(
          isGuest: true,
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          selectedLabelStyle: const TextStyle(
            fontSize: 12,
            color: AppConstants.secondaryColor,
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
          items: _navBarsItems(),
          onTap: (index) {
            if (index == 0) {
              // Stay on Home
              setState(() {
                _currentIndex = index;
              });
            } else {
              // Navigate to LoginSignUp
              Get.to(() => const LoginSignUp());
            }
          },
          currentIndex: _currentIndex,
          selectedItemColor: AppConstants.secondaryColor,
          unselectedItemColor: Colors.grey,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
        ),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : _currentIndex == 0
                ? SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildCustomAppBar(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            "Our services",
                            style: GoogleFonts.nunito(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          //color: Colors.amber,
                          height: 210,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Stack(
                            children: [
                              Center(
                                child: Container(
                                  height: 180,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    // color: Colors.amber,
                                    borderRadius: BorderRadius.circular(20),
                                    gradient: const LinearGradient(colors: [
                                      Color(0xFFBA0161),
                                      Color(0xFF510270)
                                    ]),
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "assets/bgImage/detailpagebanner.jpg"),
                                        fit: BoxFit.cover),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Attendence !',
                                          style: GoogleFonts.nunito(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 24),
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.6,
                                              child: Text(
                                                'Track student attendance in real-time with live location updates. Designed for schools, coaching centers, and institutions.',
                                                style: GoogleFonts.nunito(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 12),
                                              ),
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
                                  //  ClipRRect(
                                  //     borderRadius: BorderRadius.circular(20),
                                  //     child: Image.asset(
                                  //       "assets/bgImage/detailpagebanner.jpg",
                                  //       fit: BoxFit.cover,
                                  //     )),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                left: 15,
                                child: Container(
                                  height: 50,
                                  width: 120,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white),
                                  child: Center(
                                    child: Container(
                                      height: 40,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: const Color(0xFF31302D),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "2/3",
                                          style: GoogleFonts.nunito(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Top Teachers",
                                style: GoogleFonts.nunito(
                                    color: Colors.black,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold),
                              ),
                              // Text(
                              //   "see all",
                              //   style: GoogleFonts.nunito(
                              //       color: const Color(0xFFFF9900),
                              //       fontSize: 13,
                              //       fontWeight: FontWeight.w700),
                              // ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          height:
                              120, // Increased height to accommodate the text
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Stack(
                            clipBehavior: Clip
                                .none, // Allow the images to overflow the container
                            children: List.generate(
                              guestHomeData!
                                  .teacherList.length, // Use the dynamic length
                              (index) {
                                return Positioned(
                                  left: index *
                                      70.0, // Adjust the spacing between items
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const CircleAvatar(
                                        radius: 40,
                                        backgroundColor: Colors
                                            .blueAccent, // Add dynamic colors if needed
                                        backgroundImage: AssetImage(
                                          'assets/Ellipse 261.png', // Use a dynamic image if required
                                        ),
                                      ),
                                      const SizedBox(
                                          height:
                                              5), // Add spacing between the image and text
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.2,
                                        child: Text(
                                          guestHomeData!.teacherList[index]
                                              .teacherName, // Dynamic name
                                          style: const TextStyle(
                                              fontSize:
                                                  14), // Adjust font size if needed
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow
                                              .clip, // Center align text
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Steps to Follow",
                                style: GoogleFonts.nunito(
                                    color: Colors.black,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold),
                              ),
                              // Text(
                              //   "see all",
                              //   style: GoogleFonts.nunito(
                              //       color: const Color(0xFFFF9900),
                              //       fontSize: 13,
                              //       fontWeight: FontWeight.w700),
                              // ),
                            ],
                          ),
                        ),
                        Container(
                          height: 270,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            // border: Border.all(color: Colors.blue, width: 2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: GridView.count(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            crossAxisCount: 2,
                            childAspectRatio: 2,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            children: [
                              _buildStepCard(
                                  'assets/edit 1.png', "Registration"),
                              _buildStepCard('assets/search (1) 1.png',
                                  "Search Using Map"),
                              _buildStepCard(
                                  'assets/diploma 1.png', "Enrollments"),
                              _buildStepCard('assets/edit 1.png', "Enquiry"),
                              _buildStepCard('assets/edit 1.png', "Attendance"),
                              _buildStepCard('assets/star 2.png', "Ratings"),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Our courses",
                                style: GoogleFonts.nunito(
                                    color: Colors.black,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold),
                              ),
                              InkWell(
                                onTap: () {
                                  Get.to(() => LoginSignUp());
                                },
                                child: Text(
                                  "See all",
                                  style: GoogleFonts.nunito(
                                      color: const Color(0xFFFF9900),
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                            height: 220,
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            decoration: const BoxDecoration(
                              color: Color(0xFFF0E6F5),
                            ),
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  final course =
                                      guestHomeData!.courseList[index];
                                  return Stack(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        margin:
                                            const EdgeInsets.only(right: 10),
                                        width: 250,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Stack(
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Card(
                                                  elevation: 0.0,
                                                  color: Colors.white,
                                                  surfaceTintColor:
                                                      Colors.white,
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        height: 80,
                                                        decoration: BoxDecoration(
                                                            color: const Color(
                                                                0xFFC7BAE9),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        child: Center(
                                                          child: Text(
                                                              "${course!.batchName}",
                                                              style: GoogleFonts.nunito(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600)),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Text("${course!.batchName}",
                                                    style: GoogleFonts.nunito(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600)),
                                                Text("${course!.subject}",
                                                    style: GoogleFonts.nunito(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400)),
                                                SizedBox(
                                                  height: 8,
                                                ),
                                                FivePointedStar(
                                                  onChange: (count) {
                                                    setState(() {
                                                      mycount = count;
                                                    });
                                                  },
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Positioned(
                                        right: 15,
                                        bottom: 0,
                                        child: Container(
                                          height: 40,
                                          width: 60,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              gradient:
                                                  const LinearGradient(colors: [
                                                Color(0xFFC13584),
                                                Color(0xFF833AB4),
                                              ])),
                                          child: const Center(
                                              child: Icon(
                                            Icons.arrow_forward_ios_outlined,
                                            color: Colors.white,
                                          )),
                                        ),
                                      )
                                    ],
                                  );
                                },
                                itemCount: guestHomeData!.courseList.length)),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 15),
                          child: Text(
                            "Testimonial",
                            style: GoogleFonts.nunito(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        CarouselSlider(
                          options: CarouselOptions(
                            height: MediaQuery.of(context).size.height * 0.2,
                            enableInfiniteScroll: false,
                            enlargeCenterPage: true,
                            viewportFraction: 0.9,
                            onPageChanged: (index, reason) {
                              setState(() {
                                _currentIndexSlider = index;
                              });
                            },
                          ),
                          items: testimonials.map((testimonial) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Container(
                                  padding: EdgeInsets.all(16),
                                  margin: EdgeInsets.symmetric(horizontal: 8),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(16),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 4,
                                        offset: Offset(2, 2),
                                      ),
                                    ],
                                  ),
                                  child: Stack(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Stack(
                                                children: [
                                                  CircleAvatar(
                                                    backgroundImage: AssetImage(
                                                      testimonial["image"]!,
                                                    ),
                                                    radius: 40,
                                                  ),
                                                  Positioned(
                                                    top: 0,
                                                    right: 0,
                                                    child: CircleAvatar(
                                                      backgroundColor:
                                                          Colors.orange,
                                                      radius: 10,
                                                      child: Icon(
                                                        Icons.format_quote,
                                                        size: 12,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(width: 10),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        testimonial["name"]!,
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      SizedBox(width: 4),
                                                      Text(
                                                        testimonial[
                                                            "location"]!,
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          color:
                                                              Colors.grey[600],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.5,
                                                    child: Text(
                                                      testimonial["text"]!,
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.grey[600],
                                                      ),
                                                      maxLines: 4,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          }).toList(),
                        ),
                        SizedBox(height: 16),
                        // Indicator
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            testimonials.length,
                            (index) => AnimatedContainer(
                              duration: Duration(milliseconds: 300),
                              margin: EdgeInsets.symmetric(horizontal: 4),
                              width: _currentIndexSlider == index ? 12 : 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: _currentIndexSlider == index
                                    ? Colors.red
                                    : Colors.grey,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                            width:
                                16), // Add spacing between dots and the count
                        // Numeric Indicator

                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 20),
                          child: Container(
                            // height: 80,
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(colors: [
                                  const Color(0xFFBA0161).withOpacity(0.1),
                                  const Color(0xFFBA0161).withOpacity(0.1),
                                ])),
                            child: Row(children: [
                              Container(
                                child: Image.asset(
                                  "assets/bgImage/iMockup - iPhone 14.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Title",
                                      style: GoogleFonts.nunito(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      child: Text(
                                          'Lorem Ipsum is simply dummy text of the printing and typesetting industry',
                                          style: GoogleFonts.nunito(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400)),
                                    ),
                                    Container(
                                        margin: const EdgeInsets.only(top: 10),
                                        padding: const EdgeInsets.all(10),
                                        width: 120,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            gradient: const LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                colors: [
                                                  Color(0xFFBA0161),
                                                  Color(0xFF510270),
                                                ])),
                                        child: Center(
                                          child: Text(
                                            "SHARE",
                                            style: GoogleFonts.nunito(
                                                color: Colors.white),
                                          ),
                                        ))
                                  ],
                                ),
                              )
                            ]),
                          ),
                        ),
                      ],
                    ),
                  )
                : Container());
  }

  Widget _buildCustomAppBar() {
    return Stack(
      children: [
        // Gradient background with curve
        Container(
          // color: Colors.yellowAccent,
          height: 230, // Adjust height as needed
          child: ClipPath(
            clipper: WaveClipper(),
            child: Container(
              decoration: const BoxDecoration(
                  gradient: RadialGradient(
                      colors: [Color(0xFFBA0161), Color(0xFFE510270)],
                      focalRadius: 1.0)

                  // LinearGradient(
                  //   colors: [Color(0xFF8228FF), Color(0xFFE94057)],
                  //   begin: Alignment.topLeft,
                  //   end: Alignment.bottomRight,
                  // ),
                  ),
            ),
          ),
        ),
        Positioned(
          top: 40,
          left: 16,
          right: 16,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  guestScaffoldKey.currentState!.openDrawer();
                },
                child: Image.asset(
                  'assets/appbar/Group 2322.png',
                  color: Colors.white,
                ),
              ),
              const Row(
                children: [
                  Icon(Icons.search, color: Colors.white),
                  SizedBox(width: 16),
                  // Icon(Icons.g_translate, color: Colors.white),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          top: 90,
          left: 16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome ,',
                style: GoogleFonts.lato(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Row(
                children: [
                  Icon(Icons.keyboard_arrow_down, color: Colors.white),
                  Text(
                    'Chennai, India',
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          top: 100,
          right: 70,
          child: CircleAvatar(
            radius: 55,
            backgroundColor: Color(0xFF9B0155),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 50,
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/guest_logo.jpg',
                        height: 72,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStepCard(String image, String title) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xffF0E6F5),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 4,
          ),
        ],
      ),
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 8,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 40,
              child: Image.asset(fit: BoxFit.contain, image.toString()),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.2,
            child: Text(
              title,
              style: GoogleFonts.lato(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  List<BottomNavigationBarItem> _navBarsItems() {
    return [
      BottomNavigationBarItem(
          label: 'Home',
          activeIcon: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFC13584), Color(0xFF833AB4)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(8)),
            child: SizedBox(
              width: 35,
              height: 35,
              child: Image.asset(
                'assets/bottomBar/Group (4).png',
                color: Colors.white,
              ),
            ),
          ),
          icon: SizedBox(
            width: 35,
            height: 35,
            child: Image.asset(
              'assets/bottomBar/Group (4).png',
              color: Colors.grey,
              // width: 35,
              //   height: 35,
            ),
          ),
          backgroundColor: Colors.white),
      BottomNavigationBarItem(
          label: 'Enquiries',
          activeIcon: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFC13584), Color(0xFF833AB4)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(8)),
            child: SizedBox(
              width: 35,
              height: 35,
              child: Image.asset(
                'assets/bottomBar/user (1) 1.png',
                color: Colors.white,
                // width: 35,
                // height: 35,
              ),
            ),
          ),
          icon: SizedBox(
            width: 35,
            height: 35,
            child: Image.asset(
              'assets/bottomBar/user (1) 1.png',
              // width: 35,
              //   height: 35,
            ),
          ),
          backgroundColor: Colors.white),
      BottomNavigationBarItem(
          label: 'Enrollments',
          activeIcon: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFC13584), Color(0xFF833AB4)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(8)),
            child: SizedBox(
              width: 35,
              height: 35,
              child: Image.asset(
                'assets/bottomBar/online-learning 1.png',
                color: Colors.white,
                // width: 35,
                // height: 35,
              ),
            ),
          ),
          icon: SizedBox(
            width: 35,
            height: 35,
            child: Image.asset(
              'assets/bottomBar/online-learning 1.png',
              // width: 35,
              //   height: 35,
            ),
          ),
          backgroundColor: Colors.white),
      BottomNavigationBarItem(
          label: 'Rating',
          activeIcon: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFC13584), Color(0xFF833AB4)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(8)),
            child: SizedBox(
              width: 35,
              height: 35,
              child: Image.asset(
                'assets/bottomBar/Vector (4).png',
                color: Colors.white,
                // width: 35,
                // height: 35,
              ),
            ),
          ),
          icon: SizedBox(
            width: 35,
            height: 35,
            child: Image.asset(
              'assets/bottomBar/Vector (4).png',
              color: Colors.grey,
              // width: 35,
              //   height: 35,
            ),
          ),
          backgroundColor: Colors.white),
      BottomNavigationBarItem(
          label: 'Plan',
          activeIcon: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFC13584), Color(0xFF833AB4)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(8)),
            child: SizedBox(
              width: 35,
              height: 35,
              child: Image.asset(
                'assets/bottomBar/Vector (2).png',
                color: Colors.white,
                // width: 50,
                // height: 50,
              ),
            ),
          ),
          icon: SizedBox(
            width: 35,
            height: 35,
            child: Image.asset(
              'assets/bottomBar/Vector (2).png',

              // width: 50,
              //     height: 50,
            ),
          ),
          backgroundColor: Colors.white),
    ];
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 50); // Start at the bottom-left corner

    // First wave: Bigger and lower
    path.quadraticBezierTo(
      size.width * 0.5, size.height, // Control point
      size.width * 0.7, size.height - 100, // End point
    );

    // Second wave: Smaller and higher
    path.quadraticBezierTo(
      size.width * 0.9, size.height - 180, // Control point
      size.width, size.height - 90, // End point
    );

    path.lineTo(size.width, 0); // Top-right corner
    path.close(); // Close the path
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
