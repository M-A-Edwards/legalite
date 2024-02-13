// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:legalite/Lpages/Chat.dart';
import 'package:legalite/Lpages/ChatPeople.dart';
import 'package:legalite/Lpages/ClientScreen.dart';
import 'package:legalite/Lpages/HomeScreen.dart';
import 'package:legalite/pages/Chat.dart';
import 'package:legalite/pages/HomeScreen.dart';
import 'package:legalite/Lpages/Nested%20pages/Cases.dart';
import 'package:legalite/Lpages/ProfileScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:legalite/pages/AttorneyScreen.dart';
import 'package:legalite/pages/LegalAid.dart';
import 'package:legalite/pages/ProfileScreen.dart';
import 'package:legalite/widgets/Auth_page.dart';
import 'package:legalite/widgets/switch_page.dart';
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
        '/home': (context) => Home(),
        '/profile': (context) => const Profile(),
        '/lawyer': (context) => const Attorneys(),
        '/legalaid': (context) => const LegalAid(),
        '/chat': (context) => ChatPage(),
        '/lclient': (context) => const Clients(),
        '/lhome': (context) => LHome(),
        '/lprofile': (context) => const LProfile(),
        '/lallCases': (context) => Cases(),
        '/lchatpeople': (context) => LChatPeople(),
        '/lchat': (context) => LChatPage()
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
        builder: (context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(child: Text("Something went wrong!"));
          } else if (snapshot.hasData && snapshot.data != null) {
            return const SwitchPage();
            //  User? user = snapshot.data;
            // print("User UID: ${user!.uid}");

            // String userId = user.uid;
            // return FutureBuilder<DocumentSnapshot>(
            //   future: FirebaseFirestore.instance
            //       .collection('clients')
            //       .doc(userId)
            //       .get(),
            //   builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            //     if (snapshot.connectionState == ConnectionState.waiting) {
            //       return Center(
            //         child: CircularProgressIndicator(),
            //       );
            //     } else if (snapshot.hasError) {
            //       return Center(child: Text("Error fetching data!"));
            //     } else if (snapshot.hasData && snapshot.data!.exists) {
            //       return Home();
            //     } else {
            //       return FutureBuilder<DocumentSnapshot>(
            //         future: FirebaseFirestore.instance
            //             .collection('lawyers')
            //             .doc(userId)
            //             .get(),
            //         builder:
            //             (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            //           if (snapshot.connectionState == ConnectionState.waiting) {
            //             return Center(
            //               child: CircularProgressIndicator(),
            //             );
            //           } else if (snapshot.hasError) {
            //             return Center(child: Text("Error fetching data!"));
            //           } else if (snapshot.hasData && snapshot.data!.exists) {
            //             return LHome();
            //           } else {
            //             return Text("User not found in either collection");
            //           }
            //         },
            //       );
            //     }
            //   },
            // );
          } else {
            return const AuthPage();
          }
        },
      ),
    );
  }
}
