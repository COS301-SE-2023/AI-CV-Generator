import 'package:ai_cv_generator/dio/client/AIApi.dart';
import 'package:ai_cv_generator/dio/client/fileApi.dart';
import 'package:ai_cv_generator/dio/client/userApi.dart';
import 'package:ai_cv_generator/models/aimodels/AIEmployment.dart';
import 'package:ai_cv_generator/models/aimodels/AIInput.dart';
import 'package:ai_cv_generator/models/aimodels/AILink.dart';
import 'package:ai_cv_generator/models/aimodels/AIQualification.dart';
import 'package:ai_cv_generator/models/aimodels/AIReference.dart';
import 'package:ai_cv_generator/models/aimodels/AISkill.dart';
import 'package:ai_cv_generator/models/aimodels/CVData.dart';
import 'package:ai_cv_generator/models/user/Employment.dart';
import 'package:ai_cv_generator/models/user/Link.dart';
import 'package:ai_cv_generator/models/user/Qualification.dart';
import 'package:ai_cv_generator/models/user/Reference.dart';
import 'package:ai_cv_generator/models/user/Skill.dart';
import 'package:ai_cv_generator/models/user/UserModel.dart';
import 'package:ai_cv_generator/pages/template/Template.dart';
import 'package:ai_cv_generator/pages/util/errorMessage.dart';
import 'package:ai_cv_generator/pages/util/fileView.dart';
import 'package:ai_cv_generator/pages/util/successMessage.dart';
import 'package:ai_cv_generator/pages/widgets/EmptyCV.dart';
import 'package:ai_cv_generator/pages/widgets/buttons/appBarButton.dart';
import 'package:ai_cv_generator/pages/widgets/buttons/customizableButton.dart';
import 'package:ai_cv_generator/pages/widgets/chatBotView.dart';
import 'package:ai_cv_generator/pages/widgets/loadingScreens/loadingScreen.dart';
import 'package:ai_cv_generator/pages/widgets/navdrawer.dart';
import 'package:ai_cv_generator/pages/widgets/personaldetails.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'package:flutter/painting.dart' as paint;
import 'dart:math' as math;

import 'package:intl/intl.dart';

GlobalKey<ChatBotViewState> chatBotKey = GlobalKey();
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
  ScreenStatus status = ScreenStatus.empty;

  // variables
  UserModel? model;
  CVData? data;
  List<Widget> list = [];
  PlatformFile? file;
  bool isChatBotVisible = false;

  ChatBotView chatBot = const ChatBotView();

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
  // Off
  noShowButton() {
    setState(() {
      showButtons = false;
    });
  }

  // CV AI Loading screen
  setCVLoadingOn() {
    setState(() {
      status = ScreenStatus.loading;
    });
  }

  setCVLoadingOff() {
    setState(() {
      status = ScreenStatus.empty;
    });
  }

  // CV AI Error screen
  // On
  setCVErrorOn() {
    setState(() {
      status = ScreenStatus.error;
    });
  }

  setCVError() {
    setState(() {
      status = ScreenStatus.empty;
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

  // Coverters
  // UserModel to AiInput
  AIInput userModelToInput(UserModel model) { 
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    List<AIEmployment> exp = [];
    for (Employment emp in model.employmenthistory??[]) {
      exp.add(
        AIEmployment(
          company: emp.company, 
          jobTitle: emp.title, 
          startDate: formatter.format(emp.startdate), 
          endDate: formatter.format(emp.enddate)
          )
      );
    }
    List<AIQualification> qual = [];
    for (Qualification qua in model.qualifications??[]) {
      qual.add(
        AIQualification(
          qualification: qua.qualification, 
          institution: qua.intstitution, 
          startDate: formatter.format(qua.date), 
          endDate: formatter.format(qua.endo)
        )
      );
    }
    List<AILink> links = [];
    for (Link lin in model.links??[]) {
      links.add(
        AILink(
          url: lin.url
        )
      );
    }
    List<AIReference> references = [];
    for (Reference ref in model.references??[]) {
      references.add(
        AIReference(
          description: ref.description,
          contact: ref.contact
        )
      );
    }
    List<AISkill> skills = [];
    for (Skill skill in model.skills??[]) {
      skills.add(
        AISkill(
          skill: skill.skill,
          level: skill.level.toString(),
          reason: skill.reason
        )
      );
    }
    return AIInput(
      firstname: model.fname, 
      lastname: model.lname, 
      email: model.email, 
      phoneNumber: model.phoneNumber, 
      location: model.location, 
      description: model.description, 
      experience: exp, 
      qualifications: qual, 
      links: links,
      references: references,
      skills: skills
    );
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
      nameController.text = model!.fname;
      setOffLoadingScreen();
    });
    FileApi.getFiles().then((value) {
      for (var element in value!) {
        paint.ImageProvider prov = paint.MemoryImage(element.cover);
        list.add(add(element.filename,prov));
      }
        setState(() {
      });
    });
    super.initState();
  }

  // Builders
  // CV file builder
  Widget add(String filename,paint.ImageProvider prov) {
  return OutlinedButton(
    onPressed: ()  {
      FileApi.requestFile(filename: filename).then((value) {
        showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              child: FileView(file: value,)
            );
        });
      });

    },
    child: RotatedBox(
        quarterTurns: 2,
        child: 
        Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationY(math.pi),
          child: Image(
            image: ResizeImage(
              prov,
              width: 595~/2.5,
              height: 841~/2.5
            )
          ),
        )
      ),
    );
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
                padding: EdgeInsets.fromLTRB(w*8, h*3, 0,h*1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 0, 2*w, 0),
                      width: w*25,
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
                                CustomizableButton(
                                  text: "Survey", 
                                  width: 7*w, 
                                  height: 5*h, 
                                  onTap: () async {
                                    Home.ready = false;
                                    Home.adjustedModel = model;
                                    noShowButton();
                                    await showDialog(
                                      context: context, 
                                      builder: (BuildContext context) {
                                        return Dialog(
                                          backgroundColor: Colors.transparent,
                                          child: ConstrainedBox(
                                            constraints: const BoxConstraints(maxWidth: 800),
                                            child: const PersonalDetailsForm()
                                          )
                                        );
                                      }
                                    );
                                    if (Home.ready == false) return;
                                    showButton();
                                    setCVLoadingOn();
                                    data = await AIApi.generateAI(data: userModelToInput(Home.adjustedModel!));
                                    if (data != null && data!.description == null) {
                                      setCVErrorOn();
                                    }
                                    generated = true;
                                    setCVLoadingOff();
                                  },
                                  fontSize: w*0.8
                                ),
                                SizedBox(width: 4*w,),
                                CustomizableButton(
                                  text: "Upload", 
                                  width: 7*w, 
                                  height: 5*h, 
                                  onTap: () {
                                    print(model!.toJson());
                                  },
                                  fontSize: w*0.8
                                )
                              ],
                            ),
                          ),
                          if (showButtons)
                          Container(
                            padding: EdgeInsets.only(
                              top: h*2
                            ),
                            width: 30*w,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomizableButton(
                                  text: " Re-Generate", 
                                  width: 6*w, 
                                  height: 5*h, 
                                  onTap: () async {
                                    generated = false;
                                    noShowButton();
                                    setCVLoadingOn();
                                    data = await AIApi.generateAI(data: userModelToInput(Home.adjustedModel!));
                                    if (data != null && data!.description == null) {
                                      setCVErrorOn();
                                    }
                                    showButton();
                                    generated = true;
                                    setCVLoadingOff();
                                  },
                                  fontSize: w*0.7
                                ),
                                SizedBox(width: 1*w,),
                                CustomizableButton(
                                  text: "Expand", 
                                  width: 6*w, 
                                  height: 5*h, 
                                  onTap: () {},
                                  fontSize: w*0.7
                                ),
                                SizedBox(width: 1*w,),
                                CustomizableButton(
                                  text: "Download", 
                                  width: 6*w, 
                                  height: 5*h, 
                                  onTap: () {},
                                  fontSize: w*0.7
                                ),
                                SizedBox(width: 1*w,),
                                CustomizableButton(
                                  text: "Share", 
                                  width: 6*w, 
                                  height: 5*h, 
                                  onTap: () {},
                                  fontSize: w*0.7
                                )
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
                                data: data??CVData()
                              ) : EmptyCVScreen(status: status,)
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        left: 2.5*w
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 2*h,),
                          Align(
                            alignment: Alignment.topCenter,
                            child: Text(
                              "PastCVs",
                              style: TextStyle(fontSize: 2.6*h),
                              ),
                          ),
                          SizedBox(height: 2.4*h,),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(20)),
                              border: Border.all(
                                color: const Color.fromARGB(0, 0, 0, 0),
                              ),
                              color: Theme.of(context).colorScheme.surface,
                            ),
                            child: SizedBox(
                              width: 20*w,
                              height: 78*h,
                              child: Center(
                                child: Transform.scale(
                                  scale: 0.9,
                                  child: Container(
                                    child: 
                                      list.isNotEmpty?
                                      SingleChildScrollView(
                                        scrollDirection: Axis.vertical,
                                        child: Wrap(
                                            spacing: 8,
                                            runSpacing: 8,
                                            children: [
                                              ...list
                                            ]
                                        )
                                      ) : Center(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.insert_drive_file,color: Colors.grey,size: w*h*1,),
                                          SizedBox(height: w*h*0.2),
                                          const Text("No CVs...", 
                                          style: TextStyle(
                                            color: Colors.grey
                                          )
                                          ),
                                        ],
                                      ),
                                    )
                                  ),
                                )
                              )
                            )
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 1.1*w,
                    ),
                    
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 70*h,
                        ),
                        SizedBox(
                          child: IconButton(
                            iconSize: h*w*0.2,
                            color: Theme.of(context).colorScheme.secondary,
                            onPressed: () {
                              // /setState(() {chatBotKey.currentState!.visible = false;});
                              showDialog(
                                barrierColor: Color(0x01000000),
                                context: context, 
                                builder: (BuildContext context) {
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left:w*70,
                                          right: 0,
                                          top: h*4,
                                          bottom: 0
                                        ),
                                        child: Column(
                                          children: <Widget>[
                                            chatBot
                                          ],
                                        ),
                                      )
                                    ],
                                  );
                                }
                              );
                            },
                            icon: const Icon(Icons.message),
                          ),
                        ),
                      ],
                    ),
                  
                  ]
                ),
              )
            )
          ],
        ),
      )
    );
  }

}