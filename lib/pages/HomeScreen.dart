import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final padding = const EdgeInsets.symmetric(horizontal: 20);
  @override
  Widget build(BuildContext context) {
    const name = "indigo_1008";
    // const urlImage =
    //     "https://www.shutterstock.com/image-photo/photo-words-wooden-block-objects-arranged-2364889927";
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      drawer: Drawer(
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
                              backgroundImage:
                                  AssetImage('lib/static/idk.jpg')),
                          Column(
                            children: [
                              SizedBox(
                                height: 10,
                              )
                            ],
                          ),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(name,
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white70)),
                                SizedBox(
                                  height: 4,
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
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.manage_accounts_outlined,
                    color: Colors.white54),
                title: const Text('Profile',
                    style: TextStyle(fontSize: 14, color: Colors.white70)),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.people_outline_outlined,
                    color: Colors.white54),
                title: const Text('Clients',
                    style: TextStyle(fontSize: 14, color: Colors.white70)),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
