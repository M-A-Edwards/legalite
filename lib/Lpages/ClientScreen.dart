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
          title: const Text("clients"),
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
                String clientId = client[index].id;
                Map<String, dynamic> clientData =
                    client[index].data() as Map<String, dynamic>;
                debugPrint('client data: $clientData');
                String clientName = clientData['Name'];
                return ListTile(
                  title: Text(clientName),
                  subtitle: Text('Hyderabad'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => clientDetails(
                              clientName: clientName, clientId: clientId)),
                    );
                  },
                );
              },
            );
          },
        ),
        drawer: const MyDrawer());
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
              "Current cases",
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
              "Past cases",
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
      drawer: const MyDrawer(),
    );
  }
}
