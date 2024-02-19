import 'package:flutter/material.dart';

class Case {
  final String title;
  final String description;
  final DateTime date;

  Case(this.title, this.description, this.date);
}

class Cases extends StatelessWidget {
  final List<Case> allCases = [
    Case("Saad vs Mark", "Mark's prison sentence", DateTime.now()),
    Case("Harini vs Saad", "Harini coping in the corner of her room",
        DateTime.now()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Cases'),
      ),
      body: ListView.builder(
        itemCount: allCases.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              title: Text(allCases[index].title),
              subtitle: Text(
                '${allCases[index].description}\nDate: ${allCases[index].date}',
              ),
            ),
          );
        },
      ),
    );
  }
}
