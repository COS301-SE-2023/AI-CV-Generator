import 'package:flutter/material.dart';

import '../widgets/breadcrumb.dart';

class Help extends StatefulWidget {
  const Help({super.key});

  @override
  State<StatefulWidget> createState() => HelpState();
}

class HelpState extends State<Help> {

@override
  Widget build(BuildContext build) {
    Size screenSize = MediaQuery.of(context).size;
    double w = screenSize.width/100;
    double h = screenSize.height/100;

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
            icon: const Icon(
              Icons.account_circle,
              size: 32,
            )
          ),
          const SizedBox(
            width: 16,
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const Breadcrumb(
              previousPage: "Home",
              currentPage: "Help",
            ),
            const SizedBox(
              height: 24,
            ),
            Expanded(
              child: ListView(
                children: [
                  const Text(
                    "Help",
                    style: const TextStyle(fontSize: 60),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                ]
              )
            )
          ]
        )
      )
    );
  }
       

}