import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hovee_attendence/utils/customAppBar.dart';
import 'package:hovee_attendence/utils/search_filter_tabber.dart';
import 'package:hovee_attendence/view/chat_screen/live_chat_screen.dart';
import 'package:hovee_attendence/view/dashboard_screen.dart';
import 'package:hovee_attendence/modals/getBatchtuteelistModel.dart';
import 'package:hovee_attendence/services/webServices.dart';
class TuteeChatList extends StatefulWidget {
  final String batchId;
  final String? wowid;
   TuteeChatList({super.key, required this.batchId, this.wowid});

  @override
  State<TuteeChatList> createState() => _TuteeChatListState();
}

class _TuteeChatListState extends State<TuteeChatList> {
   bool isLoading = true;
  List<Datum>? batchTuteeList ;

    @override
  void initState() {
    // TODO: implement initState
    super.initState();
fetchBatchTuteeList(batchId: widget.batchId);
  }

  void fetchBatchTuteeList({String searchTerm = '', String?batchId}) async {
  try {
    isLoading = true; // Start loading
    // Prepare the request payload
    final requestPayload = 
{
    "batchId":batchId,
    "page":"",
    "limit":'',
    "search":""
};

    // Fetch batch list from the API
    var batchResponse = await WebService.fetchBatchTuteeList(requestPayload);

    if (batchResponse!.data != null) {
      setState(() {
         batchTuteeList = batchResponse.data;
         isLoading=false;
      });
      
    } else {
        isLoading=false;
    }
  } catch (e) {
  
    print('Error fetching batch list: $e');
  } finally {
    isLoading = false; // Stop loading
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarHeader(
          needGoBack: true,
          navigateTo: () {
            Get.back();
          }),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
                    'Chats',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
          ),
isLoading
    ? Center(child: CircularProgressIndicator())
    : (batchTuteeList == null ||
            batchTuteeList!.isEmpty ||
            batchTuteeList!.every((batch) => batch.tutees.isEmpty))
        ? Center(child: Text("No tutee found"))
        : Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: batchTuteeList!
                    .fold(0, (sum, batch) => sum! + batch.tutees.length),
                itemBuilder: (context, index) {
                  List<Tutee> allTutees = batchTuteeList!
                      .expand((batch) => batch.tutees)
                      .toList();

                  Tutee tutee = allTutees[index];

                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.grey.shade200,
                      radius: 30,
                      child: tutee.profileUrl != null &&
                              tutee.profileUrl!.isNotEmpty
                          ? ClipOval(
                              child: Image.network(
                                tutee.profileUrl!,
                                fit: BoxFit.cover,
                                width: 60,
                                height: 60,
                              ),
                            )
                          : const Icon(
                              Icons.person,
                              size: 36,
                              color: Colors.black,
                            ),
                    ),
                    title: Text(
                      '${tutee.firstName ?? ''} ${tutee.lastName ?? ''}',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Text(
                      "Last seen recently", // Example subtitle
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                    onTap: () {
                      // Handle chat navigation here
                                        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => ChatScreen(
                    chatId: "6DtNTIHlCJX1poxW14qfR0dvZx92"
,
                    senderId: widget.wowid ?? "",
                  )),
        );
                    },
                    trailing: Text(
                      "11:00 PM", // Example subtitle
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                  );
                },
              ),
            ),
          )

        ]),
    );
  }
}