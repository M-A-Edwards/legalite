import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EditLProfilePage extends StatefulWidget {
  const EditLProfilePage({super.key});

  @override
  _EditLProfilePageState createState() => _EditLProfilePageState();
}

class _EditLProfilePageState extends State<EditLProfilePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lidController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _specialController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  void fetchUserData() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('lawyers')
        .doc(userId)
        .get();

    Map<String, dynamic> userData = snapshot.data() as Map<String, dynamic>;

    setState(() {
      _nameController.text = userData['Name'];
      _emailController.text = userData['Email'];
      _lidController.text = userData['LID'];
      _phoneNumberController.text = userData['Phone Number'];
      _addressController.text = userData['Address'];
      _typeController.text = userData['Desc'];
      _specialController.text = userData['Tags'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _lidController,
              decoration: const InputDecoration(labelText: 'Lawyer ID'),
            ),
            TextField(
              controller: _typeController,
              decoration: const InputDecoration(labelText: 'Type of Lawyer'),
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _phoneNumberController,
              decoration: const InputDecoration(labelText: 'Phone Number'),
            ),
            TextField(
              controller: _addressController,
              decoration: const InputDecoration(labelText: 'Law Firm Address'),
            ),
            TextField(
              controller: _specialController,
              decoration: const InputDecoration(labelText: 'Specialization'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                updateProfile();
              },
              child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }

  void updateProfile() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance.collection('lawyers').doc(userId).update({
      'Name': _nameController.text,
      'Email': _emailController.text,
      'LID': _lidController.text,
      'Phone Number': _phoneNumberController.text,
      'Address': _addressController.text,
      'Desc': _typeController.text,
      'Tags': _specialController.text,
    });

    Navigator.pop(context);
  }
}