// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:legalite/widgets/chatbot.dart';
import 'package:legalite/widgets/cdrawer_widget.dart';

class Case {
  final String title;
  final String description;
  final DateTime date;

  Case(this.title, this.description, this.date);
}

class Home extends StatelessWidget {
  final List<Case> curentCases = [
    Case("Saad vs Mark", "Mark's prison sentence", DateTime.now()),
    Case("Harini vs Saad", "Harini coping in the corner of her room",
        DateTime.now()),
  ];
  final pastCases = [
    Case("Saad vs Mark", "Mark's prison sentence", DateTime.now()),
    Case("Harini vs Saad", "Harini coping in the corner of her room",
        DateTime.now()),
  ];
  @override
  Widget build(BuildContext context) {
    // String user = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
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
            )
          ],
        ),
      ),
      drawer: const MyDrawer(),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 16.0, bottom: 16.0),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ChatScreen()),
            );
          },
          child: const Icon(Icons.chat),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
