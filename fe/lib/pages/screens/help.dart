import 'package:ai_cv_generator/pages/util/helpDescription.dart';
import 'package:ai_cv_generator/pages/widgets/buttons/greyButton.dart';
import 'package:flutter/material.dart';

import '../widgets/breadcrumb.dart';

class Help extends StatefulWidget {
  const Help({super.key});

  @override
  State<StatefulWidget> createState() => HelpState();
}

class HelpState extends State<Help> {
  ScrollController controller = ScrollController();

@override
  Widget build(BuildContext build) {
    Size screenSize = MediaQuery.of(context).size;
    double w = screenSize.width/100;
    double h = screenSize.height/100;

    var main = GlobalKey();
    var general = GlobalKey();
    var home = GlobalKey();
    var profile = GlobalKey();
    var navigation = GlobalKey();
    var job = GlobalKey();
    var chat = GlobalKey();
    var extract = GlobalKey();
    var editor = GlobalKey();
    var survey = GlobalKey();
    var about = GlobalKey();


    to(GlobalKey key) {
      Scrollable.ensureVisible(
        key.currentContext!,
        alignment: 0.5,
        duration: const Duration(milliseconds: 1000),
        curve: Curves.easeInOut,

      );
    }

    moveToMain() {
      to(main);
    }

    moveToHome() {
      to(home);
    }
    moveToProfile() {
      to(profile);
    }

    moveToGeneral() {
      to(general);
    }

    moveToNavigation() {
      to(navigation);
    }

    moveToChatBot() {
      to(chat);
    }

    moveToJob() {
      to(job);
    }

    moveToExtractor() {
      to(extract);
    }

    moveToEditor() {
      to(editor);
    }

    moveToSurvey() {
      to(survey);
    }

    moveToAbout() {
      to(about);
    }

    Widget imageDescription(String imagePath, String filePath, MainAxisAlignment axisAlignment, GlobalKey key, double height) {
      return Container(
        padding: const EdgeInsets.only(
          top: 25,
          bottom: 25
        ),
        width: 90*w,
        child: Row(
          mainAxisAlignment: axisAlignment,
          children: [
            Container(
              key: key,
              width: 70*w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(36),
                color: Theme.of(context).colorScheme.surface
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(width: 8*w,),
                      
                      IconButton(
                        hoverColor: Colors.transparent,
                        onPressed: () {
                          moveToMain();
                        }, 
                        icon: const Icon(Icons.arrow_upward)
                      )
                    ],
                  ),
                  const Divider(
                    height: 10,
                    thickness: 2,
                    color: Colors.white,
                    indent: 20,
                    endIndent: 20,
                  ),
                  const SizedBox(height: 30,),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: SizedBox(
                      width: 50*w,
                      child: Image.asset(
                        imagePath,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30,),
                  HelpDescription(filename: filePath,height: height,),
                ],
              )
            )
          ],
        ),
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
        controller: controller,
        clipBehavior: Clip.antiAlias,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Breadcrumb(
                previousPage: "Home", 
                currentPage: "Help",
              ),
              const SizedBox(
                height: 24,
              ),
              const SizedBox(height: 10,),
              Align(
                key: main,
                alignment: Alignment.topCenter,
                child: const Text(
                  'What can we help you with?',
                  style: TextStyle(
                    overflow: TextOverflow.fade,
                    fontSize: 32
                  ),
                ),
              ),
              const SizedBox(height: 100,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 35*w,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GreyButton(
                          text: 'Home Page', 
                          width: w*30, 
                          height: 60, 
                          onTap: () { 
                            moveToHome();
                          }, 
                          fontSize: w*1.4
                        ),
                        const SizedBox(height: 30,),
                        GreyButton(
                          text: 'Navigation', 
                          width: w*30, 
                          height: 60, 
                          onTap: () { 
                            moveToNavigation();
                          }, 
                          fontSize: w*1.4
                        ),
                        const SizedBox(height: 30,),
                        GreyButton(
                          text: 'Chat Bot', 
                          width: w*30, 
                          height: 60, 
                          onTap: () { 
                            moveToChatBot();
                          }, 
                          fontSize: w*1.4
                        ),
                        const SizedBox(height: 30,),
                        GreyButton(
                          text: 'Job Page', 
                          width: w*30, 
                          height: 60, 
                          onTap: () { 
                            moveToJob();
                          }, 
                          fontSize: w*1.4
                        ),
                        const SizedBox(height: 30,),
                        GreyButton(
                          text: 'Survey', 
                          width: w*30, 
                          height: 60, 
                          onTap: () { 
                            moveToSurvey();
                          }, 
                          fontSize: w*1.4
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 35*w,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GreyButton(
                          text: 'Profile Page', 
                          width: w*30, 
                          height: 60, 
                          onTap: () {
                            moveToProfile();
                          }, 
                          fontSize: w*1.4
                        ),
                        const SizedBox(height: 30,),
                        GreyButton(
                          text: 'Editor', 
                          width: w*30, 
                          height: 60, 
                          onTap: () { 
                            moveToEditor();
                          }, 
                          fontSize: w*1.4
                        ),
                        const SizedBox(height: 30,),
                        GreyButton(
                          text: 'Extraction', 
                          width: w*30, 
                          height: 60, 
                          onTap: () { 
                            moveToExtractor();
                          }, 
                          fontSize: w*1.4
                        ),
                        const SizedBox(height: 30,),
                        GreyButton(
                          text: 'General', 
                          width: w*30, 
                          height: 60, 
                          onTap: () { 
                            moveToGeneral();
                          }, 
                          fontSize: w*1.4
                        ),
                        const SizedBox(height: 30,),
                        GreyButton(
                          text: 'About Us', 
                          width: w*30, 
                          height: 60, 
                          onTap: () { 
                            moveToAbout();
                          }, 
                          fontSize: w*1.4
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 105,),
              Container(
                padding: const EdgeInsets.only(
                  top: 25,
                  bottom: 25
                ),
                width: 90*w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                        bottom: 25,
                        top: 25
                      ),
                      key: general,
                      width: 70*w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(36),
                        color: Theme.of(context).colorScheme.surface
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 10,),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              'General',
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
                          const SizedBox(height: 30,),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: SizedBox(
                              width: 25*w,
                              child: Image.asset(
                                'assets/images/logo.png',
                              ),
                            ),
                          ),
                          const SizedBox(height: 30,),
                          const HelpDescription(filename: 'assets/markdown/GeneralHelp.md', height: 150)
                        ],
                      )
                    ),
                  ]
                ),
              ),
              imageDescription(
                'assets/images/HomePage.png', 
                'assets/markdown/HomeHelp.md',
                MainAxisAlignment.center,
                home,
                150
              ),
              imageDescription(
                'assets/images/Navbar.png', 
                'assets/markdown/NavigationHelp.md', 
                MainAxisAlignment.center,
                navigation,
                215
              ),
              imageDescription(
                'assets/images/AboutPage.png', 
                'assets/markdown/AboutHelp.md',
                MainAxisAlignment.center,
                about,
                150
              ),
              imageDescription(
                'assets/images/JobPage.png', 
                'assets/markdown/Jobhelp.md',
                MainAxisAlignment.center,
                job,
                175
              ),
              imageDescription(
                'assets/images/ProfilePage.png', 
                'assets/markdown/Profilehelp.md',
                MainAxisAlignment.center,
                profile,
                175
              ),
              imageDescription(
                'assets/images/AIChatBot.png', 
                'assets/markdown/ChatBotHelp.md',
                MainAxisAlignment.center,
                chat,
                220
              ),
              imageDescription(
                'assets/images/ExtractionPage.png', 
                'assets/markdown/ExtractionHelp.md',
                MainAxisAlignment.center,
                extract,
                150
              ),
              imageDescription(
                'assets/images/EditorPage.png', 
                'assets/markdown/EditorHelp.md',
                MainAxisAlignment.center,
                editor,
                150
              ),
              imageDescription(
                'assets/images/SurveyPage.png', 
                'assets/markdown/SurveyHelp.md', 
                MainAxisAlignment.center, 
                survey, 
                170
              )
            ],
          ),
        ),
      ),
    );
  }
}