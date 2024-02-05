import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:legalite/Lpages/ClientScreen.dart';
import 'package:legalite/Lpages/HomeScreen.dart';
import 'package:legalite/Lpages/ProfileScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:legalite/widgets/login_widget.dart';
import 'firebase_options.dart';
import 'package:legalite/Lpages/Nested%20pages/Cases.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // runApp(MaterialApp(
  //   title: "Routes",
  //   initialRoute: '/',
  //   routes: {
  //     '/': (context) => const MyApp(),
  //     '/lhome': (context) => const Home(),
  //     '/lprofile': (context) => const Profile(),
  //     '/lclient': (context) => const Clients(),
  //   },
  // ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Legalite',
      initialRoute: '/',
      routes: {
        // '/': (context) => const MyApp(),
        '/lhome': (context) => const Home(),
        '/lprofile': (context) => const Profile(),
        '/lclient': (context) => const Clients(),
        '/lallCases': (context) => Cases(),
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(child: Text("Something went wrong!"));
          } else if (snapshot.hasData) {
            return const Home();
          } else {
            return const LoginWidget();
          }
        },
      ),
    );
  }
}
