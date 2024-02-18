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
            List<DocumentSnapshot> client = snapshot.data!.docs;
            return ListView.builder(
              itemCount: client.length,
              itemBuilder: (context, index) {
                String clientId = client[index].id;
                Map<String, dynamic> clientData =
                    client[index].data() as Map<String, dynamic>;
                debugPrint('client data: $clientData');
                String clientName = clientData['Name'];
                String clientDesc = clientData['Desc'];
                String clientEmail = clientData['Email'];
                return ListTile(
                  title: Text(clientName),
                  subtitle: Text('$clientDesc - Hyderabad'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LawyerDetails(
                              lawyerName: clientName,
                              lawyerDesc: clientDesc,
                              lawyerEmail: clientEmail,
                              lawyerId: clientId)),
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

class LawyerDetails extends StatelessWidget {
  final String lawyerName;
  final String lawyerDesc;
  final String lawyerEmail;
  final String lawyerId;

  LawyerDetails({
    required this.lawyerName,
    required this.lawyerDesc,
    required this.lawyerEmail,
    required this.lawyerId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lawyer Details'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: Icon(Icons.person, size: 40, color: Colors.blue),
              title: Text(
                lawyerName,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 16),
            ListTile(
              leading: Icon(Icons.description, size: 40, color: Colors.blue),
              title: Text(
                'Specialty:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                lawyerDesc,
                style: TextStyle(fontSize: 16),
              ),
            ),
            ListTile(
              leading: Icon(Icons.location_on, size: 40, color: Colors.blue),
              title: Text(
                'Location:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'Hyderabad',
                style: TextStyle(fontSize: 16),
              ),
            ),
            ListTile(
              leading: Icon(Icons.school, size: 40, color: Colors.blue),
              title: Text(
                'Education:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'AIIMS Delhi',
                style: TextStyle(fontSize: 16),
              ),
            ),
            ListTile(
              leading: Icon(Icons.work, size: 40, color: Colors.blue),
              title: Text(
                'Experience:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                '8 years',
                style: TextStyle(fontSize: 16),
              ),
            ),
            ListTile(
              leading: Icon(Icons.email, size: 40, color: Colors.blue),
              title: Text(
                'Email:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                lawyerEmail,
                style: TextStyle(fontSize: 16),
              ),
            ),
            ListTile(
              leading: Icon(Icons.phone, size: 40, color: Colors.blue),
              title: Text(
                'Phone:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                '9550151038',
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(
              height: 18,
            ),
            Center(
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/chat',
                          arguments: [lawyerId, lawyerName]);
                    },
                    child: Text("Chat")))
            // Add more details as needed
          ],
        ),
      ),
    );
  }
}
