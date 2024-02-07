import 'package:flutter/material.dart';
import 'package:legalite/widgets/cdrawer_widget.dart';

class LegalAid extends StatefulWidget {
  const LegalAid({super.key});

  @override
  State<LegalAid> createState() => _LegalAidState();
}

class _LegalAidState extends State<LegalAid> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Legal Aid'),
        ),
        drawer: const MyDrawer());
  }
}
