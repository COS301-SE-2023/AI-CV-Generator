import 'package:flutter/material.dart';
import 'package:ai_cv_generator/pages/home.dart';
import 'package:ai_cv_generator/pages/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI-CV-GENERATOR_DEMO1_build',
      initialRoute: '/',
      routes: {
        
        '/mainPage':(context) => Home(),
        '/':(context) => Login() 
      },
    );
  }
}