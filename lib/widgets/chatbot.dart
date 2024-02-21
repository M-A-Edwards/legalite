import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  List<String> messages = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  Future<void> _sendMessage(String message) async {
    setState(() {
      messages.add('You: $message');
      _scrollToBottom();
    });

    FirebaseFirestore firestore = FirebaseFirestore.instance;
    String uid = FirebaseAuth.instance.currentUser!.uid;
    DocumentReference documentReference =
    firestore.collection('clients').doc(uid);

    CollectionReference subcollectionReference =
    documentReference.collection('chatbot');

    DocumentReference specificDocumentReference =
    subcollectionReference.doc();

    await specificDocumentReference.set({'prompt': message});

    await specificDocumentReference.snapshots().firstWhere((snapshot) {
      var data = snapshot.data() as Map<String, dynamic>;
      var status = data['status'] as Map<String, dynamic>?;

      return status != null && status['state'] == 'COMPLETED';
    });

    var updatedSnapshot =
    await specificDocumentReference.get();
    var responseData = updatedSnapshot.data() as Map<String, dynamic>;
    String response = responseData['response'] ?? '';
    setState(() {
      messages.add('Law Bot: $response');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Law Bot'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 4.0, horizontal: 8.0),
                  child: Align(
                    alignment: messages[index].startsWith('You:')
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      decoration: BoxDecoration(
                        color: messages[index].startsWith('You:')
                            ? Colors.blue
                            : Colors.grey[300],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.all(12),
                      margin: const EdgeInsets.all(4),
                      child: Text(
                        messages[index],
                        style: TextStyle(
                          color: messages[index].startsWith('You:')
                              ? Colors.white
                              : Colors.black,
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
                      hintText: 'Enter your message...',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    String message = _controller.text;
                    if (message.isNotEmpty) {
                      _controller.clear();
                      _sendMessage(message);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
