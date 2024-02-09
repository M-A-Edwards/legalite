import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:legalite/widgets/cdrawer_widget.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final padding = const EdgeInsets.symmetric(horizontal: 20);
  String user = FirebaseAuth.instance.currentUser!.uid;
  @override
  Widget build(BuildContext context) {
    // const urlImage =
    //     "https://www.shutterstock.com/image-photo/photo-words-wooden-block-objects-arranged-2364889927";
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      drawer: const MyDrawer(),
    );
  }
}
