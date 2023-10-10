// internal
import 'package:ai_cv_generator/pages/elements/elements.dart';
import 'package:ai_cv_generator/pages/screens/changePassword.dart';
import 'package:ai_cv_generator/pages/screens/emailConfirmation.dart';
import 'package:ai_cv_generator/pages/screens/emailVerification.dart';
import 'package:ai_cv_generator/pages/screens/forgotPassword.dart';
import 'package:ai_cv_generator/pages/screens/Register.dart';
import 'package:ai_cv_generator/pages/screens/about.dart';
import 'package:ai_cv_generator/pages/screens/help.dart';
import 'package:ai_cv_generator/pages/screens/homeRedo.dart';
import 'package:ai_cv_generator/pages/screens/job.dart';
import 'package:ai_cv_generator/pages/screens/login.dart';
import 'package:ai_cv_generator/pages/screens/profile.dart';
import 'package:ai_cv_generator/pages/util/sharedFileView.dart';

// external
import 'package:flutter/material.dart';

import 'package:flutter_web_plugins/url_strategy.dart';


Future<void> main() async {
  //usePathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, this.code});
  final String? code;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: mainTheme,
      themeMode: ThemeMode.system,
      title: 'AI CV Generator',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/':(context) => const Login(),
        '/verify':(context) => EmailVerification(code: code,),
        '/register':(context) => const RegisterPage(),
        '/confirm':(context) => const EmailConfirmation(),
        '/home':(context) => const Home(),
        '/profile':(context) => const Profile(),
        '/jobs':(context) => const JobsPage(),
        '/about':(context) => const AboutPage(),
        '/help':(context) => const Help(),
        '/validate':(context) => ChangePassword(code: code,),
        '/forgot':(context) => const ForgotPassword()
      },
      onGenerateRoute: (settings) {
        if (settings.name == null) {
          return MaterialPageRoute(builder: (_) => const Login());
        }
        Uri base = Uri.parse(settings.name!);
        switch (base.pathSegments.first) {
          case'':
              return MaterialPageRoute(builder: (_) => const Login()); 
          case'verify':
              return MaterialPageRoute(builder: (_) => EmailVerification(code: base.queryParameters["code"],));
          case'share':
              String uuid = base.pathSegments.last;
              return MaterialPageRoute(builder: (_) => SharedFileView(uuid: uuid));
          case'validate':
              return MaterialPageRoute(builder: (_) => ChangePassword(code: base.queryParameters["code"],));
          default:
              return MaterialPageRoute(builder: (_) => const Login());
        }
      }
    );
  }
}