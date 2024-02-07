import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:legalite/main.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LSignUpWidget extends StatefulWidget {
  final Function() onClickedSignUp;
  final Function() onClickedLLogin;
  const LSignUpWidget({
    Key? key,
    required this.onClickedSignUp,
    required this.onClickedLLogin,
  }) : super(key: key);

  @override
  State<LSignUpWidget> createState() => _LSignUpWidgetState();
}

class _LSignUpWidgetState extends State<LSignUpWidget> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 100,
          ),
          Text(
            "Signup L",
            style: TextStyle(fontSize: 60, fontFamily: 'Consolas'),
          ),
          const SizedBox(height: 200),
          TextField(
            controller: nameController,
            cursorColor: Colors.black,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(labelText: 'Name'),
          ),
          const SizedBox(
            height: 4,
          ),
          TextField(
            controller: emailController,
            cursorColor: Colors.black,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(labelText: 'Email'),
          ),
          const SizedBox(height: 4),
          TextField(
            controller: passwordController,
            textInputAction: TextInputAction.done,
            decoration: const InputDecoration(labelText: 'Password'),
            obscureText: true,
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(50),
            ),
            icon: const Icon(Icons.lock_open, size: 32),
            label: const Text('Sign Up', style: TextStyle(fontSize: 24)),
            onPressed: signUp,
          ),
          SizedBox(height: 24),
          RichText(
              text: TextSpan(
                  style: TextStyle(color: Colors.black, fontSize: 20),
                  text: "Lawyer Login? ",
                  children: [
                TextSpan(
                  recognizer: TapGestureRecognizer()
                    ..onTap = widget.onClickedLLogin,
                  text: 'Log In',
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Theme.of(context).colorScheme.secondary),
                ),
              ])),
          RichText(
              text: TextSpan(
                  style: TextStyle(color: Colors.black, fontSize: 20),
                  text: "Create Client? ",
                  children: [
                TextSpan(
                  recognizer: TapGestureRecognizer()
                    ..onTap = widget.onClickedSignUp,
                  text: 'SignUp',
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Theme.of(context).colorScheme.secondary),
                ),
              ]))
        ],
      ),
    );
  }

  Future signUp() async {
    try {
      CollectionReference clients =
          FirebaseFirestore.instance.collection('clients');
      clients.add({
        'Name': nameController.text.trim(),
        'Email': emailController.text.trim(),
        'Type':'Lawyer',
      });
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }
}
