import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovee_attendence/constants/colors_constants.dart';
import 'package:hovee_attendence/controllers/userProfileView_controller.dart';
import 'package:hovee_attendence/utils/customAppBar.dart';
import 'package:hovee_attendence/view/chat_screen/live_chat_screen.dart';
import 'package:hovee_attendence/view/chat_screen/message_module.dart';


class CustomerChat extends StatefulWidget {
  const CustomerChat({Key? key,}) : super(key: key);

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<CustomerChat> {
  late DialogFlowtter dialogFlowtter;
  late final ScrollController _scrollController;
  bool isLoading = false;
  bool showPredefinedTexts = true;

  List<Map<String, dynamic>> messages = [];
  List<String> predefinedTexts = [
    "General & Account Related",
    "Tutee Related",
    "Tutor Related",
    //thers",
    "Live chat"
  ];

   String?profileImage = "";
   String? wowId = "";
  String? firstName = "";
  String? lastname = "";

   final UserProfileController userProfileData = Get.put(UserProfileController());

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    initializeDialogFlowtter();

    // Add initial chatbot message
    addMessage(Message(text: DialogText(text: ["Hello, how can I help you?"])));
  }

  Future<void> initializeDialogFlowtter() async {
    try {
      setState(() {
        isLoading = true;
      });
      dialogFlowtter = DialogFlowtter(jsonPath: "assets/dialog_flow_auth.json");
   firstName =userProfileData.userProfileResponse.value.data?.firstName;
  lastname=  userProfileData.userProfileResponse.value.data?.lastName;
   wowId =  userProfileData.userProfileResponse.value.data?.wowId;
   profileImage =  userProfileData.userProfileResponse.value.data?.profileUrl.toString();
    } catch (e) {
      if (kDebugMode) {
        print('Error initializing DialogFlowtter: $e');
      }
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Initialization Error'),
            content: const Text('Failed to initialize DialogFlowtter.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 130,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(0)),
              image: DecorationImage(
                image: AssetImage(
                  'assets/Course_BG_Banner.png',
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 25, left: 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'hovee attendance support!',
                        style: GoogleFonts.nunito(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 22,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            // Icon(Icons.phone, color: Colors.white,size: 28,),
                            // SizedBox(width: 15,),
                            //  Icon(Icons.video_camera_back, color: Colors.white,size: 28,),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: MessagesScreen(
              messages: messages,
              scrollController: _scrollController,
              onSendMessage: sendMessage,
            ),
          ),
          if (isLoading) const CircularProgressIndicator(),
          if (showPredefinedTexts)
            Padding(
              padding: const EdgeInsets.only(bottom: 20, top: 10),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: const LinearGradient(
                    colors: [ Color(0xFF833AB4),Color(0xFFC13584)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Wrap(
                  spacing: 8.0,
                  runSpacing: 10,
                  alignment: WrapAlignment.center,
                  children: predefinedTexts.map((text) {
                    return ActionChip(
                      side:
                          const BorderSide(color: AppConstants.primaryColor),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      label: Text(
                        text,
                        style: GoogleFonts.nunito(color: Colors.white),
                      ),
                      onPressed: () {
                        if (text == "Live chat") {
              // Navigate to Live Chat screen
               startChat(context);
              // OR
              // Navigator.push(context, MaterialPageRoute(builder: (context) => LiveChatScreen()));
            } else {
              sendMessage(text);
            }
                      },
                      backgroundColor:
                          AppConstants.secondaryColor,
                      labelStyle: const TextStyle(color: Colors.white),
                    );
                  }).toList(),
                ),
              ),
            ),
        ],
      ),
    );
  }

  void sendMessage(String text) async {
    if (text.isEmpty) {
      if (kDebugMode) {
        print('Message is empty');
      }
    } else {
      if (text == "Return to main menu") {
        setState(() {
          showPredefinedTexts = true;
        });
        return;
      }
      setState(() {
        addMessage(Message(text: DialogText(text: [text])), true);
        showPredefinedTexts = false;
      });

      try {
        final response = await dialogFlowtter.detectIntent(
          queryInput: QueryInput(text: TextInput(text: text)),
        );
        print("getting response from dialo==>${response.message!}");
        print(
            "getting response from dialo==>${response.queryResult!.parameters}");
        if (response.message != null) {
          final parameters = response.queryResult?.parameters;
          setState(() {
            addMessage(response.message!, false, parameters);
            showPredefinedTexts = parameters!.isEmpty;

            // Update predefined texts based on response (you can customize this)
            // predefinedTexts = ["More info", "Contact support", "Main menu"];
          });
        }
      } catch (e) {
        if (kDebugMode) {
          print('Error sending message to DialogFlowtter: $e');
        }
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: const Text('Failed to send message to DialogFlowtter.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }
  }

  void addMessage(Message message,
      [bool isUserMessage = false, Map<String, dynamic>? parameters]) {
    final now = DateTime.now();
    final timeString =
        "${now.hour % 12}:${now.minute.toString().padLeft(2, '0')} ${now.hour >= 12 ? 'PM' : 'AM'}";
    setState(() {
      messages.add({
        'message': message,
        'isUserMessage': isUserMessage,
        'parameters': parameters ?? {},
        'time': timeString,
      });
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

   Future<void> startChat(BuildContext context) async {
    var agents = await FirebaseFirestore.instance
        .collection('users')
        .where('role', isEqualTo: 'agent')
        .where('isAvailable', isEqualTo: true)
        .limit(1)
        .get();

    if (agents.docs.isNotEmpty) {
      var agent = agents.docs.first;
      // Check if chat already exists
      var existingChat = await FirebaseFirestore.instance
          .collection('chats')
          .where('customerId', isEqualTo: wowId)
          .where('agentId', isEqualTo: agent.id)
          .limit(1)
          .get();

      if (existingChat.docs.isNotEmpty) {
        String existingChatId = existingChat.docs.first.id;
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => ChatScreen(
                    chatId: existingChatId,
                    senderId: wowId ?? "",
                  )),
        );
        return;
      }

      // Ensure profile image exists
      String newImageUrl = profileImage ?? "";
      String chatId = FirebaseFirestore.instance.collection('chats').doc().id;
      // String newImageUrl = await uploadProfileImage(user.photoURL!, user.uid);

      await FirebaseFirestore.instance.collection('chats').doc(chatId).set({
        'customerId': wowId,
        'agentId': agent.id,
        'customerName': '${firstName} ${lastname}',
        'customerImage': newImageUrl,
        'isActive': true,
      });

      await FirebaseFirestore.instance.collection('users').doc(agent.id).update(
        {'isAvailable': false, 'assignedChatId': chatId},
      );
      
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => ChatScreen(
                  chatId: chatId,
                  senderId: wowId ?? "",
                )),
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("No agents available")));
    }
  }
}
