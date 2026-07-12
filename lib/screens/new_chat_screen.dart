import 'package:flutter/material.dart';
import 'chat_screen.dart';

class NewChatScreen extends StatelessWidget {
  const NewChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Chat"),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const CircleAvatar(
              child: Icon(Icons.person),
            ),
            title: const Text("Rahul"),
            subtitle: const Text("Online"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatScreen(name: "Rahul"),
                ),
              );
            },
          ),

          const ListTile(
            leading: CircleAvatar(
              child: Icon(Icons.person),
            ),
            title: Text("Aman"),
            subtitle: Text("Online"),
          ),

          const ListTile(
            leading: CircleAvatar(
              child: Icon(Icons.person),
            ),
            title: Text("Trisha ❤️"),
            subtitle: Text("Last seen recently"),
          ),
        ],
      ),
    );
  }
}