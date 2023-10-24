import 'dart:typed_data';

import 'package:ai_cv_generator/api/downloadService.dart';
import 'package:ai_cv_generator/api/pdfApi.dart';
import 'package:ai_cv_generator/dio/client/AIApi.dart';
import 'package:ai_cv_generator/dio/client/fileApi.dart';
import 'package:ai_cv_generator/dio/client/userApi.dart';
import 'package:ai_cv_generator/dio/response/AuthResponses/Code.dart';
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
import 'package:ai_cv_generator/pages/template/TemplateChoice.dart';
import 'package:ai_cv_generator/pages/util/editor.dart';
import 'package:ai_cv_generator/pages/util/errorMessage.dart';
import 'package:ai_cv_generator/pages/util/filePrompt.dart';
import 'package:ai_cv_generator/pages/util/fileView.dart';
import 'package:ai_cv_generator/pages/util/inputEditor.dart';
import 'package:ai_cv_generator/pages/util/namePromt.dart';
import 'package:ai_cv_generator/pages/util/successMessage.dart';
import 'package:ai_cv_generator/pages/widgets/EmptyCV.dart';
import 'package:ai_cv_generator/pages/widgets/buttons/appBarButton.dart';
import 'package:ai_cv_generator/pages/widgets/buttons/customizableButton.dart';
import 'package:ai_cv_generator/pages/widgets/buttons/customizableIconButton.dart';
import 'package:ai_cv_generator/pages/widgets/chatBotView.dart';
import 'package:ai_cv_generator/pages/widgets/extractionView.dart';
import 'package:ai_cv_generator/pages/widgets/loadingscreens/loadingScreen.dart';
import 'package:ai_cv_generator/pages/widgets/navdrawer.dart';
import 'package:ai_cv_generator/pages/widgets/personaldetails.dart';
import 'package:ai_cv_generator/pages/widgets/shareCV.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'package:flutter/painting.dart' as paint;
import 'dart:math' as math;

import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

GlobalKey<ChatBotViewState> chatBotKey = GlobalKey();

// ignore: must_be_immutable
class HomeTestWidget extends StatefulWidget {
  HomeTestWidget({super.key});
  UserModel? adjustedModel;
  bool ready = false;
  @override
  State<StatefulWidget> createState() =>  _HomeTestWidgetState();
}

class _HomeTestWidgetState extends State<HomeTestWidget> {
  @override
  Widget build(BuildContext context) {
    // Example: You can pass custom data to Home by modifying the 'model' property
    // final UserModel customModel = UserModel(); // Create a custom UserModel
    // Home.adjustedModel = customModel; // Set the adjustedModel property
    return Material(
      child: Home(), // Render the original Home widget
    );
  }

}

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
  AIInput? aiInput;

  Uint8List? bytes;

  // variables
  UserModel? model;
  CVData? data = CVData();
  List<Widget> list = [];
  PlatformFile? file;
  bool isChatBotVisible = false;

  // template colours
  ColorSet colors = ColorSet();
  

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

  setCVExtractLoadingOn() {
    setState(() {
      status = ScreenStatus.extarction;
    });
  }

  setCVExtractLoadingOff() {
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

  Future<bool> extractionViewUpdate(AIInput aiInput, PlatformFile file) async {
    return await ExtractionView().showModal(context, file, aiInput);
  }

  // Updatable Widgets
  TextEditingController nameController = TextEditingController();
  Stream<String> sampleListener(TextEditingController controller) async* {
    while (true) {
      await Future.delayed(const Duration(milliseconds: 100));
      yield controller.value.text;
    }
  } 

  // Update PDF
  Future<void> updatePdf() async {
    if (!generated) return;
    bytes = await templateChoice(data!, option, colors);
    setState(() {
      
    });
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

  updateFiles() {
    list = [];
    FileApi.getFiles().then((value) {
      for (var element in value!) {
        paint.ImageProvider prov = paint.MemoryImage(element.cover);
        list.add(add(element.filename,prov));
      }
        setState(() {
      });
    });
  }

  getFileName(Uint8List bytes) async {
    String? name = await promptName();
    if (name == null) return;
    name = name.replaceAll(" ", "_");
    Code code = await FileApi.uploadFile(file: PlatformFile(name: '$name.pdf', size: bytes.length, bytes: bytes));
    if (code == Code.requestFailed) {
      showError("Something went wrong!");
      return;
    } else if (code == Code.failed) {
      showError("File with name already exists!");
      getFileName(bytes);
      return;
    } else {
      showSuccess("File uploaded sucessfully!");
      updateFiles();
    }
  }

  // Initialize State
  @override
  void initState() {
    colors.setColorSetA();
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
  return InkWell(
    onTap: ()  {
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

  // Display PDF
  showPdf(PlatformFile file) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          child: FileView(file: file,),
        );
      }
    );
  }

  nullSafeInputData(AIInput input) {
    input.description ??= 'Description';
    input.email ??= 'Email';
    input.firstname ??='First Name';
    input.lastname ??='Last Name';
    input.location ??='Location';
    input.phoneNumber ??='Phone Number';
    for (AIEmployment emp in  input.experience) {
      emp.company ??= 'Company';
      emp.jobTitle ??= 'Job Title';
      emp.endDate ??= 'End Date';
      emp.startDate ??= 'Start Date';
    }
    for (AIQualification qua in input.qualifications) {
      qua.qualification ??= 'Qualification';
      qua.institution ??= 'Instatution';
      qua.endDate ??= 'End Date';
      qua.startDate ??= 'Start Date';
    }
    for (AISkill skill in input.skills) {
      skill.skill ??= 'Skill';
      skill.reason ??= 'Reason';
      skill.level ??= '5';
      if (skill.level != '1'||skill.level != '1'||skill.level != '1'||skill.level != '1'||skill.level != '1') {
        skill.level = '5';
      }
    }
    for (AILink lin in input.links) {
      lin.url ??= 'Url';
    }
    for (AIReference ref in input.references) {
      ref.contact ??= 'Contact';
      ref.description ??= 'Description';
    }
    return input;
  }

  CVData nullSafeOutputData(CVData outputData) {
    outputData.description ??='Description';
    outputData.email ??='Email';
    outputData.firstname ??='First Name';
    outputData.lastname ??='Last Name';
    outputData.location ??='Location';
    outputData.phoneNumber ??='Phone Number';
    for (AIEmployment emp in  outputData.employmenthistory??[]) {
      emp.company ??= 'Company';
      emp.jobTitle ??= 'Job Title';
      emp.endDate ??= 'End Date';
      emp.startDate ??= 'Start Date';
    }
    for (AIQualification qua in outputData.qualifications??[]) {
      qua.qualification ??= 'Qualification';
      qua.institution ??= 'Instatution';
      qua.endDate ??= 'End Date';
      qua.startDate ??= 'Start Date';
    }
    for (AISkill skill in outputData.skills??[]) {
      skill.skill ??= 'Skill';
      skill.reason ??= 'Reason';
      skill.level ??= '5';
      if (skill.level != '1'||skill.level != '1'||skill.level != '1'||skill.level != '1'||skill.level != '1') {
        skill.level = '5';
      }
    }
    for (AILink lin in outputData.links??[]) {
      lin.url ??= 'Url';
    }
    for (AIReference ref in outputData.references??[]) {
      ref.contact ??= 'Contact';
      ref.description ??= 'Description';
    }

    return outputData;
  }

  // Display PDF
  Future<PlatformFile?> confirmPdf(PlatformFile? file) async {
    if (file == null) return file; 
    FilePrompt prompt = FilePrompt(file: file);
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          child: prompt,
        );
      }
    );
    if (prompt.ready) {
      return prompt.file;
    } else {
      return null;
    }
  }
  // Share Pdf
  void requirementsforshareUpdate(PlatformFile file) {
    requirementsforshare(context, file);
    setState(() {});
  }

  Future<AIInput?> extractMenu(AIInput aiInput, Uint8List bytes) async {
    InputEditor editor = InputEditor(data: nullSafeInputData(aiInput), bytes: bytes);
    await showDialog(
      context: context, 
      builder: (context) {
        return SizedBox(
          width: 100,
          height: 800,
          child: editor,
        );
      }
    );
    return editor.data;
  }

  Future<void> showCV() async {
    Editor editor = Editor(data: nullSafeOutputData(data!), option: option, colors: colors,);
    await showDialog(
      context: context, 
      builder: (context) {
        return SizedBox(
          width: 100,
          height: 800,
          child: editor,
        );
      }
    );
    setCVLoadingOn();
    setState(() {
      colors = editor.colors;
      option = editor.option;
      data = editor.data;
    });
    bytes = await templateChoice(data!, option, colors);
    setCVLoadingOff();
  }

  Future<String?> promptName() async {
    NamePrompt prompt = NamePrompt();
    await showDialog(
      context: context, 
      builder: (context) {
        return Container(
          child: prompt,
        );
      }
    );

    return prompt.name;
  }

  // Build
  @override
  Widget build(BuildContext context) {

    // Template

    // Window Resizing
    Size screenSize = MediaQuery.of(context).size;
    double w = screenSize.width/100;
    double h = screenSize.height/100; 

    // Widget Builders
    // Template Option builder
    Widget templateChoices(TemplateOption pick, String assetPath) {
      Color isPicked = Colors.transparent;
      if (option == pick) isPicked = Colors.blue;
      return Container(
        padding: EdgeInsets.only(
          bottom: h*0.2
        ),
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () {
              colors.setColorSetTemplateChoice(pick);
              setState(() {
                option = pick;
              });
              updatePdf();
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: isPicked,
                  width: 3
                ),
              ),
              child: Image.asset(
                assetPath,
                fit: BoxFit.fitHeight,
              ),
            )
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
          SizedBox(
            width: 80,
            height: 28,
            child: InkWell(
              hoverColor: Colors.transparent,
              onTap: () {
                  toJobs();
              },
              child: const AppBarButtonStyle(text: "Jobs"),
            ),
          ),
          SizedBox(width: 3.2*w,),
          SizedBox(
            width: 80,
            height: 28,
            child: InkWell(
              hoverColor: Colors.transparent,
              onTap: () {
                  toAbout();
              },
              child: const AppBarButtonStyle(text: "About")
            ),
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
                  Text(model != null ? model!.fname : "user",),
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
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Container(
              padding: EdgeInsets.fromLTRB(0, h*3, 0,h*1),
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: Text(
                              "TEMPLATES",
                              style: TextStyle(fontSize: 2.6*h,overflow: TextOverflow.fade),
                              ),
                          ),
                          SizedBox(height: 1.6*h,),
                          SingleChildScrollView(
                            child: SizedBox(
                              height: 70*h,
                              child: GridView.count(
                                crossAxisCount: 1,
                                children:[
                                  templateChoices(TemplateOption.templateA, "assets/images/templateARework.png"),
                                  templateChoices(TemplateOption.templateB, "assets/images/templateBRework.png"),
                                  templateChoices(TemplateOption.templateC, "assets/images/templateCRework.png"),
                                  templateChoices(TemplateOption.templateD, "assets/images/templateDRework.png"),
                                  templateChoices(TemplateOption.templateE, "assets/images/templateERework.png"),
                                  templateChoices(TemplateOption.templateF, "assets/images/templateFRework.png")
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
                                  generated = false;
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
                                  aiInput = userModelToInput(Home.adjustedModel!);
                                  data = await AIApi.generateAI(data: aiInput!);
                                  if (data == null || data!.description == null) {
                                    setCVErrorOn();
                                    return;
                                  }
                                  data = nullSafeOutputData(data!);
                                  bytes = await templateChoice(data!, option, colors);
                                  if (bytes == null) {
                                    setCVError();
                                    return;
                                  }
                                  generated = true;
                                  setCVLoadingOff();
                                },
                                fontSize: w*0.8
                              ),
                              SizedBox(width: 2*w,),
                              CustomizableButton(
                                text: "Upload", 
                                width: 7*w, 
                                height: 5*h, 
                                onTap: () async {
                                  // final _formKey = GlobalKey<FormState>();
                                  // TextEditingController urlC = TextEditingController();
                                  // showDialog(
                                  //   context: context,
                                  //   builder: (BuildContext context) {
                                  //     return Dialog(
                                  //       child: FractionallySizedBox(
                                  //         widthFactor: 0.4,
                                  //         child: Container(
                                  //           padding: const EdgeInsets.all(16.0),
                                  //           child: Column(
                                  //             mainAxisSize: MainAxisSize.min,
                                  //             crossAxisAlignment: CrossAxisAlignment.start,
                                  //             children: [
                                  //               const Text(
                                  //                 'UPLOAD',
                                  //                 style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                                  //               ),
                                  //               const SizedBox(height: 16.0),
                                  //               Row(
                                  //                 crossAxisAlignment: CrossAxisAlignment.center,
                                  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  //                 children: [
                                  //                   Form(
                                  //                     key: _formKey,
                                  //                     child: Row(
                                  //                       crossAxisAlignment: CrossAxisAlignment.center,
                                  //                       children: [
                                  //                         Container(
                                  //                           width: 15*w, 
                                  //                           height: 8*h, 
                                  //                           child: TextFormField(
                                  //                             style: TextStyle(fontSize: 11),
                                  //                             textAlign: TextAlign.center,
                                  //                             key: const Key("url"),
                                  //                             decoration: const InputDecoration(
                                  //                               hintText: "URL",
                                  //                               border: OutlineInputBorder()
                                  //                             ),
                                  //                             controller: urlC,
                                  //                             // validator: (value) {
                                  //                             //   if (value == null || value.isEmpty) {
                                  //                             //     return 'Field is empty';
                                  //                             //   }
                                  //                             //   return null;
                                  //                             // },
                                  //                           ),
                                  //                         ),
                                  //                         const SizedBox(width: 8,),
                                  //                         CustomizableButton(
                                  //                           onTap: () {
                                  //                             if(_formKey.currentState!.validate() == true) {
                                  //                               //use url link
                                  //                               urlC.text;
                                  //                               Navigator.of(context).pop();
                                  //                             }
                                  //                           },
                                  //                           text: "Submit",
                                  //                           width: 7*w, 
                                  //                           height: 5*h, 
                                  //                           fontSize: w*0.8,
                                  //                         ),
                                  //                       ],
                                  //                     ),
                                  //                   ),
                                  //                   const Text("OR"),
                                  //                   CustomizableButton(
                                  //                     onTap: () async {
                                  //                       PlatformFile? file = await confirmPdf(await pdfAPI.pick_cvfile());
                                  //                       if (file == null) return;
                                  //                       generated = false;
                                  //                       noShowButton();
                                  //                       setCVExtractLoadingOn();
                                  //                       AIApi.extractPdf(file: file).then((value) async {
                                  //                         aiInput = value;
                                  //                         if (aiInput == null) {
                                  //                           showError("Something went wrong!");
                                  //                           setCVLoadingOff();
                                  //                           setCVErrorOn();
                                  //                           return;
                                  //                         }
                                  //                         aiInput = nullSafeInputData(aiInput!);
                                  //                         noShowButton();
                                  //                         setCVExtractLoadingOff();
                                  //                         aiInput = await extractMenu(aiInput!, file.bytes!);
                                  //                         if (aiInput == null) {
                                  //                           return;
                                  //                         }
                                  //                         setCVLoadingOn();
                                  //                         showButton();
                                  //                         data = await AIApi.generateAI(data: aiInput!);
                                  //                         setCVLoadingOff();
                                  //                         if (data == null || data!.description == null) {
                                  //                           setCVErrorOn();
                                  //                           return;
                                  //                         }
                                  //                         data = nullSafeOutputData(data!);
                                  //                         bytes = await templateChoice(data!, option, colors);
                                  //                         if (bytes == null) {
                                  //                           setCVError();
                                  //                           return;
                                  //                         }
                                  //                         generated = true;
                                  //                         setCVExtractLoadingOff();
                                  //                       });
                                  //                       setState(() {});
                                  //                       Navigator.of(context).pop();
                                  //                     }, 
                                  //                     text: "Upload CV",
                                  //                     width: 7*w, 
                                  //                     height: 5*h, 
                                  //                     fontSize: w*0.8
                                  //                   )
                                  //                 ],
                                  //               ),
                                  //             ],
                                  //           ),
                                  //         ),
                                  //       ),
                                  //     );
                                  //   },
                                  // );
                                  PlatformFile? file = await confirmPdf(await pdfAPI.pick_cvfile());
                                  if (file == null) return;
                                  generated = false;
                                  noShowButton();
                                  setCVExtractLoadingOn();
                                  aiInput = await AIApi.extractPdf(file: file);
                                  if (aiInput == null) {
                                    showError("Something went wrong!");
                                    setCVLoadingOff();
                                    setCVErrorOn();
                                    return;
                                  }
                                  aiInput = nullSafeInputData(aiInput!);
                                  noShowButton();
                                  setCVExtractLoadingOff();
                                  aiInput = await extractMenu(aiInput!, file.bytes!);
                                  if (aiInput == null) {
                                    return;
                                  }
                                  setCVLoadingOn();
                                  showButton();
                                  data = await AIApi.generateAI(data: aiInput!);
                                  setCVLoadingOff();
                                  if (data == null || data!.description == null) {
                                    setCVErrorOn();
                                    return;
                                  }
                                  data = nullSafeOutputData(data!);
                                  bytes = await templateChoice(data!, option, colors);
                                  if (bytes == null) {
                                    setCVError();
                                    return;
                                  }
                                  generated = true;
                                  setCVExtractLoadingOff();
                                },
                                fontSize: w*0.8
                              ),
                              if (generated)
                              SizedBox(width: 2*w,),
                              if (generated)
                              CustomizableButton(
                                text: 'Save', 
                                width: 7*w, 
                                height: 5*h, 
                                onTap: () async {
                                  if (bytes != null) {
                                    getFileName(bytes!);
                                  } else {
                                    showError("Something went wrong!");
                                    return;
                                  }
                                }, 
                                fontSize: w*0.8
                              )
                            ],
                          ),
                        ),
                        if (generated)
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
                                  data = await AIApi.generateAI(data: aiInput!);
                                  if (data == null || data!.description == null) {
                                    setCVErrorOn();
                                    return;
                                  }
                                  data = nullSafeOutputData(data!);
                                  bytes = await templateChoice(data!, option, colors);
                                  if (bytes == null) {
                                    setCVError();
                                    return;
                                  }
                                  showButton();
                                  generated = true;
                                  setCVLoadingOff();
                                },
                                fontSize: w*0.7
                              ),
                              SizedBox(width: 1*w,),
                              CustomizableButton(
                                text: "Edit", 
                                width: 6*w, 
                                height: 5*h, 
                                onTap: () async {
                                  if (data == null) {
                                    showError('Something went wrong!');
                                    return;
                                  }
                                  await showCV();
                                },
                                fontSize: w*0.7
                              ),
                              SizedBox(width: 1*w,),
                              CustomizableButton(
                                text: "Download", 
                                width: 6*w, 
                                height: 5*h, 
                                onTap: () async {
                                  if (bytes == null) {
                                    showError("Something went wrong!");
                                    return;
                                  }
                                  DownloadService.download(bytes!, downloadName: 'Untitled.pdf');
                                },
                                fontSize: w*0.7
                              ),
                              SizedBox(width: 1*w,),
                              CustomizableButton(
                                text: "Share", 
                                width: 6*w, 
                                height: 5*h, 
                                onTap: () async {
                                  if (bytes == null) {
                                    showError("Something went wrong!");
                                    return;
                                  }
                                  requirementsforshareUpdate(PlatformFile(name: 'Untitled.pdf', size: bytes!.length, bytes: bytes));
                                },
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
                              color:Theme.of(context).colorScheme.surface,
                            ),
                            child: 
                            generated == true?
                            Container(
                              padding: EdgeInsets.all(w*1),
                              width: 27*w,
                              height: 85*h,
                              child: SfPdfViewer.memory(bytes!),
                            ) : EmptyCVScreen(status: status,)
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(width: 2.5*w,),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      border: Border.all(
                        color: const Color.fromARGB(0, 0, 0, 0),
                      ),
                      color: Theme.of(context).colorScheme.surface,
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
                        child: CustomizableIconButton(
                          icon: Icons.message,
                          height: w*4,
                          width: w*4,
                          iconSize: w*h*0.2,
                          onTap: () {
                            showDialog(
                              barrierColor: const Color(0x01000000),
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
                        )
                      ),
                    ],
                  ),
                
                ]
              ),
            )
          )
        ],
      ),
      ),
    );
  }
}