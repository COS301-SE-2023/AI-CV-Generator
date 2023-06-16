import 'package:ai_cv_generator/pages/login.dart';
import 'package:ai_cv_generator/pages/test_page.dart';
import 'package:flutter/material.dart';


void main() {
  Uri myurl = Uri.base; //get complete url
  Map<String,List<String>> parameters = myurl.queryParametersAll; //These parameters are used in share CV for POST call later
  for(var v in parameters.values) {
    print(v);
  }
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
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/':(context) => const Login(),
        //Route for shareCV will be added later
      },
    );
  }
}