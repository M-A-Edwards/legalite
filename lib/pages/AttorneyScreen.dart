import 'package:flutter/material.dart';
import 'package:legalite/widgets/cdrawer_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Attorneys extends StatefulWidget {
  const Attorneys({super.key});

  @override
  State<Attorneys> createState() => _AttorneysState();
}

class _AttorneysState extends State<Attorneys> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Attorneys"),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('lawyers').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            List<DocumentSnapshot> lawyer = snapshot.data!.docs;
            return ListView.builder(
              itemCount: lawyer.length,
              itemBuilder: (context, index) {
                String lawyerId = lawyer[index].id;
                Map<String, dynamic> lawyerData =
                    lawyer[index].data() as Map<String, dynamic>;
                debugPrint('lawyer data: $lawyerData');
                String lawyerName = lawyerData['Name'];
                return ListTile(
                  title: Text(lawyerName),
                );
              },
            );
          },
        ),
        drawer: const MyDrawer());
  }
}
