import 'package:flutter/material.dart';
import 'package:legalite/widgets/cdrawer_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Attorneys extends StatefulWidget {
  const Attorneys({Key? key}) : super(key: key);

  @override
  State<Attorneys> createState() => _AttorneysState();
}

class _AttorneysState extends State<Attorneys> {
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Attorneys"),
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
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('lawyers').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                List<DocumentSnapshot> clients = snapshot.data!.docs;
                List<DocumentSnapshot> filteredClients = clients.where((client) {
                  String clientName = client['Name'].toString().toLowerCase();
                  String searchTerm = _searchController.text.toLowerCase();
                  return clientName.contains(searchTerm);
                }).toList();
                return ListView.builder(
                  itemCount: filteredClients.length,
                  itemBuilder: (context, index) {
                    String clientId = filteredClients[index].id;
                    Map<String, dynamic> clientData = filteredClients[index].data() as Map<String, dynamic>;
                    String clientName = clientData['Name'];
                    String clientDesc = clientData['Desc'];
                    String clientEmail = clientData['Email'];
                    String clientLoc = (clientData['Location'] != null) ? clientData['Location'] : '<None>';
                    String clientnum = (clientData['Phone Number'] != null) ? clientData['Phone Number'] : '<None>';
                    String clientEdu = (clientData['Education'] != null) ? clientData['Education'] : '<None>';
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
                              lawyerLoc: clientLoc,
                              lawyernum: clientnum,
                              lawyerEdu: clientEdu,
                              lawyerId: clientId,
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      drawer: const MyDrawer(),
    );
  }
}

class LawyerDetails extends StatelessWidget {
  final String lawyerName;
  final String lawyerDesc;
  final String lawyerEmail;
  final String lawyerLoc;
  final String lawyernum;
  final String lawyerEdu;
  final String lawyerId;

  LawyerDetails({
    required this.lawyerName,
    required this.lawyerDesc,
    required this.lawyerEmail,
    required this.lawyerLoc,
    required this.lawyernum,
    required this.lawyerEdu,
    required this.lawyerId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lawyer Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: const Icon(Icons.person, size: 40, color: Colors.blue),
              title: Text(
                lawyerName,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.description, size: 40, color: Colors.blue),
              title: const Text(
                'Specialty:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                lawyerDesc,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.location_on, size: 40, color: Colors.blue),
              title: const Text(
                'Location:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                lawyerLoc,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.school, size: 40, color: Colors.blue),
              title: const Text(
                'Education:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                lawyerEdu,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            const ListTile(
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
              leading: const Icon(Icons.email, size: 40, color: Colors.blue),
              title: const Text(
                'Email:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                lawyerEmail,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.phone, size: 40, color: Colors.blue),
              title: const Text(
                'Phone:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                lawyernum,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(
              height: 18,
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/chat', arguments: [lawyerId, lawyerName]);
                },
                child: const Text("Chat"),
              ),
            )
            // Add more details as needed
          ],
        ),
      ),
    );
  }
}
