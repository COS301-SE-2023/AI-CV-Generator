import 'package:ai_cv_generator/dio/client/shareClient.dart';
import 'package:ai_cv_generator/pages/login.dart';
import 'package:ai_cv_generator/pages/pdf_window.dart';
import 'package:ai_cv_generator/pages/test_page.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';


Future<void> main() async {
  Uri myurl = Uri.base; //get complete url
  print(myurl.path);
  if (myurl.path.contains("/share/")) {
    String uuid = myurl.pathSegments.last;
    PlatformFile? file = await ShareApi.retrieveFile(uuid: uuid);
    runApp(ShareCVApp(file: file));
  } else {
    runApp(const MyApp());
  }
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

class ShareCVApp extends StatelessWidget {
  ShareCVApp({super.key, required this.file});
  PlatformFile? file;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI-CV-GENERATOR_DEMO1_build',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/':(context) => PdfWindow(file: file),
        //Route for shareCV will be added later
      },
    );
  }
}