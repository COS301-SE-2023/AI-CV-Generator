import 'package:ai_cv_generator/dio/client/WebScraperApi.dart';
import 'package:ai_cv_generator/dio/client/userApi.dart';
import 'package:ai_cv_generator/models/user/UserModel.dart';
import 'package:ai_cv_generator/models/webscraper/JobResponseDTO.dart';
import 'package:ai_cv_generator/pages/elements/elements.dart';
import 'package:ai_cv_generator/pages/widgets/breadcrumb.dart';
import 'package:ai_cv_generator/pages/widgets/loadingscreens/loadingScreen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:universal_html/html.dart';

import 'package:url_launcher/url_launcher.dart';

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
        List<JobResponseDTO>? jobs = await getJobs("accounting", "Pretoria");
        // List<JobResponseDTO>? jobs = await getRecommended();
        setState(() {
          // for(int i = 0; i < 10; i++)
          // {
          //   jobCards.add(CreateJobCard(
          //     title: "Cashier",
          //     subtitle: "Shoprite",
          //     location: "Pretoria, Gauteng",
          //     salary: "R10000 - R16000 per month",
          //   ));
          // }
          createCards(jobs);
        });
    }
  }

  Future<List<JobResponseDTO>?> getJobs(String field, String location) async {
    return await WebScrapperApi.scrapejobs(field: field, location: location);
  }

  Future<List<JobResponseDTO>?> getRecommended() async {
    return await WebScrapperApi.recommended();
  }

  createCards(List<JobResponseDTO>? jobs) {
    if(jobs != null) {
      jobs.forEach((element) {
        print(element.imgLink);
        jobCards.add(
          CreateJobCard(
            title: element.title,
            subtitle: element.subTitle,
            location: element.location,
            salary: element.salary,
            link: element.link,
            imageLink: element.imgLink,
          )
        );
      });
    }
  }

  @override
  Widget build(BuildContext build) {
    // if(jobCards.isEmpty == true) {
    //   return LoadingScreen();
    // }
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
            SizedBox(height: 24,),
            Text("RECOMMENDED FOR YOU", style: TextStyle(fontSize: 60),),
            SizedBox(height: 24,),
            Expanded(
              child: SingleChildScrollView( 
                child: Center(
                  child: Container(
                    alignment: Alignment.center,
                    width: 1800,
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if(jobCards.isEmpty == true)
                          Padding(padding: EdgeInsets.symmetric(vertical: 160), child:LoadingScreen(),),
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
  String? imageLink;
  CreateJobCard({super.key, this.title, this.subtitle, this.location, this.salary, this.link, this.imageLink});

  @override
  CreateJobCardState createState() => CreateJobCardState();
}

class CreateJobCardState extends State<CreateJobCard> {

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        width: 400,
        height: 300,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Theme.of(context).colorScheme.surface
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.subtitle ?? "N/A", style: TextStyle(fontSize: 14),),
                          Text(widget.title ?? "N/A", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,)),
                        ],
                      ),
                    ),
                    Expanded(
                      child: CachedNetworkImage(
                        imageUrl: widget.imageLink ?? "http://via.placeholder.com/350x150",
                        progressIndicatorBuilder: (context, url, downloadProgress) => 
                                CircularProgressIndicator(value: downloadProgress.progress),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    )
                ],
              ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(widget.salary ?? "N/A", style: TextStyle(color: Colors.green),),
                          Text(widget.location ?? "N/A", style: TextStyle(fontSize: 12,)),
                        ],
                      ),
                    ),
                    SizedBox(width: 24,),
                    ElevatedButton(
                        onPressed: () {
                          if(widget.link != null) {
                            launchUrl(Uri.parse(widget.link!));
                          }
                        }, 
                        child: Text("VISIT"),
                    )
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