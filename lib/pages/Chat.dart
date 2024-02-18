import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:intl_utils/intl_utils.dart';

// class ChatPage extends StatefulWidget {
//   @override
//   _ChatPageState createState() => _ChatPageState();
// }

// class _ChatPageState extends State<ChatPage> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final TextEditingController _messageController = TextEditingController();

//   User? _user;

//   @override
//   void initState() {
//     super.initState();
//     _user = _auth.currentUser;
//   }

//   void _sendMessage() async {
//     String messageText = _messageController.text.trim();
//     if (messageText.isNotEmpty) {
//       await _firestore.collection('messages').add({
//         'text': messageText,
//         'senderId': _user!.uid,
//         'recipientId': ModalRoute.of(context as BuildContext)!
//             .settings
//             .arguments as String,
//         'timestamp': Timestamp.now(),
//       });
//       _messageController.clear();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Chat Page'),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: StreamBuilder<QuerySnapshot>(
//               stream: _firestore
//                   .collection('messages')
//                   .where('senderId', isEqualTo: _user!.uid)
//                   .where('recipientId',
//                       isEqualTo:
//                           ModalRoute.of(context)!.settings.arguments as String)
//                   .orderBy('timestamp')
//                   .snapshots(),
//               builder: (context, snapshot) {
//                 if (!snapshot.hasData) {
//                   return Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 }
//                 List<DocumentSnapshot> messages = snapshot.data!.docs;

//                 return ListView.builder(
//                   itemCount: messages.length,
//                   itemBuilder: (context, index) {
//                     Map<String, dynamic> data =
//                         messages[index].data() as Map<String, dynamic>;
//                     return ListTile(
//                       title: Text(data['text']),
//                       subtitle: Text(data['senderId']),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _messageController,
//                     decoration: InputDecoration(hintText: 'Type a message...'),
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.send),
//                   onPressed: _sendMessage,
//                 ),
//               ],
//             ),
//           ),
//         ],class ChatPage extends StatefulWidget {
//   @override
//   _ChatPageState createState() => _ChatPageState();
// }

// class _ChatPageState extends State<ChatPage> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final TextEditingController _messageController = TextEditingController();

//   User? _user;

//   @override
//   void initState() {
//     super.initState();
//     _user = _auth.currentUser;
//   }

//   void _sendMessage() async {
//     String messageText = _messageController.text.trim();
//     if (messageText.isNotEmpty) {
//       await _firestore.collection('messages').add({
//         'text': messageText,
//         'senderId': _user!.uid,
//         'recipientId': ModalRoute.of(context as BuildContext)!
//             .settings
//             .arguments as String,
//         'timestamp': Timestamp.now(),
//       });
//       _messageController.clear();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Chat Page'),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: StreamBuilder<QuerySnapshot>(
//               stream: _firestore
//                   .collection('messages')
//                   .where('senderId', isEqualTo: _user!.uid)
//                   .where('recipientId',
//                       isEqualTo:
//                           ModalRoute.of(context)!.settings.arguments as String)
//                   .orderBy('timestamp')
//                   .snapshots(),
//               builder: (context, snapshot) {
//                 if (!snapshot.hasData) {
//                   return Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 }
//                 List<DocumentSnapshot> messages = snapshot.data!.docs;

//                 return ListView.builder(
//                   itemCount: messages.length,
//                   itemBuilder: (context, index) {
//                     Map<String, dynamic> data =
//                         messages[index].data() as Map<String, dynamic>;
//                     return ListTile(
//                       title: Text(data['text']),
//                       subtitle: Text(data['senderId']),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _messageController,
//                     decoration: InputDecoration(hintText: 'Type a message...'),
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.send),
//                   onPressed: _sendMessage,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

//       ),
//     );
//   }
// }
var url = 'https://i.imgur.com/gGSj8Ng.png';
var urlTwo = 'https://i.imgur.com/ub680tN.png';

class ChatModel {
  final String _messages;
  final bool _isMe;

  ChatModel(this._messages, this._isMe);

  String get message => _messages;

  bool get isMee => _isMe;
}

List<ChatModel> chatModelList = [];

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  MyChatUIState createState() => MyChatUIState();
}

class MyChatUIState extends State<ChatPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? _user;

  var controller = TextEditingController();
  var scrollController = ScrollController();
  var message = '';

  void animateList() {
    scrollController.jumpTo(scrollController.position.maxScrollExtent);
    Future.delayed(const Duration(milliseconds: 100), () {
      if (scrollController.offset !=
          scrollController.position.maxScrollExtent) {
        animateList();
      }
    });
  }

  @override
  //   @override
  void initState() {
    super.initState();
    _user = _auth.currentUser;
  }

  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as List;
    final clientId = args[0] as String; // Assuming clientId is an integer
    final senderName = args[1] as String;
    void sendMessage() async {
      String messageText = controller.text.trim();
      debugPrint("inside send message, message text: $messageText");
      if (messageText.isNotEmpty) {
        await _firestore.collection('messages').add({
          'text': messageText,
          'senderId': _user!.uid,
          'recipientId': clientId,
          'timestamp': Timestamp.now(),
        });
      }
    }

    return Scaffold(
      backgroundColor: Color.fromRGBO(245, 245, 243, 1),
      appBar: AppBar(
        elevation: 12,
        titleSpacing: 10,
        backgroundColor: const Color(0xffD11C2D),
        toolbarHeight: 65,
        // leading: GestureDetector(
        //   onTap: () {
        //     Navigator.pop(context);
        //     debugPrint("works");
        //   },
        //   child: const Padding(
        //     padding: EdgeInsets.all(8.0),
        //     child: Icon(
        //       Icons.arrow_back_ios_sharp,
        //       color: Colors.white,
        //     ),
        //   ),
        // ),
        // leadingWidth: 20,
        title: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(url),
          ),
          title: Text(
            senderName,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          subtitle: const Text(
            'online',
            style: TextStyle(color: Colors.white),
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: Icon(Icons.videocam_rounded),
          ),
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: Icon(Icons.call),
          ),
        ],
      ),
      body: Column(
        children: [
          Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: StreamBuilder<QuerySnapshot>(
                stream: _firestore
                    .collection('messages')
                    .where('senderId', isEqualTo: _user!.uid)
                    .where('recipientId', isEqualTo: clientId as String)
                    .orderBy('timestamp')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  List<DocumentSnapshot> senderMessages = snapshot.data!.docs;

                  return StreamBuilder<QuerySnapshot>(
                    stream: _firestore
                        .collection('messages')
                        .where('recipientId', isEqualTo: _user!.uid)
                        .where('senderId', isEqualTo: clientId as String)
                        .orderBy('timestamp')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      List<DocumentSnapshot> recipientMessages =
                          snapshot.data!.docs;

                      // Combine sender and recipient messages
                      List<DocumentSnapshot> allMessages = [];
                      allMessages.addAll(senderMessages);
                      allMessages.addAll(recipientMessages);

                      // Sort messages by timestamp
                      allMessages.sort(
                          (a, b) => a['timestamp'].compareTo(b['timestamp']));

                      return ListView.builder(
                        controller: scrollController,
                        physics: const BouncingScrollPhysics(),
                        itemCount: allMessages.length,
                        itemBuilder: (context, index) {
                          Map<String, dynamic> data =
                              allMessages[index].data() as Map<String, dynamic>;
                          debugPrint(data["text"]);
                          if (data["senderId"] != clientId) {
                            return ListTile(
                              leading: Container(
                                width: 50,
                              ),
                              visualDensity: VisualDensity.comfortable,
                              title:
                                  Wrap(alignment: WrapAlignment.end, children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      color: Color(0xffD11C2D),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  child: Text(
                                    data['text'],
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(color: Colors.white),
                                    softWrap: true,
                                  ),
                                ),
                              ]),
                              subtitle: Padding(
                                padding: EdgeInsets.only(right: 8, top: 4),
                                child: Text(
                                  formatRelativeTime(data["timestamp"]),
                                  textAlign: TextAlign.right,
                                  style: TextStyle(fontSize: 10),
                                ),
                              ),
                              trailing: CircleAvatar(
                                backgroundImage: NetworkImage(urlTwo),
                              ),
                            );
                          } else {
                            return ListTile(
                              leading: Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(url),
                                ),
                              ),
                              title: Wrap(children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  child: Text(
                                    data['text'],
                                    style: const TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ]),
                              trailing: Container(
                                width: 50,
                              ),
                              subtitle: Padding(
                                padding: EdgeInsets.only(left: 8, top: 4),
                                child: Text(
                                    formatRelativeTime(data["timestamp"]),
                                    style: TextStyle(fontSize: 10)),
                              ),
                            );
                          }
                        },
                      );
                    },
                  );
                },
              )
              // StreamBuilder<QuerySnapshot>(
//                   stream: _firestore
//                       .collection('messages')
//                       .where('senderId', isEqualTo: _user!.uid)
//                       .where('recipientId', isEqualTo: clientId as String)
//                       .orderBy('timestamp')
//                       .snapshots(),
//                   builder: (context, snapshot) {
//                     if (!snapshot.hasData) {
//                       return Center(
//                         child: CircularProgressIndicator(),
//                       );
//                     }
//                     List<DocumentSnapshot> messages = snapshot.data!.docs;

// //                 return ListView.builder(
// //                   itemCount: messages.length,
// //                   itemBuilder: (context, index) {
// //                     Map<String, dynamic> data =
// //                         messages[index].data() as Map<String, dynamic>;
// //                     return ListTile(
// //                       title: Text(data['text']),
// //                       subtitle: Text(data['senderId']),
// //                     );
// //                   },
// //                 );
// //               },
// //             ),
//                     return ListView.builder(
//                         controller: scrollController,
//                         physics: const BouncingScrollPhysics(),
//                         itemCount: messages.length,
//                         itemBuilder: (context, index) {
//                           Map<String, dynamic> data =
//                               messages[index].data() as Map<String, dynamic>;
//                           debugPrint(data["text"]);
//                           if (data["senderId"] == clientId) {
//                             return ListTile(
//                               leading: Container(
//                                 width: 50,
//                               ),
//                               visualDensity: VisualDensity.comfortable,
//                               title:
//                                   Wrap(alignment: WrapAlignment.end, children: [
//                                 Container(
//                                   padding: const EdgeInsets.all(10),
//                                   decoration: const BoxDecoration(
//                                       shape: BoxShape.rectangle,
//                                       color: Color(0xffD11C2D),
//                                       borderRadius: BorderRadius.all(
//                                           Radius.circular(20))),
//                                   child: Text(
//                                     data['text'],
//                                     textAlign: TextAlign.left,
//                                     style: const TextStyle(color: Colors.white),
//                                     softWrap: true,
//                                   ),
//                                 ),
//                               ]),
//                               subtitle: const Padding(
//                                 padding: EdgeInsets.only(right: 8, top: 4),
//                                 child: Text(
//                                   '10:03 AM',
//                                   textAlign: TextAlign.right,
//                                   style: TextStyle(fontSize: 10),
//                                 ),
//                               ),
//                               trailing: CircleAvatar(
//                                 backgroundImage: NetworkImage(urlTwo),
//                               ),
//                             );
//                           } else {
//                             return ListTile(
//                               leading: Padding(
//                                 padding: const EdgeInsets.only(bottom: 10),
//                                 child: CircleAvatar(
//                                   backgroundImage: NetworkImage(url),
//                                 ),
//                               ),
//                               title: Wrap(children: [
//                                 Container(
//                                   padding: const EdgeInsets.all(10),
//                                   decoration: const BoxDecoration(
//                                       shape: BoxShape.rectangle,
//                                       color: Colors.white,
//                                       borderRadius: BorderRadius.all(
//                                           Radius.circular(20))),
//                                   child: Text(
//                                     data['text'],
//                                     style: const TextStyle(
//                                       color: Colors.black,
//                                     ),
//                                   ),
//                                 ),
//                               ]),
//                               trailing: Container(
//                                 width: 50,
//                               ),
//                               subtitle: const Padding(
//                                 padding: EdgeInsets.only(left: 8, top: 4),
//                                 child: Text('8:04 AM',
//                                     style: TextStyle(fontSize: 10)),
//                               ),
//                             );
//                           }
//                         });
//                   }
//                   )
              ),
          Container(
            alignment: Alignment.center,
            color: Colors.white,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 12.0, left: 8),
                  child: Icon(
                    Icons.emoji_emotions_outlined,
                    color: Color(0xffD11C2D),
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    maxLines: 6,
                    minLines: 1,
                    keyboardType: TextInputType.multiline,
                    controller: controller,
                    onFieldSubmitted: (value) {
                      controller.text = value;
                    },
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(left: 8),
                      border: InputBorder.none,
                      focusColor: Colors.white,
                      hintText: 'Type a message',
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // chatModelList.add(ChatModel(controller.text, true));
                    sendMessage();
                    animateList();
                    controller.clear();
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(bottom: 8, right: 8),
                    child: CircleAvatar(
                      backgroundColor: Color(0xffD11C2D),
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  String formatRelativeTime(Timestamp timestamp) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);

    final dateTime = timestamp.toDate(); // Convert Timestamp to DateTime

    if (dateTime.year == now.year &&
        dateTime.month == now.month &&
        dateTime.day == now.day) {
      return DateFormat.jm().format(dateTime); // Today
    } else if (dateTime.year == yesterday.year &&
        dateTime.month == yesterday.month &&
        dateTime.day == yesterday.day) {
      return "Yesterday at ${DateFormat.jm().format(dateTime)}"; // Yesterday
    } else {
      return DateFormat('MMMM d').format(dateTime) +
          " at ${DateFormat.jm().format(dateTime)}"; // Other days
    }
  }
}
