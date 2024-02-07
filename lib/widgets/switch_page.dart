import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:legalite/Lpages/HomeScreen.dart';
import 'package:legalite/pages/HomeScreen.dart';

class SwitchPage extends StatelessWidget {
  // SwitchPage(String uid, {super.key});
  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String get uid => FirebaseAuth.instance.currentUser!.uid;
  // Future<bool> doesUserExist(String uid) async {
  //   DocumentSnapshot userSnapshot =
  //       await _firestore.collection('clients').doc(uid).get();
  //   return userSnapshot.exists;
  // }
  // final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
  //     .collection('users')
  //     .doc(uid)
  //     .get()
  //     .then((DocumentSnapshot documentSnapshot) {
  //   if (documentSnapshot.exists) {
  //     print('Document exists on the database');
  //   }
  // });
  @override
  Widget build(BuildContext context) {
    return Home();
    // return StreamBuilder<QuerySnapshot>(
    //   stream: FirebaseFirestore.instance.collection('clients').doc(uid),
    //   builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    //     if (snapshot.hasError) {
    //       return Text('Something went wrong');
    //     }

    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return Text("Loading");
    //     }

    //     return ListView(
    //       children: snapshot.data!.docs.map((DocumentSnapshot document) {
    //         Map<String, dynamic> data =
    //             document.data()! as Map<String, dynamic>;
    //         return ListTile(
    //           title: Text(data['full_name']),
    //           subtitle: Text(data['company']),
    //         );
    //       }).toList(),
    //     );
    //   },
    // );
    // return Scaffold(
    //   body : FutureBuilder
    // )
    // bool userexists = await doesUserExist(uid);
    // if (userexists) {
    //   return Home();
    // } else {
    //   return LHome();
    // }
  }
}
