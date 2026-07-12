import 'package:flutter/material.dart';

class ChatTile extends StatelessWidget {
  final String name;
  final String message;
  final String time;

  const ChatTile({
    super.key,
    required this.name,
    required this.message,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
        radius: 28,
        child: Icon(Icons.person),
      ),
      title: Text(
        name,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(message),
      trailing: Text(time),
    );
  }
}