import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:legalite/main.dart';
import 'package:legalite/widgets/drawer_widget.dart';

class LProfile extends StatefulWidget {
  const LProfile({super.key});

  @override
  State<LProfile> createState() => _LProfileState();
}

class _LProfileState extends State<LProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      drawer: const MyDrawer(),
      body: ListView(
        children: <Widget>[
          Container(
            height: 250,
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: Colors.teal,
                      minRadius: 65.0,
                      child: CircleAvatar(
                        radius: 60.0,
                        backgroundImage: NetworkImage(
                            'https://hips.hearstapps.com/hmg-prod/images/beautiful-smooth-haired-red-cat-lies-on-the-sofa-royalty-free-image-1678488026.jpg'),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Sriharini Margapuri',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Defense Lawyer',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Column(
            children: <Widget>[
              const ListTile(
                title: Text(
                  'Lawyer ID',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text('1005-21-733065'),
              ),
              const Divider(),
              const ListTile(
                title: Text(
                  'Email',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text('sriharini03.m@gmail.com'),
              ),
              const Divider(),
              const ListTile(
                title: Text(
                  'Phone Number',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text('+1 310-425-4557'),
              ),
              const Divider(),
              const ListTile(
                title: Text(
                  'Law Firm',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                    '10711 Rose Ave. Apt #112\n90034\n\nLos Angeles, California'),
              ),
              const Divider(),
              const ListTile(
                title: Text(
                  'About',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text('ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
              ),
              const Divider(),
              ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                  ),
                  icon: const Icon(Icons.lock_open, size: 32),
                  label: const Text('Sign Out', style: TextStyle(fontSize: 24)),
                  onPressed: () => {
                        FirebaseAuth.instance.signOut(),
                        Navigator.pushReplacementNamed(context, '/'),
                        // Navigator.of(context).pushReplacement(MaterialPageRoute(
                        //     builder: ((context) => const MainPage())))
                      }),
            ],
          ),
        ],
      ),
    );
  }
}
