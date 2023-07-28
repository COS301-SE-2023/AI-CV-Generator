import 'package:ai_cv_generator/dio/client/shareClient.dart';
import 'package:ai_cv_generator/pages/Register.dart';
import 'package:ai_cv_generator/pages/about.dart';
import 'package:ai_cv_generator/pages/employment.dart';
import 'package:ai_cv_generator/pages/home.dart';
import 'package:ai_cv_generator/pages/login.dart';
import 'package:ai_cv_generator/pages/pdf_window.dart';
import 'package:ai_cv_generator/pages/personaldetails.dart';
import 'package:ai_cv_generator/pages/profile.dart';
import 'package:ai_cv_generator/pages/qualifications.dart';
import 'package:ai_cv_generator/pages/references.dart';
import 'package:ai_cv_generator/pages/skills.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:ai_cv_generator/pages/elements/elements.dart';


Future<void> main() async {
  Uri myurl = Uri.base;
  print(myurl.path);
  if (myurl.path.contains("/share/")) {
    String uuid = myurl.pathSegments.last;
    PlatformFile? file = await ShareApi.retrieveFile(uuid: uuid);
    runApp(ShareCVApp(file: file));
  } else {
    runApp(const MyApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: mainTheme,
      title: 'AI-CV-GENERATOR_DEMO1_build',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/':(context) => const Login(),
        '/register':(context) => const RegisterPage(),
        '/home':(context) => const Home(),
        '/profile':(context) => const Profile(),
        '/about':(context) => const AboutPage(),
      },
    );
  }
}

class ShareCVApp extends StatelessWidget {
  const ShareCVApp({super.key, required this.file});
  final PlatformFile? file;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI-CV-GENERATOR_DEMO1_build',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/':(context) => PdfWindow(file: file),
      },
    );
  }
}