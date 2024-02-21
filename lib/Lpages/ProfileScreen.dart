import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:legalite/main.dart';
import 'package:legalite/widgets/drawer_widget.dart';
import 'package:legalite/Lpages/nested_pages/editLprofile.dart';

class LProfile extends StatefulWidget {
  const LProfile({super.key});

  @override
  State<LProfile> createState() => _LProfileState();
}

class _LProfileState extends State<LProfile> {
  // DocumentSnapshot docSnap = await FirebaseFirestore.instance
  //     .collection('clients')
  //     .doc(FirebaseAuth.instance.currentUser!.uid)
  //     .get();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Profile"),
        ),
        drawer: const MyDrawer(),
        body: StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection('lawyers')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final userData = snapshot.data!.data() as Map<String, dynamic>;
                return ListView(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0, right: 8.0),
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const EditLProfilePage()),
                            );
                          },
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsets>(
                                const EdgeInsets.all(12)),
                            minimumSize: MaterialStateProperty.all<Size>(
                                const Size(120, 50)),
                          ),
                          icon: const Icon(Icons.edit, size: 20),
                          label: const Text('Edit Profile',
                              style: TextStyle(fontSize: 16)),
                        ),
                      ),
                    ),
                    Container(
                      height: 250,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Row(
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
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                userData['Name'],
                                style: const TextStyle(
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
                                (userData['Desc'] != null)
                                    ? userData['Desc']
                                    : 'Lawyer',
                                style: const TextStyle(
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
                          title: const Text(
                            'Lawyer ID',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: (userData['LID'] != null)
                              ? Text(userData['LID'])
                              : const Text('<None>'),
                          // subtitle: Text(userData['LID']),
                        ),
                        const Divider(),
                        ListTile(
                          title: const Text(
                            'Email',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(userData['Email']),
                        ),
                        const Divider(),
                        ListTile(
                          title: const Text(
                            'Phone Number',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: (userData['Phone Number'] != null)
                              ? Text(userData['Phone Number'])
                              : const Text('<None>'),
                          // subtitle: Text(userData['Phone Number']),
                        ),
                        const Divider(),
                        ListTile(
                          title: const Text(
                            'Law Firm',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: (userData['Address'] != null)
                              ? Text(userData['Address'])
                              : const Text('<None>'),
                          // subtitle: Text(userData['Address']),
                        ),
                        const Divider(),
                        ListTile(
                          title: const Text(
                            'Location',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: (userData['Location'] != null)
                              ? Text(userData['Location'])
                              : const Text('<None>'),
                        ),
                        const Divider(),
                        ListTile(
                          title: const Text(
                            'Education',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: (userData['Education'] != null)
                              ? Text(userData['Education'])
                              : const Text('<None>'),
                        ),
                        const Divider(),
                        ListTile(
                          title: const Text(
                            'Experience',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: (userData['Exp'] != null)
                              ? Text(userData['Exp'])
                              : const Text('<None>'),
                        ),
                        const Divider(),
                        ListTile(
                          title: const Text(
                            'Specialization',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: (userData['Tags'] != null)
                              ? Text(userData['Tags'])
                              : const Text('<None>'),
                        ),
                        const Divider(),
                        ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size.fromHeight(50),
                            ),
                            icon: const Icon(Icons.lock_open, size: 32),
                            label: const Text('Sign Out',
                                style: TextStyle(fontSize: 24)),
                            onPressed: () => {
                                  FirebaseAuth.instance.signOut(),
                                  Navigator.pushReplacementNamed(context, '/'),
                                  // Navigator.of(context).pushReplacement(MaterialPageRoute(
                                  //     builder: ((context) => const MainPage())))
                                }),
                      ],
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error${snapshot.error}'),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }));
  }
}
