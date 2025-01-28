import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovee_attendence/constants/colors_constants.dart';
import 'package:hovee_attendence/modals/getHostelFilterListModel.dart';
import 'package:hovee_attendence/services/webServices.dart';
import 'package:hovee_attendence/utils/customAppBar.dart';
import 'package:hovee_attendence/utils/search_filter_tabber.dart';
import 'package:hovee_attendence/view/Hosteller/hostel_details_screen.dart';
import 'package:hovee_attendence/widget/cateory_widget.dart';

class HostelList extends StatefulWidget {
  const HostelList({super.key});

  @override
  State<HostelList> createState() => _HostelListState();
}

class _HostelListState extends State<HostelList> {
  bool isLoadingcategory = false;
  List<String> categories = [];
  int selectedIndex = 0;

  List<Datum>? filteredList = [];
  bool isLoadingcategoryList = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   // fetchHostelCategory();
    filteredfetchList('All', '');
  }

  void fetchHostelCategory() async {
    // isLoadingcategory(true);
    setState(() {
      isLoadingcategory = true;
    });
    var response = await WebService.fetchHostelcategory();

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
    var response = await WebService.getHostelFilterListfetch(type, searchTerm);
    if (response != null && response.success == true) {
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
    return Scaffold(
       backgroundColor: Colors.white,
      appBar: AppBarHeader(
          needGoBack: true,
          navigateTo: () {
            Get.back();
          }),
          body:  Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
             const SizedBox(
              height: 10,
            ),
            // Text(
            //   "Hostel based on categories",
            //   style: GoogleFonts.nunito(
            //       color: Colors.black,
            //       fontWeight: FontWeight.w500,
            //       fontSize: 16),
            // ),

            // const SizedBox(height: 10),
            // CategoryList(
            //   categories: categories,
            //   selectedIndex: selectedIndex,
            //   onCategorySelected: (index) {
            //     setState(() {
            //       selectedIndex = index;
            //     });
            //     filteredfetchList(categories[index], '');
            //   },
            //   primaryColor: AppConstants.primaryColor, // Example primary color
            // ),
            SearchfiltertabBar(
              title: 'Hostel List',
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
                            itemCount: filteredList!.length,
                            itemBuilder: (context, index) {
                              final hostel = filteredList![index];
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
                                   Get.to(HostelDetailsScreen(
                                    data: hostel,
        ));
                                  },
                                  child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Card(
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/v2.jpg',
                height: 150,
                fit: BoxFit.fill,
              ),
              const SizedBox(height: 20),
              _buildRow('Hostel name', hostel.hostelName,context),
               _buildRow('Hostel type', hostel.hostelType,context),
               _buildRow('Categories', hostel.categories,context),
                _buildRow('Room type', hostel.hostelPriceDetails!.roomType,context),
                  _buildRow('Price', hostel.hostelPriceDetails!.price!.toString(),context),
               _buildRow('Hostel Address', '${hostel.doorNo!.toString()},${hostel.street!.toString()},${hostel.city!.toString()},${hostel.state!.toString()},${hostel.country!.toString()} -${hostel.pincode!.toString()}',context),
            ],
          ),
        ),
      ),
    )
                                ),
                              );
                            }))
         
          ],
        ),),
    );
  }

  
  Widget _buildRow(String title, String? value,BuildContext context) {
    final displayValue = title == 'Fees' ? '₹ ${value ?? 'N/A'} /month' : value ?? 'N/A';

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.black.withOpacity(0.4),
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width*0.5,
          child: Text(
            displayValue,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}
