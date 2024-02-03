import 'package:flutter/material.dart';
import 'package:legalite/widgets/drawer_widget.dart';
// import 'package:legalite/Lpages/ProfileScreen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final padding = const EdgeInsets.symmetric(horizontal: 20);
  @override
  Widget build(BuildContext context) {
    // const urlImage =
    //     "https://www.shutterstock.com/image-photo/photo-words-wooden-block-objects-arranged-2364889927";
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
        ),
        drawer: const MyDrawer());
  }
}
