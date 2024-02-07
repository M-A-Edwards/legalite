import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:legalite/main.dart';

class LLoginWidget extends StatefulWidget {
  final VoidCallback onClickedLSignUp;
  final VoidCallback onClickedSignIn;
  const LLoginWidget({
    Key? key,
    required this.onClickedLSignUp,
    required this.onClickedSignIn,
  }) : super(key: key);
  @override
  State<LLoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LLoginWidget> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
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
            "Login L",
            style: TextStyle(fontSize: 60, fontFamily: 'Consolas'),
          ),
          const SizedBox(height: 200),
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
            label: const Text('Sign in', style: TextStyle(fontSize: 24)),
            onPressed: signIn,
          ),
          SizedBox(height: 24),
          RichText(
              text: TextSpan(
                  style: TextStyle(color: Colors.black, fontSize: 20),
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
              ])),
          RichText(
              text: TextSpan(
                  style: TextStyle(color: Colors.black, fontSize: 20),
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
              ]))
        ],
      ),
    );
  }

  Future signIn() async {
    // showDialog(
    //     context: context,
    //     barrierDismissible: false,
    //     builder: (context) => const Center(child: CircularProgressIndicator()));
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      print(e);
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
