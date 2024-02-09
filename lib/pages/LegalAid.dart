import 'package:flutter/material.dart';
import 'package:legalite/widgets/cdrawer_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LegalAid extends StatefulWidget {
  const LegalAid({super.key});

  @override
  State<LegalAid> createState() => _LegalAidState();
}

class _LegalAidState extends State<LegalAid> {
  final _formKey = GlobalKey<FormState>();
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final casenoController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Legal Aid'),
        ),
        drawer: const MyDrawer(),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
            ),
            const Align(
              alignment: Alignment.center,
              child: Text("LEGAL AID REGISTRATION FORM",
                style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
            ),
            const Text("Case Number"),
            TextFormField(
              controller: casenoController,
              validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter valid case number';
              }
              return null;
            },
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
          ),
            const Text("First Name"),
            TextFormField(
              controller: firstnameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter First Name';
                }
                return null;
              },
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
            ),
            const Text("Last Name"),
            TextFormField(
              controller: lastnameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter Last Name';
                }
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Submitting Form')),
                    );
                  }
                  try {
                    CollectionReference clients =
                    FirebaseFirestore.instance.collection('legalaid');
                    clients.add({
                      'Case Number': casenoController.text.trim(),
                      'First Name': firstnameController.text.trim(),
                      'Last Name': lastnameController.text.trim(),
                    });
                  } on FirebaseAuthException catch () {
                    const AlertDialog(
                      content: Text("Error Submitting Form"),
                    );
                  }
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Form Submitted')),
                  );
                  firstnameController.clear();
                  lastnameController.clear();
                  casenoController.clear();
                },
                child: const Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
