import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:legalite/widgets/drawer_widget.dart';

class LChatPeople extends StatefulWidget {
  @override
  _ChatList createState() => _ChatList();
}

class _ChatList extends State<LChatPeople> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? _user;

  List<DocumentSnapshot> chatUsers = [];
  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser;
    fetchChatData();
  }

  void fetchChatData() async {
    final messagesref = _firestore.collection("messages");

    final messagesRSnapshot =
        await messagesref.where("recipientId", isEqualTo: _user!.uid).get();
    final messagesSSnapshot =
        await messagesref.where("senderId", isEqualTo: _user!.uid).get();
    List allmessages = [...messagesRSnapshot.docs, ...messagesSSnapshot.docs];

    Set<String> chatUserIds = <String>{};
    allmessages.forEach((messageDoc) {
      Map<String, dynamic> messageData =
          messageDoc.data() as Map<String, dynamic>;
      String senderId = messageData['senderId'];
      String recipientId = messageData['recipientId'];
      debugPrint("sender id: ${senderId} reciepeintId: ${recipientId}");
      if (senderId != _user!.uid) {
        chatUserIds.add(senderId);
      }
      if (recipientId != _user!.uid) {
        chatUserIds.add(recipientId);
      }
    });

    final profilesCollection = _firestore.collection("clients");
    for (String userId in chatUserIds) {
      debugPrint("userId: $userId");
      DocumentSnapshot userSnapshot =
          await profilesCollection.doc(userId).get();
      if (userSnapshot.exists) {
        debugPrint("id found it is: ${userSnapshot.id}");
        chatUsers.add(userSnapshot);
      } else {
        debugPrint("shiz not exist onli naaaa");
      }
    }
    setState(() {
      // Update the state variables here if needed
    });
  }

  Widget build(BuildContext context) {
    if (chatUsers.isEmpty || chatUsers == []) {
      return Scaffold(
          drawer: const MyDrawer(),
          appBar: AppBar(
            title: Text("Chats"),
          ),
          body: Center(
            child: CircularProgressIndicator(),
          ));
    } else {
      return Scaffold(
        drawer: const MyDrawer(),
        appBar: AppBar(
          title: Text("Chats"),
        ),
        body: ListView.builder(
          itemCount: chatUsers.length,
          itemBuilder: (context, index) {
            final userId = chatUsers[index].id;
            debugPrint("user: ${chatUsers[index].data()} userid: ${userId}");
            Map<String, dynamic> user =
                chatUsers[index].data() as Map<String, dynamic>;

            return ListTile(
              leading: CircleAvatar(
                child: Text(user["Name"][0]),
              ),
              title: Text(user["Name"]),
              onTap: () {
                Navigator.pushNamed(context, '/lchat',
                    arguments: [userId, user["Name"]]);
              },
            );
          },
        ),
      );
    }
  }
}
