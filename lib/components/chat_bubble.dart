import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;

  const ChatBubble({super.key, required this.message, required this.isCurrentUser});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.7,
      ),
      decoration: BoxDecoration(
        color: isCurrentUser ? Colors.blue : Colors.green.shade500,
        borderRadius: BorderRadius.circular(12),
      ),
    child: Text(
      message,
      style: const TextStyle(color: Colors.white),
    ),
    );
  }
}