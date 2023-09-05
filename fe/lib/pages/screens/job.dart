import 'package:ai_cv_generator/dio/client/WebScraperApi.dart';
import 'package:ai_cv_generator/dio/client/userApi.dart';
import 'package:ai_cv_generator/models/user/UserModel.dart';
import 'package:ai_cv_generator/models/webscraper/JobResponseDTO.dart';
import 'package:ai_cv_generator/pages/widgets/breadcrumb.dart';
import 'package:ai_cv_generator/pages/widgets/loadingscreens/loadingScreen.dart';
import 'package:flutter/material.dart';

class JobsPage extends StatefulWidget {
  const JobsPage({super.key});

  @override
  JobsPageState createState() => JobsPageState();
}

class JobsPageState extends State<JobsPage> {
  List<Widget> jobCards = [];

  @override
  void initState() {
    populate();
    super.initState();
  }

  void populate() async {
    UserModel? user = await userApi.getUser();
    if(user != null) {
        List<JobResponseDTO>? jobs = await getJobs("accounting", user.location ?? "");
        setState(() {
          createCards(jobs);
        });
    }
  }

  Future<List<JobResponseDTO>?> getJobs(String field, String location) async {
    return await WebScrapperApi.scrapejobs(field: field, location: location);
  }

  createCards(List<JobResponseDTO>? jobs) {
    if(jobs != null) {
      jobs.forEach((element) {
        jobCards.add(
          CreateJobCard(
            title: element.title,
            subtitle: element.subTitle,
            location: element.location,
            salary: element.salary,
            link: element.link,
          )
        );
      });
    }
  }

  @override
  Widget build(BuildContext build) {
    if(jobCards.isEmpty == true) {
      return LoadingScreen();
    }
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
        child: Column(
          children: [
            Breadcrumb(previousPage: "Home", currentPage: "Jobs",),
            Expanded(
              child: SingleChildScrollView( 
                child: Center(
                  child: Container(
                    width: 1100,
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ...jobCards,
                      ],
                    ),
                  )
                )
              )
            )

          ],
        )
      )
    );
  }
}

class CreateJobCard extends StatefulWidget {
  String? title;
  String? subtitle;
  String? location;
  String? salary;
  String? link;
  CreateJobCard({super.key, this.title, this.subtitle, this.location, this.salary, this.link});

  @override
  CreateJobCardState createState() => CreateJobCardState();
}

class CreateJobCardState extends State<CreateJobCard> {

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        width: 210,
        height: 300,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(widget.title ?? "N/A", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(height: 4),
                  Text(widget.subtitle ?? "N/A", style: TextStyle(fontSize: 14),),
                  SizedBox(height: 8,),
                  Container(
                    height: 1,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 8,),
                  Text(widget.location ?? "N/A", style: TextStyle(fontSize: 12,)),
                ],
              ),
            ),
            Expanded(
              child: SizedBox(
                child: Column(
                  children: [
                    SizedBox(height: 16,),
                    Text(widget.salary ?? "N/A", style: TextStyle(color: Colors.green),),
                    SizedBox(height: 24,),
                    ElevatedButton(
                      onPressed: () {
                        if(widget.link != null) {

                        }
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
    );
  }
}