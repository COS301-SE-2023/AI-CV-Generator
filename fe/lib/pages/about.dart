import 'package:ai_cv_generator/pages/navdrawer.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  @override
  AboutPageState createState() => AboutPageState();
}

class AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext build) {
    return  Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color.fromARGB(255, 0, 63, 114),
          ), 
          onPressed: () { 
            Navigator.pop(context);
          },
        ),
      actions: [
        IconButton(onPressed: () {}, 
        icon: const Icon(Icons.account_circle, size: 32,)),
        SizedBox(width: 16,)
      ],
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            width: 300,
              child: Text("A challenge for job seekers in South Africa is the creation of an effective CV, cover letter, or email that can make them stand out to potential employers. Many job seekers lack the necessary knowledge and skills to craft high-quality job application documents that highlight their strengths and experiences. The AI CV Generator aims to aid job seekers in creating appealing job application documents that will increase their chances of acquiring a job."),
          ),
        )
          
      )
    );
  }
}