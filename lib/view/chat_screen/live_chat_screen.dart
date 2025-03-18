import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart' show Get;
import 'package:google_fonts/google_fonts.dart' show GoogleFonts;
import 'package:hovee_attendence/constants/colors_constants.dart';
import 'package:hovee_attendence/utils/customAppBar.dart';


class ChatScreen extends StatefulWidget {
  final String chatId;
  final String senderId;
  ChatScreen({required this.chatId, required this.senderId});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  // void sendMessage() {
  //   if (_controller.text.isEmpty) return;

  //   FirebaseFirestore.instance
  //       .collection('chats')
  //       .doc(widget.chatId)
  //       .collection('messages')
  //       .add({
  //         'senderId': widget.senderId,
  //         'message': _controller.text,
  //         'timestamp': FieldValue.serverTimestamp(),
  //       });

  //   _controller.clear();
  // }

  void sendMessage() {
    if (_controller.text.isEmpty) return;

    FirebaseFirestore.instance
        .collection('chats')
        .doc(widget.chatId)
        .collection('messages')
        .add({
      'senderId': widget.senderId,
      'message': _controller.text,
      'timestamp': FieldValue.serverTimestamp(),
      'localTimestamp': DateTime.now(), // Add fallback timestamp
    }).then((_) => _scrollToBottom());

    _controller.clear();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
    // sendWelcomeMessage();
  }

  void _scrollToBottom() {
    Future.delayed(Duration(milliseconds: 300), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void sendWelcomeMessage() async {
    var messages = await FirebaseFirestore.instance
        .collection('chats')
        .doc(widget.chatId)
        .collection('messages')
        .get();

    if (messages.docs.isEmpty) {
      FirebaseFirestore.instance
          .collection('chats')
          .doc(widget.chatId)
          .collection('messages')
          .add({
        'message': "Hello! How can I assist you?",
        'senderId': widget.senderId,
        'timestamp': FieldValue.serverTimestamp(),
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBarHeader(
          needGoBack: true,
          navigateTo: () {
          Get.back();
          }),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('chats')
                      .doc(widget.chatId)
                      .collection('messages')
                      .orderBy('timestamp', descending: false)
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return Center(child: Text("Error loading messages"));
                    }

                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return Center(child: Text("No messages yet"));
                    }
                    return ListView(
                      controller: _scrollController,
                      children: snapshot.data!.docs.map((msg) {
                        bool isMe = msg['senderId'] == widget.senderId;
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8.0, bottom: 10, top: 10),
                          child: Align(
                            alignment: isMe
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: isMe
                                      ? MainAxisAlignment.end
                                      : MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (!isMe) ...[
                                      _buildProfileIcon(Icons.person,
                                          AppConstants.secondaryColor),
                                    ],
                                    _buildMessageBubble(
                                        isMe, msg['message'], w),
                                    // if (isMe) ...[
                                    //   _buildProfileIcon(
                                    //       Icons.person, AppColors.primary_color),
                                    // ],
                                  ],
                                ),
                                //  _buildMessageBubble(isMe, msg['message'], w),

                                Align(
                                  alignment: isMe
                                      ? Alignment.centerRight
                                      : Alignment.centerLeft,
                                  child: Text(
                                    _formatTimestamp(msg['timestamp']),
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),
              ),
              Container(
                color: Colors.grey[300],
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          decoration: InputDecoration(
                              hintText: "Type a message",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                      ),
                      IconButton(
                          icon: Icon(Icons.send), onPressed: sendMessage),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
              child: Container(
            width: double.infinity,
            height: 80,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [AppConstants.primaryColor,AppConstants.secondaryColor],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight),
            ),
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.person,
                        color: AppConstants.secondaryColor,
                        size: 18,
                      ),
                    ),
                    Positioned(
                      bottom: 0,right: 0,
                      child: CircleAvatar(
                        radius: 8,
                        backgroundColor: Colors.green,
                        
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "hovee rent support!",
                      style: GoogleFonts.nunito(color: Colors.white,fontSize: 20),
                    ),
                    Text(
                      "Online",
                      style: GoogleFonts.nunito(color: Colors.white),
                    ),
                  ],
                )
              ],
            ),
          ))
        ],
      ),
    );
  }

  String _formatTimestamp(dynamic timestamp) {
    if (timestamp == null || timestamp is! Timestamp) return 'Just now';
    DateTime date = timestamp.toDate();
    return "${date.hour}:${date.minute < 10 ? '0${date.minute}' : date.minute} ${date.hour < 12 ? 'AM' : 'PM'}";
  }

  Widget _buildMessageBubble(
      bool isUserMessage, String messageText, double width) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: const Radius.circular(20),
          topRight: const Radius.circular(20),
          bottomRight: Radius.circular(isUserMessage ? 0 : 20),
          topLeft: Radius.circular(isUserMessage ? 20 : 0),
        ),
        color:
            isUserMessage ? AppConstants.primaryColor: AppConstants.secondaryColor,
      ),
      constraints: BoxConstraints(maxWidth: width * 2 / 3),
      child: Text(
        messageText,
        style: GoogleFonts.nunito(color: Colors.white),
      ),
    );
  }

  Widget _buildProfileIcon(IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: CircleAvatar(
        radius: 10,
        backgroundColor: color,
        child: Icon(
          icon,
          color: Colors.white,
          size: 8,
        ),
      ),
    );
  }
}
