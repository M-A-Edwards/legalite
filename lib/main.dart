import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:legalite/Lpages/ClientScreen.dart';
import 'package:legalite/Lpages/HomeScreen.dart';
import 'package:legalite/pages/HomeScreen.dart';
import 'package:legalite/Lpages/Nested%20pages/Cases.dart';
import 'package:legalite/Lpages/ProfileScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:legalite/pages/AttorneyScreen.dart';
import 'package:legalite/pages/LegalAid.dart';
import 'package:legalite/pages/ProfileScreen.dart';
import 'package:legalite/widgets/Auth_page.dart';
//import 'package:legalite/widgets/switch_page.dart';
import 'firebase_options.dart';

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

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Legalite',
      initialRoute: '/',
      routes: {
        // '/': (context) => const MyApp(),
        '/home': (context) => const Home(),
        '/profile': (context) => const Profile(),
        '/lawyer': (context) => const Attorneys(),
        '/legalaid': (context) => const LegalAid(),
        '/lclient': (context) => const Clients(),
        '/lhome': (context) => LHome(),
        '/lprofile': (context) => const LProfile(),
        '/lallCases': (context) => Cases(),
      },
      theme: ThemeData(primarySwatch: Colors.blue),
      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      //   useMaterial3: true,
      // ),
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
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(child: Text("Something went wrong!"));
          } else if (snapshot.hasData) {
            return Home();
            // String uid = FirebaseAuth.instance.currentUser!.uid;
            // // return SwitchPage(uid);
            // return SwitchPage(uid);
          } else {
            return const AuthPage();
          }
        },
      ),
    );
  }
}
