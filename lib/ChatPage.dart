// ignore_for_file: avoid_print, file_names, library_private_types_in_public_api

import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  List<types.Message> _messages = [];
  late final types.User _user;

  @override
  void initState() {
    super.initState();
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? currentUser = auth.currentUser;

    _user = types.User(id: currentUser?.uid ?? '');

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animationController.forward();

    _loadMessages();
  }

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  void _loadMessages() {
    FirebaseFirestore.instance
        .collection('public_messages')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .listen((snapshot) async {
      List<types.Message> fetchedMessages = [];
      print('Snapshot received with ${snapshot.docs.length} documents'); 

      for (var doc in snapshot.docs) {
        final data = doc.data();
        print('Processing document with ID: ${doc.id}');
      final timestamp = data['createdAt'] as Timestamp?;
      final createdAt =
          timestamp?.millisecondsSinceEpoch ?? DateTime.now().millisecondsSinceEpoch;

      DocumentSnapshot userData =
          await FirebaseFirestore.instance.collection('users').doc(data['uid']).get();
          if (!userData.exists) {
        print('User data not found for UID: ${data['uid']}'); // Debug print
        continue;
      }

      Map<String, dynamic> userInfo = userData.data() as Map<String, dynamic>;
      
      final message = types.TextMessage(
        author: types.User(
          id: data['uid'],
          firstName: userInfo['name'],
          imageUrl: userInfo['profilePictureUrl'],
        ),
        createdAt: createdAt,
        id: doc.id,
        text: data['text'],
      );

      fetchedMessages.add(message);
        }


      if (mounted) {
        setState(() {
          _messages = fetchedMessages;
        });
      print('Messages loaded: ${_messages.length}'); // Debug print
    }

    });
  }

  void _handleSendPressed(types.PartialText message) async {
  final currentUser = FirebaseAuth.instance.currentUser;
  if (currentUser != null) {
    if (message.text.isNotEmpty) {
       final userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .get();
      if (userData.exists) {
        final profilePictureUrl = userData.data()?['profilePictureUrl'];
        
        // Add message to public_messages with profilePictureUrl
        FirebaseFirestore.instance.collection('public_messages').add({
          'text': message.text,
          'createdAt': FieldValue.serverTimestamp(),
          'uid': currentUser.uid,
          'profilePictureUrl': profilePictureUrl, // Include profilePictureUrl
        });

    } else {
        print('User data not found');
      }
    } else {

      final file = await FilePicker.platform.pickFiles(type: FileType.any);

      if (file != null && file.files.isNotEmpty) {
        final filePath = file.files.single.path!;
        final fileExtension = filePath.split('.').last;

        String mimeType = '';
        switch (fileExtension) {
          case 'jpg':
          case 'jpeg':
            mimeType = 'image/jpeg';
            break;
          case 'png':
            mimeType = 'image/png';
            break;
          case 'pdf':
            mimeType = 'application/pdf';
            break;
          default:
            print('Unsupported file type');
            return;
        }

        final fileMessage = types.FileMessage(
          author: _user,
          createdAt: DateTime.now().millisecondsSinceEpoch,
          id: const Uuid().v4(),
          mimeType: mimeType,
          name: file.files.single.name,
          size: file.files.single.size,
          uri: filePath,
        );

        _addMessage(fileMessage);
      } else {
        print('File picking canceled');
      }
    }
  } else {
    print("No authenticated user found.");
  }
}


  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Community Hub",
          style: TextStyle(
            color: Color.fromARGB(255, 0, 0, 0), // Title color
            fontWeight: FontWeight.normal, // Title weight
            fontStyle: FontStyle.italic,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 162, 194, 243), // AppBar background color
        elevation: 0, // Remove shadow
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.attach_file, color: Colors.white), // Attachment icon color
            onPressed: _handleAttachmentPressed,
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/Dream_clouds.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Chat(
          messages: _messages,
          onSendPressed: _handleSendPressed,
          user: _user,
          showUserAvatars: true,
          showUserNames: true,
          theme: DefaultChatTheme(
            backgroundColor: Colors.transparent, // Chat background
            primaryColor: Colors.lightBlue[800]!, // Send button color
            inputBackgroundColor: Colors.white.withOpacity(0.8), // Input field background
            inputTextColor: Colors.black87, // Input text color
            inputBorderRadius: BorderRadius.circular(25.0), // Input field border radius
          ),
        ),
      ),
    );
  }



  void _handleAttachmentPressed() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.any);
    if (result != null && result.files.isNotEmpty) {
      final filePath = result.files.single.path!;
      final fileExtension = filePath.split('.').last.toLowerCase();

      switch (fileExtension) {
        case 'jpg':
        case 'jpeg':
        case 'png':
          _handleImageAttachment(filePath);
          break;
        case 'pdf':
          _handlePdfAttachment(filePath);
          break;
        default:
          _handleOtherAttachment(filePath);
          break;
      }
    }
  }

  void _handleImageAttachment(String filePath) {
  final file = File(filePath);
  final message = types.ImageMessage(
    author: _user,
    createdAt: DateTime.now().millisecondsSinceEpoch,
    id: const Uuid().v4(),
    name: filePath.split('/').last,
    size: file.lengthSync(), // Calculate the size of the image file
    uri: filePath,
  );

  _addMessage(message);
}


  void _handlePdfAttachment(String filePath) {
    final message = types.FileMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      mimeType: 'application/pdf',
      name: filePath.split('/').last,
      size: File(filePath).lengthSync(),
      uri: filePath,
    );

    _addMessage(message);
  }

  void _handleOtherAttachment(String filePath) {
    final message = types.FileMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      mimeType: lookupMimeType(filePath),
      name: filePath.split('/').last,
      size: File(filePath).lengthSync(),
      uri: filePath,
    );

    _addMessage(message);
  }
  
  lookupMimeType(String filePath) {}
  
  void showDeleteConfirmation(BuildContext context, String messageId) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Delete Message"),
        content: const Text("Are you sure you want to delete this message?"),
        actions: [
          TextButton(
            child: const Text("Cancel"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text("Delete"),
            onPressed: () {
              deleteMessage(messageId);
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

  Future<void> deleteMessage(String messageId) async {
  await FirebaseFirestore.instance.collection('public_messages').doc(messageId).delete();
}


}
