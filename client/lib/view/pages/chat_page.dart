import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conversations'),
        actions: [
          TextButton(
            onPressed: () {
              // Add your new conversation logic here
            },
            child: const Text(
              '+ Add New',
              style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          ChatItem(
            imageUrl: 'https://picsum.photos/200/300',
            name: 'RITHIK',
            message: 'Good to know',
            time: 'Today',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatDetailPage(name: 'Kriss Benwat'),
                ),
              );
            },
          ),
          ChatItem(
            imageUrl: 'https://picsum.photos/200/300',
            name: 'SIBOI',
            message: 'Its been a while',
            time: 'Today',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatDetailPage(name: 'Rezi Makarov'),
                ),
              );
            },
          ),
          ChatItem(
            imageUrl: 'https://picsum.photos/200/300',
            name: 'KISHORE',
            message: 'Hey, where are you?',
            time: 'Yesterday',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatDetailPage(name: 'Gustav Lemelo'),
                ),
              );
            },
          ),
          // Add more ChatItems here
        ],
      ),
    );
  }
}

class ChatItem extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String message;
  final String time;
  final VoidCallback onTap;

  const ChatItem({
    required this.imageUrl,
    required this.name,
    required this.message,
    required this.time,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      title: Text(name),
      subtitle: Text(message),
      trailing: Text(time),
      onTap: onTap,
    );
  }
}

class ChatDetailPage extends StatefulWidget {
  final String name;

  const ChatDetailPage({required this.name, Key? key}) : super(key: key);

  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  final List<ChatMessage> _messages = [
    ChatMessage(
      message: "Hey! How's it going?",
      isSentByMe: false,
    ),
    ChatMessage(
      message: "I'm good, thanks! How about you?",
      isSentByMe: true,
    ),
    ChatMessage(
      message: "Doing well, just working on some projects.",
      isSentByMe: false,
    ),
    ChatMessage(
      message: "That sounds interesting. Tell me more!",
      isSentByMe: true,
    ),
  ];
  final TextEditingController _controller = TextEditingController();

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _messages.add(
          ChatMessage(
            message: _controller.text,
            isSentByMe: true,
          ),
        );
        _controller.clear();
      });
    }
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
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return ListTile(
                  title: Align(
                    alignment:
                        message.isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: message.isSentByMe ? const Color.fromARGB(255, 114, 114, 114) : Colors.grey[300],
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Text(
                        message.message,
                        style: TextStyle(
                          color: message.isSentByMe ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Type a message',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatMessage {
  final String message;
  final bool isSentByMe;

  ChatMessage({required this.message, required this.isSentByMe});
}