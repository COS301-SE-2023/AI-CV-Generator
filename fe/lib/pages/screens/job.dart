import 'package:ai_cv_generator/pages/widgets/breadcrumb.dart';
import 'package:flutter/material.dart';

class JobsPage extends StatefulWidget {
  const JobsPage({super.key});

  @override
  JobsPageState createState() => JobsPageState();
}

class JobsPageState extends State<JobsPage> {
  @override
  Widget build(BuildContext build) {
    return Scaffold(
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
      body: const SafeArea(
        child: Stack(
          children: [
            Breadcrumb(previousPage: "Home", currentPage: "Jobs",),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  
                ],
              ),
            )
          ],
        )
      )
    );
  }
}