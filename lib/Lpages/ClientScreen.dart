import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:legalite/widgets/drawer_widget.dart';

class Clients extends StatefulWidget {
  const Clients({super.key});

  @override
  State<Clients> createState() => _ClientsState();
}

class _ClientsState extends State<Clients> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Clients"),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('clients').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            List<DocumentSnapshot> client = snapshot.data!.docs;
            return ListView.builder(
              itemCount: client.length,
              itemBuilder: (context, index) {
                // String clientId = client[index].id;
                Map<String, dynamic> clientData =
                    client[index].data() as Map<String, dynamic>;
                debugPrint('client data: $clientData');
                String clientName = clientData['Name'];
                return ListTile(
                  title: Text(clientName),
                );
              },
            );
          },
        ),
        drawer: const MyDrawer());
  }
}
