import 'package:flutter/material.dart';
// import 'package:legalite/Lpages/ClientScreen.dart';
// import 'package:legalite/Lpages/HomeScreen.dart';
// import 'package:legalite/Lpages/ProfileScreen.dart';

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
                    child: const Row(
                      children: [
                        CircleAvatar(
                            radius: 30,
                            backgroundImage: AssetImage('lib/static/idk.jpg')),
                        Column(
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
                              Text("indigo_1008",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white70)),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                "View profile",
                                style: TextStyle(fontSize: 14),
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
                Navigator.pushNamed(context, '/lclient');
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
