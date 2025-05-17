import 'package:flutter/material.dart';
import 'package:gastos/app/constants/app_constants.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isUser;

  const ChatBubble({super.key, required this.message, required this.isUser});

  @override
  Widget build(BuildContext context) {
    final alignment = isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final radius = Radius.circular(16);
    final borderColor = Colors.orange;
    final bgColor = isUser ? Colors.transparent : Colors.orange.shade100;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isUser)
            CircleAvatar(
              radius: 16,
              backgroundColor: Colors.orange,
              child: Icon(Icons.support_agent, size: 18, color: Colors.white),
            ),
          if (!isUser) const SizedBox(width: 8),
          Flexible(
            child: Column(
              crossAxisAlignment: alignment,
              children: [
                Text(
                  isUser ? 'Tú' : AppConstants.chatBotName,
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 4),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: bgColor,
                    border: Border.all(color: borderColor),
                    borderRadius: BorderRadius.only(
                      topLeft: radius,
                      topRight: radius,
                      bottomLeft: isUser ? radius : Radius.zero,
                      bottomRight: isUser ? Radius.zero : radius,
                    ),
                  ),
                  child: Text(
                    message,
                    style: const TextStyle(fontSize: 15),
                  ),
                ),
              ],
            ),
          ),
          if (isUser) const SizedBox(width: 8),
          if (isUser)
            CircleAvatar(
              radius: 16,
              backgroundColor: Colors.orange,
              child: Icon(Icons.person, size: 18, color: Colors.white),
            ),
        ],
      ),
    );
  }
}
