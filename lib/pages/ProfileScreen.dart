import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:legalite/widgets/cdrawer_widget.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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
                      'Client',
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
              ListTile(
                title: Text(
                  'Date of Birth',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text('08/10/2003'),
              ),
              Divider(),
              ListTile(
                title: Text(
                  'Email',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text('sriharini03.m@gmail.com'),
              ),
              Divider(),
              ListTile(
                title: Text(
                  'Phone Number',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text('+1 310-425-4557'),
              ),
              Divider(),
              ListTile(
                title: Text(
                  'Address',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                    '10711 Rose Ave. Apt #112\n90034\n\nLos Angeles, California'),
              ),
              Divider(),
              ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(50),
                  ),
                  icon: Icon(Icons.lock_open, size: 32),
                  label: Text('Sign Out', style: TextStyle(fontSize: 24)),
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