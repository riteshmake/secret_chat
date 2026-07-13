import 'package:flutter/material.dart';
import '../models/message.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ChatScreen extends StatefulWidget {
 final String name;

  const ChatScreen({
    super.key,
    required this.name,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController messageController = TextEditingController();

  bool isTyping = false;

  List<Message> messages = [
    Message(
      text: "Hello 👋",
      isMe: false,
      time: DateTime.now(),
    ),
    Message(
      text: "Hi ❤️",
      isMe: true,
      time: DateTime.now(),
    ),
  ];
@override
void initState() {
  super.initState();
  loadMessages();
}

Future<void> saveMessages() async {
  final prefs = await SharedPreferences.getInstance();

  List<String> data = messages.map((msg) {
    return jsonEncode({
      "text": msg.text,
      "isMe": msg.isMe,
      "time": msg.time.toIso8601String(),
    });
  }).toList();

  await prefs.setStringList("chat_${widget.name}", data);
}

Future<void> loadMessages() async {
  final prefs = await SharedPreferences.getInstance();

  List<String>? data = prefs.getStringList("chat_${widget.name}");

  if (data != null) {
    setState(() {
      messages = data.map((item) {
        final json = jsonDecode(item);

        return Message(
          text: json["text"],
          isMe: json["isMe"],
          time: DateTime.parse(json["time"]),
        );
      }).toList();
    });
  }
}
  void sendMessage() {
    if (messageController.text.trim().isEmpty) return;

    setState(() {
      messages.add(
        Message(
          text: messageController.text.trim(),
          isMe: true,
          time: DateTime.now(),
        ),
      );
saveMessages();
      messageController.clear();
      isTyping = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(15),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                bool isMe = messages[index].isMe;

                return Align(
                  alignment: isMe
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: isMe
                          ? Colors.deepPurple
                          : Colors.grey.shade300,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(18),
                        topRight: const Radius.circular(18),
                        bottomLeft: Radius.circular(isMe ? 18 : 4),
                        bottomRight: Radius.circular(isMe ? 4 : 18),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: isMe
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          messages[index].text,
                          style: TextStyle(
                            color: isMe
                                ? Colors.white
                                : Colors.black,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "${messages[index].time.hour.toString().padLeft(2, '0')}:${messages[index].time.minute.toString().padLeft(2, '0')}",
                          style: TextStyle(
                            fontSize: 11,
                            color: isMe
                                ? Colors.white70
                                : Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    onChanged: (value) {
                      setState(() {
                        isTyping = value.isNotEmpty;
                      });
                    },
                    decoration: const InputDecoration(
                      hintText: "Type a message...",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.emoji_emotions_outlined),
                      suffixIcon: Icon(Icons.attach_file),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.deepPurple,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(
                      isTyping ? Icons.send : Icons.mic,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      if (isTyping) {
                        sendMessage();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("🎤 Voice message coming soon!"),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}