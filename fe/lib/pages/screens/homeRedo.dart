import 'package:ai_cv_generator/dio/client/userApi.dart';
import 'package:ai_cv_generator/models/aimodels/CVData.dart';
import 'package:ai_cv_generator/models/user/UserModel.dart';
import 'package:ai_cv_generator/pages/template/Template.dart';
import 'package:ai_cv_generator/pages/util/errorMessage.dart';
import 'package:ai_cv_generator/pages/util/handleRouting.dart';
import 'package:ai_cv_generator/pages/util/successMessage.dart';
import 'package:ai_cv_generator/pages/widgets/EmptyCV.dart';
import 'package:ai_cv_generator/pages/widgets/buttons/appBarButton.dart';
import 'package:ai_cv_generator/pages/widgets/buttons/generalTextButton.dart';
import 'package:ai_cv_generator/pages/widgets/loadingScreens/loadingScreen.dart';
import 'package:ai_cv_generator/pages/widgets/navdrawer.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  static UserModel? adjustedModel;
  static bool ready = false;
  @override
  State<StatefulWidget> createState() => HomeState();

}

class HomeState extends State<Home> {

  // constants
  final TextStyle textStyle = const TextStyle(fontSize: 12);

  // control variables
  bool wait = true; // Initial Loading screen
  TemplateOption option = TemplateOption.templateA; // Default option on start
  bool showButtons = false;
  bool generated = false;

  // variables
  UserModel? model;
  CVData? data;

  // Error/Success Messaging
  showError(String message) {
    showMessage(message, context);
  }

  showSuccess(String message) {
    showHappyMessage(message, context);
  }

  // loading screens
  // On
  setOnLoadingScreen() {
    setState(() {
      wait = true;
    });
  }
  // Off
  setOffLoadingScreen() {
    setState(() {
      wait = false;
    });
  }

  // show buttons
  // On
  showButton() {
    setState(() {
      showButtons = true;
    });
  }

  noShowButton() {
    setState(() {
      showButtons = false;
    });
  }

  // Updatable Widgets
  TextEditingController nameController = TextEditingController();
  Stream<String> sampleListener(TextEditingController controller) async* {
    while (true) {
      await Future.delayed(const Duration(milliseconds: 100));
      yield controller.value.text;
    }
  } 

  // Routing
  toJobs() {
    Navigator.pushNamed(context, '/jobs');
  }

  toAbout() {
    Navigator.pushNamed(context, '/about');
  }

  toProfile() async {
    Navigator.pushNamed(context, '/profile');
    model = await UserApi.getUser();
    setState(() {
      nameController.text = model!.fname;
    });
  }

  toLogin() {
    Navigator.popUntil(context, ModalRoute.withName("/"));
  }

  // Initialize State
  @override
  void initState() {
    UserApi.getUser().then((value) {
      model = value;
      if (model == null) {
        showError("Something went wrong");
        toLogin();
      }
      nameController.text = model!.fname;
      setOffLoadingScreen();
    });
    super.initState();
  }


  // Build
  @override
  Widget build(BuildContext context) {
    // Window Resizing
    Size screenSize = MediaQuery.of(context).size;
    double w = screenSize.width/100;
    double h = screenSize.height/100; 

    // Widget Builders
    // Template Option builder
    Widget templateChoice(TemplateOption pick, String assetPath) {
      Color isPicked = Colors.transparent;
      if (option == pick) isPicked = Colors.blue;
      return Container(
        padding: EdgeInsets.only(
          bottom: h*0.2
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: isPicked,
            width: 3
          )
        ),
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () {
              setState(() {
                option = pick;
              });
            },
            child: Image(image: Image.asset(assetPath).image),
          )
        )
      );
    }


    // Loading Screen
    if(wait) {
      return const LoadingScreen();
    }
    
    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
        actions: [
          Transform.scale(
            scale: 0.8,
            child: SizedBox(
              width: 40*w,
            ),
          ),
          InkWell(
            onTap: () {
                toJobs();
            },
            child: const AppBarButtonStyle(text: "Jobs"),
          ),
          SizedBox(width: 3.2*w,),
          InkWell(
            onTap: () {
                toAbout();
            },
            child: const AppBarButtonStyle(text: "About")
          ),
          SizedBox(width: 4*w,),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () async {
                toProfile();
              }, 
              child: Row(
                children: [
                  Text(model!.fname,),
                  SizedBox(width: 0.4*w,),
                  const Icon(Icons.account_circle),
                  SizedBox(width: 1.6*w,),
                ],
              )
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Row(
          children: [
            Center(
              child: Container(
                padding: EdgeInsets.fromLTRB(w*5, h*3, w*1,h*1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 0, 2*w, 0),
                      width: w*30,
                      height: h*85,
                      child: Container(
                        padding: EdgeInsets.fromLTRB(2.4*w,2.4*h, 2.4*w, 2.4*h),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(20)),
                          border: Border.all(
                            color: const Color.fromARGB(0, 0, 0, 0),
                          ),
                          color: Theme.of(context).colorScheme.surface,
                        ),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.topCenter,
                              child: Text(
                                "TEMPLATES",
                                style: TextStyle(fontSize: 2.6*h),
                                ),
                            ),
                            SizedBox(height: 1.6*h,),
                            SingleChildScrollView(
                              child: SizedBox(
                                height: 70*h,
                                child: GridView.count(
                                  crossAxisCount: 1,
                                  children:[
                                    templateChoice(TemplateOption.templateA, "assets/images/TemplateAAsset.jpg"),
                                    templateChoice(TemplateOption.templateB, "assets/images/TemplateBAsset.png"),
                                    templateChoice(TemplateOption.templateC, "assets/images/TemplateCAsset.jpg")
                                  ],
                                )
                              ),
                            )
                          ],
                        )
                      )
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(2*w, 0, 2*w, 0),
                      width: 35*w,
                      height: 85*h,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 30*w,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 5*h,
                                  width: 10*w, 
                                  child: InkWell(
                                    onTap: () async {
                                      
                                  
                                    }, 
                                    child: const GeneralButtonStyle(text: "Survey"),
                                  ),
                                ),
                                SizedBox(width: 5*w,),
                                SizedBox(
                                  height: 5*h,
                                  width: 10*w, 
                                  child: InkWell(
                                    onTap: () async {
                                      
                                    }, 
                                    child: const GeneralButtonStyle(text: "Upload"),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 4*h,),
                          Expanded(
                            child: Container(
                              width: 35*w,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(Radius.circular(20)),
                                border: Border.all(
                                  color: const Color.fromARGB(0, 0, 0, 0),
                                ),
                                color: Theme.of(context).colorScheme.surface,
                              ),
                              child: 
                              generated == true?
                              Template(
                                option: option, 
                                data: CVData(

                                )
                              ) : const EmptyCVScreen()
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        
                      ),
                    )
                  ]
                )
              )
            )
          ],
        ),
      )
    );
  }

}