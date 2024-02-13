import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:legalite/widgets/cdrawer_widget.dart';

// class Home extends StatefulWidget {
//   const Home({super.key});

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   final padding = const EdgeInsets.symmetric(horizontal: 20);
//   String user = FirebaseAuth.instance.currentUser!.uid;
//   @override
//   Widget build(BuildContext context) {
//     // const urlImage =
//     //     "https://www.shutterstock.com/image-photo/photo-words-wooden-block-objects-arranged-2364889927";
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Home'),
//       ),
//       drawer: const MyDrawer(),
//     );
//   }
// }

// import 'package:legalite/widgets/drawer_widget.dart';

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
    // const urlImage =
    //     "https://www.shutterstock.com/image-photo/photo-words-wooden-block-objects-arranged-2364889927";
    String user = FirebaseAuth.instance.currentUser!.uid;

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
        drawer: const MyDrawer());
  }
}
