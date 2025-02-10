import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovee_attendence/constants/colors_constants.dart';


class MessagesScreen extends StatefulWidget {
  final List messages;
  final ScrollController scrollController;
  final Function(String) onSendMessage;

  const MessagesScreen({
    Key? key,
    required this.messages,
    required this.scrollController,
    required this.onSendMessage,
  }) : super(key: key);

  @override
  MessageScreenState createState() => MessageScreenState();
}

class MessageScreenState extends State<MessagesScreen> {
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;

    return ListView.builder(
      controller: widget.scrollController,
      itemCount: widget.messages.length,
      padding: EdgeInsets.only(bottom: 20),
      itemBuilder: (context, index) {
        bool isUserMessage = widget.messages[index]['isUserMessage'];
        String messageText = widget.messages[index]['message'].text.text[0];
        Map<String, dynamic> parameters =
            widget.messages[index]['parameters'] ?? {};
        final time = widget.messages[index]['time'];

        return Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            crossAxisAlignment: isUserMessage
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: isUserMessage
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!isUserMessage) ...[
                    _buildProfileIcon(Icons.bolt, AppConstants.secondaryColor),
                  ],
                  _buildMessageBubble(isUserMessage, messageText, w),
                  if (isUserMessage) ...[
                    _buildProfileIcon(Icons.person, AppConstants.primaryColor),
                  ],
                ],
              ),
              if (time != null)
                Align(
                  alignment: isUserMessage
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 4,
                      left: !isUserMessage ? 55 : 0.0,
                      right: !isUserMessage ? 0.0 : 55,
                    ),
                    child: Text(time,
                        style: GoogleFonts.nunito(
                            color: Colors.black, fontSize: 12)),
                  ),
                ),
              if (!isUserMessage && parameters.isNotEmpty)
                _buildOptionsContainer(parameters, isUserMessage),
            ],
          ),
        );
      },
    );
  }

  Widget _buildProfileIcon(IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: CircleAvatar(
        backgroundColor: color,
        child: Icon(icon, color: Colors.white),
      ),
    );
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
            isUserMessage ? AppConstants.primaryColor : AppConstants.secondaryColor,
      ),
      constraints: BoxConstraints(maxWidth: width * 2 / 3),
      child: Text(
        messageText,
        style: GoogleFonts.nunito(color: Colors.white),
      ),
    );
  }

  Widget _buildOptionsContainer(Map<String, dynamic> parameters, bool isUser) {
    return Padding(
      padding: const EdgeInsets.only(left: 50, right: 50, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: parameters.entries.map((entry) {
          // Safely extract value based on type
          String displayText;
          if (entry.value is String) {
            displayText = entry.value as String;
          } else if (entry.value is Map<String, dynamic>) {
            // Handle other cases if necessary
            displayText = entry.value['stringValue'] ?? entry.key;
          } else {
            displayText = entry.key; // Default case if unknown type
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppConstants.secondaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: GestureDetector(
                  onTap: () => widget.onSendMessage(displayText),
                  child: Text(
                    displayText,
                    style: GoogleFonts.nunito(color: Colors.black),
                  ),
                ),
              ),
              if (entry.key != parameters.keys.last)
                Divider(color: Colors.grey),
            ],
          );
        }).toList(),
      ),
    );
  }
}
