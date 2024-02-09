import 'package:firebase_auth/firebase_auth.dart';
// import 'package:legalite/main.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpWidget extends StatefulWidget {
  final Function() onClickedLSignUp;
  final Function() onClickedSignIn;
  const SignUpWidget({
    Key? key,
    required this.onClickedSignIn,
    required this.onClickedLSignUp,
  }) : super(key: key);

  @override
  State<SignUpWidget> createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
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
          const SizedBox(
            height: 100,
          ),
          const Text(
            "SignUp C",
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
          const SizedBox(height: 24),
          RichText(
              text: TextSpan(
                  style: const TextStyle(color: Colors.black, fontSize: 20),
                  text: "Client Login? ",
                  children: [
                TextSpan(
                  recognizer: TapGestureRecognizer()
                    ..onTap = widget.onClickedSignIn,
                  text: 'Log In',
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Theme.of(context).colorScheme.secondary),
                ),
              ])),
          RichText(
              text: TextSpan(
                  style: const TextStyle(color: Colors.black, fontSize: 20),
                  text: "Create Lawyer? ",
                  children: [
                TextSpan(
                  recognizer: TapGestureRecognizer()
                    ..onTap = widget.onClickedLSignUp,
                  text: 'Sign Up',
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
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passwordController.text.trim());
      CollectionReference clients =
          FirebaseFirestore.instance.collection('clients');
      clients.doc(userCredential.user!.uid).set({
        'Name': nameController.text.trim(),
        'Email': emailController.text.trim(),
        'Type': 'Client',
      });
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }
}
