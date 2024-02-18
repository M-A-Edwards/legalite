import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:legalite/Lpages/Chat.dart';
import 'package:legalite/widgets/drawer_widget.dart';
// import 'package:flutter/rendering.dart';
// import 'package:legalite/widgets/drawer_widget.dart';

class ChatPeople extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ChatPeople")),
      body: AvailableClientsList(),
      drawer: const MyDrawer(),
    );
  }
}

class AvailableClientsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('lawyers').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          List<DocumentSnapshot> clients = snapshot.data!.docs;
          debugPrint('data data: $clients');

          return ListView.builder(
            itemCount: clients.length,
            itemBuilder: (context, index) {
              String clientId = clients[index].id;
              Map<String, dynamic> clientData =
                  clients[index].data() as Map<String, dynamic>;
              debugPrint('client data: $clientData');
              String clientName = clientData['Name'];
              return ListTile(
                title: Text(clientName),
                onTap: () {
                  Navigator.pushNamed(context, '/chat',
                      arguments: [clientId, clientName]);
                },
              );
            },
          );
        });
  }
}
