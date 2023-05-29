import 'package:flutter/material.dart';
import 'package:ai_cv_generator/pages/home.dart';
import 'package:ai_cv_generator/pages/createPage.dart';

void main() {
  runApp(const MyApp());
}

//Run: flutter clean
//     flutter run
//     Choose between Windows,Chrome,Edge application
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI-CV-GENERATOR_DEMO1_build',
      initialRoute: '/',
      routes: {
        '/':(context) => Home(),
        // '/importCV':(context) => ImportCV() 
        // Incase we need routing later on
      },
      debugShowCheckedModeBanner: false,
    );
  }
}