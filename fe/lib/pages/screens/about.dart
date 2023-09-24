// internal
import 'package:ai_cv_generator/pages/widgets/breadcrumb.dart';

// external
import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  AboutPageState createState() => AboutPageState();
}

class AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double w = screenSize.width/100;
    return  Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
          ), 
          onPressed: () { 
            Navigator.pop(context);
          },
        )
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const Breadcrumb(previousPage: "Home", currentPage: "About",),
            const SizedBox(
              height: 24,
            ),
            Expanded(
              child: ListView(
                children: [
                  const Text(
                    "ABOUT US", 
                    style: TextStyle(fontSize: 60),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 48,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: (30*w).toDouble()),
                    child: const Text(
                      style: TextStyle(fontSize: 18), 
                      "A challenge for job seekers in South Africa is the creation of an effective CV, cover letter, or email that can make them stand out to potential employers. Many job seekers lack the necessary knowledge and skills to craft high-quality job application documents that highlight their strengths and experiences. The AI CV Generator aims to aid job seekers in creating appealing job application documents that will increase their chances of acquiring a job.",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            )
          ],
        )
      )
    );
  }
}