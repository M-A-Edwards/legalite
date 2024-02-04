import 'package:flutter/material.dart';
import 'package:legalite/Lpages/ClientScreen.dart';
import 'package:legalite/Lpages/HomeScreen.dart';
import 'package:legalite/Lpages/Nested%20pages/Cases.dart';
import 'package:legalite/Lpages/ProfileScreen.dart';

void main() {
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
        '/lhome': (context) => Home(),
        '/lprofile': (context) => const Profile(),
        '/lclient': (context) => const Clients(),
        '/lallCases': (context) => Cases(),
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Home(),
    );
  }
}
