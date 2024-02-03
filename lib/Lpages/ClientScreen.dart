import 'package:flutter/material.dart';
import 'package:legalite/widgets/drawer_widget.dart';

class Clients extends StatefulWidget {
  const Clients({super.key});

  @override
  State<Clients> createState() => _ClientsState();
}

class _ClientsState extends State<Clients> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Clients"),
        ),
        drawer: const MyDrawer());
  }
}
