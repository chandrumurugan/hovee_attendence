import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovee_attendence/constants/colors_constants.dart';
import 'package:hovee_attendence/utils/customAppBar.dart';
import 'package:hovee_attendence/view/chat_screen/message_module.dart';


class CustomerChat extends StatefulWidget {
  const CustomerChat({Key? key}) : super(key: key);

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
    "Others"
  ];

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
      dialogFlowtter = DialogFlowtter(
          jsonPath: "assets/dialog_flow_auth.json");
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
      appBar: AppBarHeader(needGoBack: true, navigateTo: () { Get.back(); },),
      body: Container(
        // decoration: const BoxDecoration(
        //   gradient: LinearGradient(
        //     begin: Alignment.topCenter,
        //     end: Alignment.bottomCenter,
        //     colors: [Colors.deepPurple, Colors.deepPurpleAccent],
        //   ),
        // ),
        child: Column(
          children: [
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
                    color: AppConstants.primaryColor.withOpacity(0.3),
                  ),
                  child: Wrap(
                    spacing: 8.0,
                    runSpacing: 10,
                    alignment: WrapAlignment.center,
                    children: predefinedTexts.map((text) {
                      return ActionChip(
                        side: BorderSide(color: AppConstants.secondaryColor),
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        label: Text(
                          text,
                          style: GoogleFonts.nunito(color: Colors.black),
                        ),
                        onPressed: () {
                          sendMessage(text);
                        },
                        backgroundColor:
                           AppConstants.secondaryColor.withOpacity(0.3),
                        labelStyle: const TextStyle(color: Colors.white),
                      );
                    }).toList(),
                  ),
                ),
              ),
          ],
        ),
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
}
