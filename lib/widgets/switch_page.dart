import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:legalite/Lpages/HomeScreen.dart';
import 'package:legalite/pages/HomeScreen.dart';

class SwitchPage extends StatelessWidget {
  const SwitchPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<String?>(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data == 'clients') {
              return const Home();
            } else if (snapshot.data == 'lawyers') {
              return LHome();
            }
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
        future: getUserCollection(FirebaseAuth.instance.currentUser!.uid),
      ),
    );
  }

  Future<String?> getUserCollection(String? userId) async {
    List<String> collections = ['clients', 'lawyers'];
    for (String collectionName in collections) {
      CollectionReference collection =
          FirebaseFirestore.instance.collection(collectionName);
      QuerySnapshot querySnapshot = await collection
          .where('Email', isEqualTo: FirebaseAuth.instance.currentUser!.email)
          .get();
      DocumentSnapshot documentSnapshot = await collection.doc(userId).get();
      if (documentSnapshot.exists || querySnapshot.docs.isNotEmpty) {
        return collectionName;
      }
    }
    return 'wait';
  }
}
