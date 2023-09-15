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
        ),
      actions: [
        IconButton(onPressed: () {}, 
        icon: const Icon(Icons.account_circle, size: 32,)),
        const SizedBox(width: 16,)
      ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const Breadcrumb(previousPage: "Home", currentPage: "About",),
            Expanded(
              child: ListView(
                children: [
                  const Text(
                    "ABOUT US", 
                    style: TextStyle(fontSize: 60),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    width: 200,
                    padding: const EdgeInsets.symmetric(horizontal: 90),
                    decoration: BoxDecoration(
                      // color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
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