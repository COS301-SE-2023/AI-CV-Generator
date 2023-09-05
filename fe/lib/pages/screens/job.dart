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
      body: SafeArea(
        child: Stack(
          children: [
            Breadcrumb(previousPage: "Home", currentPage: "Jobs",),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Container(
                      padding: EdgeInsets.all(16),
                      width: 150,
                      height: 250,
                      child: Column(
                      // mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("Title"),
                              SizedBox(height: 4),
                              Text("SubTitle"),
                              SizedBox(height: 8,),
                              Container(
                                height: 1,
                                color: Colors.grey,
                              ),
                              SizedBox(height: 8,),
                              Text("Location"),
                            ],
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                            child: Column(
                              children: [
                                Text("Salary"),
                                SizedBox(height: 24,),
                                ElevatedButton(
                                  onPressed: () {

                                  }, 
                                  child: Text("VISIT"),
                                ),
                              ],
                            )
                        )
                      ),
                      ],
                    ),
                    )
                  )
                ],
              ),
            )
          ],
        )
      )
    );
  }
}

class CreateJobCard extends StatefulWidget {
  const CreateJobCard({super.key});

  @override
  CreateJobCardState createState() => CreateJobCardState();
}

class CreateJobCardState extends State<CreateJobCard> {
  @override
  Widget build(BuildContext context) {
    return Card();
  }
}