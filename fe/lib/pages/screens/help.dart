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

    Widget imageDescription(String imagePath, String imageDescription, String title, bool inverse) {
      return Container(
        width: 80*w,
        height: 400,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Theme.of(context).colorScheme.surface
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Breadcrumb(previousPage: "Home", currentPage: "Help",),
            const SizedBox(
              height: 24,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 2*w
                ),
              ),
            ),
            const Divider(
              height: 10,
              thickness: 2,
              color: Colors.white,
              indent: 20,
              endIndent: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (!inverse)
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    imagePath,
                    height: 280,
                  ),
                ),
                Container(
                  width: 35*w,
                  height: 280,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.white
                  ),
                  child: Container(
                    width: 32*w,
                    margin: const EdgeInsets.all(10),
                    child: Text(
                      imageDescription,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 1*w,
                        overflow: TextOverflow.fade
                      ),
                    ),
                  ),
                ),
                if (inverse)
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    imagePath,
                    height: 280,
                  ),
                ),
              ],
            ),
          ],
        )
      );
    }

    return Scaffold(
      extendBodyBehindAppBar:false,
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
      body: SingleChildScrollView(
        clipBehavior: Clip.antiAlias,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20,),
              Align(
                child: Text(
                  'Help',
                  style: TextStyle(
                    fontSize: 3*w
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              imageDescription('assets/images/HomePage.png', 'Image description','Home Page', false),
              const SizedBox(height: 20,),
              imageDescription('assets/images/AIChatBot.png', 'Image description','Chat Bot', true),
              const SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }
       

}