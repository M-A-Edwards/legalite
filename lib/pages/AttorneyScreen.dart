import 'package:flutter/material.dart';
import 'package:legalite/widgets/drawer_widget.dart';

class Attorneys extends StatefulWidget {
  const Attorneys({super.key});

  @override
  State<Attorneys> createState() => _AttorneysState();
}

class _AttorneysState extends State<Attorneys> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Attorneys"),
        ),
        drawer: const MyDrawer());
  }
}
