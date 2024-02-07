import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:legalite/Lpages/HomeScreen.dart';
import 'package:legalite/pages/HomeScreen.dart';

class SwitchPage extends StatefulWidget {
  const SwitchPage(String uid, {super.key});
  final uid = uid;
  @override
  State<SwitchPage> createState() => _SwitchPageState();
}

class _SwitchPageState extends State<SwitchPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String get uid => null;
  Future<bool> doesUserExist(String uid) async {
    DocumentSnapshot userSnapshot =
        await _firestore.collection('Client').doc(uid).get();
    return userSnapshot.exists;
  }

  @override
  Widget build(BuildContext context) async {
    bool userexists = await doesUserExist(uid);
    if (doesUserExist(uid)) {
      return Home();
    } else {
      return LHome();
    }
  }
}
