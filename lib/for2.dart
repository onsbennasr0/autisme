// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Chat App',
      theme: ThemeData(
        primaryColor: const Color(0xFF007AFF),
        hintColor: const Color(0xFF007AFF),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const ChatApp(),
    );
  }
}

class ChatApp extends StatefulWidget {
  const ChatApp({super.key});

  @override
  _ChatAppState createState() => _ChatAppState();
}

class _ChatAppState extends State<ChatApp> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = [
    const PublicChatRoom(),
    const StartPrivateChatScreen(users: ["Alice", "Bob", "Charlie"]),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Chat App'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.public),
            label: 'Public Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.lock),
            label: 'Private Chat',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}

class PublicChatRoom extends StatelessWidget {
  const PublicChatRoom({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: 20, // Simulating 20 messages
        itemBuilder: (BuildContext context, int index) {
          // Alternate between sent and received messages for demonstration
          bool isCurrentUser = index % 2 == 0;
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 375),
            child: SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(
                child: ChatBubble(
                  clipper: ChatBubbleClipper5(
                      type: isCurrentUser
                          ? BubbleType.sendBubble
                          : BubbleType.receiverBubble),
                  alignment: isCurrentUser
                      ? Alignment.topRight
                      : Alignment.topLeft,
                  margin: const EdgeInsets.only(top: 20),
                  backGroundColor:
                      isCurrentUser ? Colors.blue : Colors.grey[300],
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.7,
                    ),
                    child: Text(
                      "Message $index",
                      style: TextStyle(
                          color: isCurrentUser ? Colors.white : Colors.black),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class StartPrivateChatScreen extends StatelessWidget {
  final List<String> users;

  const StartPrivateChatScreen({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: users.length,
        itemBuilder: (BuildContext context, int index) {
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 375),
            child: SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Text(
                      users[index][0], // Display the first letter of the name
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  title: Text(users[index]),
                  onTap: () {
                    // Navigate to the private chat screen (not implemented in this example)
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
