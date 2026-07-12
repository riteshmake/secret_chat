import 'package:flutter/material.dart';
import '../widgets/chat_tile.dart';
import 'new_chat_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Secret Chat"),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: "Search...",
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),

              ),
            ),
          ),

          const SizedBox(height: 20),

          const ChatTile(
            name: "Rahul",
            message: "Hello Bro 👋",
            time: "10:30 AM",
          ),

          const ChatTile(
            name: "Aman",
            message: "Kal milte hain",
            time: "09:45 AM",
          ),

          const ChatTile(
            name: "Trisha ❤️",
            message: "Miss you ❤️",
            time: "Yesterday",
          ),

          const ChatTile(
            name: "Priya",
            message: "Typing...",
            time: "Online",
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
       onPressed: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const NewChatScreen(),
    ),
  );
},
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.chat, color: Colors.white),
      ),
    );
  }
}