import 'package:ai_cv_generator/dio/client/userApi.dart';
import 'package:ai_cv_generator/models/user/UserModel.dart';
import 'package:ai_cv_generator/pages/screens/underContruction.dart';
import 'package:ai_cv_generator/pages/util/errorMessage.dart';
import 'package:ai_cv_generator/pages/util/successMessage.dart';
import 'package:ai_cv_generator/pages/widgets/buttons/appBarButton.dart';
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
  // control variables
  bool wait = true; // Initial Loading screen

  // variables
  UserModel? model;

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
    nameController.text = model!.fname;
    setState(() {
      
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
      body: Container(
        child: Text("work in Progress"),
      ),
    );
  }

}