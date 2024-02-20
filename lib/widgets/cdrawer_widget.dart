import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:legalite/Lpages/ClientScreen.dart';
// import 'package:legalite/Lpages/HomeScreen.dart';
// import 'package:legalite/Lpages/ProfileScreen.dart';
import 'package:flutter/gestures.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: const Color.fromARGB(255, 12, 15, 8),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: 200,
              child: DrawerHeader(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 101, 121, 138),
                ),
                child: InkWell(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(
                              'https://hips.hearstapps.com/hmg-prod/images/beautiful-smooth-haired-red-cat-lies-on-the-sofa-royalty-free-image-1678488026.jpg'),
                          // backgroundImage: AssetImage('lib/static/idk.jpg')),
                        ),
                        const Column(
                          children: [
                            SizedBox(
                              width: 10,
                            )
                          ],
                        ),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              StreamBuilder<DocumentSnapshot>(
                                  stream: FirebaseFirestore.instance
                                      .collection('clients')
                                      .doc(FirebaseAuth
                                          .instance.currentUser!.uid)
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    } else if (snapshot.hasError) {
                                      return const Center(
                                          child: Text("Something went wrong!"));
                                    } else if (snapshot.hasData &&
                                        snapshot.data != null) {
                                      DocumentSnapshot dat = snapshot.data!;
                                      return Text(
                                        dat['Name'],
                                        style: const TextStyle(
                                            fontSize: 20,
                                            color: Colors.white70),
                                      );
                                    } else {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                  }),
                              // Text("indigo_1008",
                              //     style: TextStyle(
                              //         fontSize: 20, color: Colors.white70)),
                              const SizedBox(
                                width: 4,
                              ),
                              RichText(
                                text: TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.pushNamed(context, '/profile');
                                    },
                                  text: 'View Profile',
                                  style: const TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Colors.black),
                                ),
                              )
                            ])
                      ],
                    ),
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(
                IconData(0xe318, fontFamily: 'MaterialIcons'),
                color: Colors.white54,
              ),
              title: const Text('Home',
                  style: TextStyle(fontSize: 14, color: Colors.white70)),
              onTap: () {
                Navigator.pushNamed(context, '/home');
                // Navigator.of(context).push(
                //     MaterialPageRoute(builder: (context) => const Home()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.manage_accounts_outlined,
                  color: Colors.white54),
              title: const Text('Profile',
                  style: TextStyle(fontSize: 14, color: Colors.white70)),
              onTap: () {
                // Navigator.pop(context);
                Navigator.pushNamed(context, '/profile');
                // Navigator.of(context).push(
                //     MaterialPageRoute(builder: (context) => const Profile()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.people_outline_outlined,
                  color: Colors.white54),
              title: const Text('Lawyers',
                  style: TextStyle(fontSize: 14, color: Colors.white70)),
              onTap: () {
                Navigator.pushNamed(context, '/lawyer');
                // Navigator.of(context).push(
                //     MaterialPageRoute(builder: (context) => const Clients()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.balance_sharp, color: Colors.white54),
              title: const Text('Legal Aid',
                  style: TextStyle(fontSize: 14, color: Colors.white70)),
              onTap: () {
                Navigator.pushNamed(context, '/legalaid');
                // Navigator.of(context).push(
                //     MaterialPageRoute(builder: (context) => const Clients()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.balance_sharp, color: Colors.white54),
              title: const Text('Chat',
                  style: TextStyle(fontSize: 14, color: Colors.white70)),
              onTap: () {
                Navigator.pushNamed(context, '/chatpeople');
                // Navigator.of(context).push(
                //     MaterialPageRoute(builder: (context) => const Clients()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
