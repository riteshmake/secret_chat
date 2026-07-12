import 'package:flutter/material.dart';

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

  List<String> messages = [
    "Hello 👋",
    "Hi ❤️",
  ];

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

                bool isMe = index % 2 == 1;

                return Align(
                  alignment:
                      isMe ? Alignment.centerRight : Alignment.centerLeft,

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
                    child: Text(
                      messages[index],

                      style: TextStyle(
                        color:
                            isMe ? Colors.white : Colors.black,
                      ),
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
  margin: const EdgeInsets.only(left: 8),
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
        if (messageController.text.isNotEmpty) {
          setState(() {
            messages.add(messageController.text);
            messageController.clear();
            isTyping = false;
          });
        }
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