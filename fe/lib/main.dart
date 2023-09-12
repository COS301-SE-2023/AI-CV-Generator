// internal
import 'package:ai_cv_generator/pages/elements/elements.dart';
import 'package:ai_cv_generator/dio/client/shareClient.dart';
import 'package:ai_cv_generator/pages/screens/changePassword.dart';
import 'package:ai_cv_generator/pages/screens/emailConfirmation.dart';
import 'package:ai_cv_generator/pages/screens/emailVerification.dart';
import 'package:ai_cv_generator/pages/screens/forgotPassword.dart';
import 'package:ai_cv_generator/pages/screens/register.dart';
import 'package:ai_cv_generator/pages/screens/about.dart';
import 'package:ai_cv_generator/pages/screens/help.dart';
import 'package:ai_cv_generator/pages/screens/home.dart';
import 'package:ai_cv_generator/pages/screens/job.dart';
import 'package:ai_cv_generator/pages/screens/login.dart';
import 'package:ai_cv_generator/pages/screens/resetSuccess.dart';
import 'package:ai_cv_generator/pages/widgets/pdf_window.dart';
import 'package:ai_cv_generator/pages/screens/profile.dart';

// external
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  Uri myurl = Uri.base;
  if (myurl.path.contains("/share/")) {
    String uuid = myurl.pathSegments.last;
    PlatformFile? file = await ShareApi.retrieveFile(uuid: uuid);
    runApp(ShareCVApp(file: file));
  } else if (myurl.path.contains("/verify")) {
    final String? code = myurl.queryParameters["code"];
    if (code != null) {
      runApp(MyApp(route: "/verify",code: code));
    } else {
      runApp(const MyApp(route: "/",));
    }
  } else if (myurl.path.contains("/reset")) {
    final String? code = myurl.queryParameters["code"];
    if (code != null) {
      runApp(MyApp(route: "/validate",code: code,));
    } else {
      runApp(const MyApp(route: "/",));
    }
  } else {
    runApp(const MyApp(route: "/"));
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.route, this.code});
  final String route;
  final String? code;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: mainTheme,
      themeMode: ThemeMode.system,
      title: 'AI CV Generator',
      debugShowCheckedModeBanner: false,
      initialRoute: route,
      routes: {
        '/':(context) => const Login(),
        '/register':(context) => const RegisterPage(),
        '/confirm':(context) => const EmailConfirmation(),
        '/home':(context) => const Home(),
        '/profile':(context) => const Profile(),
        '/jobs':(context) => const JobsPage(),
        '/about':(context) => const AboutPage(),
        '/help':(context) => const Help(),
        '/verify':(context) => EmailVerification(code: code,),
        '/validate':(context) => ChangePassword(code: code,),
        '/forgot':(context) => const ForgotPassword(),
        '/resetSuccess':(context) => const ResetSuccess()
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/profile') {
          return PageRouteBuilder(
            settings: settings,
            pageBuilder: (context,animation, secondaryAnimation ) => const Profile(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {

              return FadeTransition(
                opacity: animation,
                child: child
              );
            },
            transitionDuration: Duration.zero,
            reverseTransitionDuration: const Duration(seconds: 2)
          );
        }
        return MaterialPageRoute(builder: (context)=> const Home());
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