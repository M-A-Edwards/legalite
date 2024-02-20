import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:legalite/widgets/drawer_widget.dart';

class Clients extends StatefulWidget {
  const Clients({super.key});

  @override
  State<Clients> createState() => _ClientsState();
}

class _ClientsState extends State<Clients> {
  late TextEditingController _searchController;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? _user;
  List<DocumentSnapshot> chatUsers = [];

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser;

    _searchController = TextEditingController();
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
    List<DocumentSnapshot> filteredClients = chatUsers.where((client) {
      String clientName = client['Name'].toString().toLowerCase();
      String searchTerm = _searchController.text.toLowerCase();
      return clientName.contains(searchTerm);
    }).toList();

    if (chatUsers.isEmpty || chatUsers == []) {
      return Scaffold(
          drawer: const MyDrawer(),
          appBar: AppBar(
            title: const Text("My Clients"),
          ),
          body: const Center(
            child: CircularProgressIndicator(),
          ));
    } else {
      return Scaffold(
          appBar: AppBar(
            title: const Text("My Clients"),
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _searchController,
                  decoration: const InputDecoration(
                    labelText: 'Search',
                    prefixIcon: Icon(Icons.search),
                  ),
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: filteredClients.length,
                  itemBuilder: (context, index) {
                    String clientId = filteredClients[index].id;
                    Map<String, dynamic> clientData =
                        filteredClients[index].data() as Map<String, dynamic>;
                    String clientName = clientData['Name'];

                    return ListTile(
                      title: Text(clientName),
                      subtitle: Text('Hyderabad'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => clientDetails(
                              clientName: clientName,
                              clientId: clientId,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
          drawer: const MyDrawer());
    }
  }
}

class Case {
  final String title;
  final String description;
  final DateTime date;

  Case(this.title, this.description, this.date);
}

class clientDetails extends StatelessWidget {
  final String clientName;

  final String clientId;

  clientDetails({
    required this.clientName,
    required this.clientId,
  });

  final List<Case> curentCases = [
    Case("Final verdict for case no #14421",
        "Verdict to be given at virichi courthouse", DateTime.now()),
    Case(
        "Hearing for case no #14421",
        "Hearing for case no #14421 at Hyderabad District Court",
        DateTime.now()),
  ];
  final pastCases = [
    Case("Preliminary hearing", "Preliminary hearing for case no #14421",
        DateTime.now()),
    Case("registeration for case no #14421",
        "registeration deadline for case no #14421", DateTime.now()),
  ];
  @override
  Widget build(BuildContext context) {
    // String user = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(
        title: Text('$clientName\'s events'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Future",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Column(
              children: curentCases
                  .map((e) => Card(
                        child: ListTile(
                          title: Text(e.title),
                          subtitle: Text('${e.description}\nDate: ${e.date}'),
                        ),
                      ))
                  .toList(),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () => {Navigator.pushNamed(context, '/lallCases')},
                child: const Text('Show More'),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Past",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Column(
              children: pastCases
                  .map((e) => Card(
                        child: ListTile(
                          title: Text(e.title),
                          subtitle: Text('${e.description}\nDate: ${e.date}'),
                        ),
                      ))
                  .toList(),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () => {Navigator.pushNamed(context, '/lallCases')},
                child: const Text('Show More'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
