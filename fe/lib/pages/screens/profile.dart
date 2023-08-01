import 'dart:typed_data';
import 'package:ai_cv_generator/dio/client/fileApi.dart';
import 'package:ai_cv_generator/dio/client/userApi.dart';
import 'package:ai_cv_generator/models/user/Employment.dart';
import 'package:ai_cv_generator/models/user/UserModel.dart';
import 'package:ai_cv_generator/pages/widgets/breadcrumb.dart';
import 'package:ai_cv_generator/pages/widgets/cvHistory.dart';
import 'package:ai_cv_generator/pages/elements/elements.dart';
import 'package:ai_cv_generator/pages/widgets/employmentView.dart';
import 'package:ai_cv_generator/pages/util/imageCropper.dart';
import 'package:ai_cv_generator/pages/widgets/loadingScreen.dart';
import 'package:flutter/material.dart';
import '../widgets/linksView.dart';
import '../widgets/qualificationsView.dart';
import 'package:image_picker_web/image_picker_web.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  ProfileState createState() => ProfileState();
}

bool isEditingEnabled = false;

class ProfileState extends State<Profile> {
  final _formKey = GlobalKey<FormState>();
  UserModel? model;
  Image? image;
  @override
  void initState() {
    userApi.getUser().then((value) {
      if(value != null){
        model = value;
        setState(() {});
      }
    });
    FileApi.getProfileImage().then((value) {
      image = value;
      setState(() {
        
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(model == null || image == null) {
      return const LoadingScreen();
    }
    TextEditingController fnameC = TextEditingController(text: model!.fname);
    TextEditingController lnameC = TextEditingController(text: model!.lname);
    TextEditingController emailC = TextEditingController(text: model!.email);
    TextEditingController phoneNoC = TextEditingController(text: model!.phoneNumber);
    TextEditingController locationC = TextEditingController(text: model!.location);
    TextEditingController descripC = TextEditingController(text: model!.description);
    GlobalKey<LinksSectionState> linksKey = GlobalKey<LinksSectionState>();
    GlobalKey<QualificationsSectionState> qualificationsKey = GlobalKey<QualificationsSectionState>();
    GlobalKey<EmploymentSectionState> employhistoryKey = GlobalKey<EmploymentSectionState>();
    LinksSection linkC = LinksSection(key: linksKey, links: model!.links != null ? model!.links! : []);
    QualificationsSection qualificationsC = QualificationsSection(key: qualificationsKey, qualifications: model!.qualifications != null ? model!.qualifications! : []);
    EmploymentSection employmentC = EmploymentSection(key: employhistoryKey, employment: model!.employmenthistory != null ? model!.employmenthistory! : [Employment(company: 'ERROR', title: 'ERORR', startdate: DateTime.now(), enddate: DateTime.now(), empid: 0)]);
    DateTime time = DateTime.now();
    Future<void> actualupdate() async {
      model!.fname = fnameC.text;
      model!.lname = lnameC.text;
      model!.email = emailC.text;
      model!.phoneNumber = phoneNoC.text;
      model!.description = descripC.text;
      model!.location = locationC.text;
      linksKey.currentState?.update();
      qualificationsKey.currentState?.update();
      employhistoryKey.currentState?.update();
      await userApi.updateUser(user: model!);
    }
    
    void update() {
        DateTime nTime = DateTime.now();
        if (nTime.second - time.second > 30) {
          actualupdate();
          time = nTime;
        }
    }
    
    fnameC.addListener(update);
    lnameC.addListener(update);
    emailC.addListener(update);
    phoneNoC.addListener(update);
    locationC.addListener(update);
    descripC.addListener(update);

    void updateImage(Image img) {
    setState ((){ 
          image = Image(image:img.image );
        
      });
}

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
          ), 
          onPressed: () async { 
            await actualupdate();
            Navigator.pop(context);
          },
        ),
      actions: [
        IconButton(onPressed: () {}, 
        icon: const Icon(Icons.account_circle, size: profileButtonSize,), ),
        const SizedBox(width: 16,)
      ],
      ),
      body: SafeArea(
        child: Container(
        color: Colors.white,
        child: Stack(
          children: [
            const Breadcrumb(previousPage: "Home", currentPage: "Profile",),
          Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 128),
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 4,
                      child: Column(
                        children: [
                          const SizedBox(height: 184,),
                          SectionContainer(
                            child: Column(
                              children: [
                                SectionHeading(text: "ABOUT ME", alignment: Alignment.topLeft,),
                                TextFormField(
                                  controller: descripC,
                                  maxLines: 5,
                                  style: Theme.of(context).textTheme.bodyLarge,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: "Insert a description about yourself"
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16,),
                          employmentC,
                          const SizedBox(height: 16,),
                          SectionContainer(
                            child: Column(
                              children: [
                                SectionHeading(text: "CVs", alignment: Alignment.topLeft,),
                                CVHistory(context: context,),
                              ],
                            ),
                          )                  
                        ],
                      ),
                    ),
                  
                    const SizedBox(width: 128,),
                  
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () async {
                                await actualupdate();
                                Uint8List? imgByte =  await ImagePickerWeb.getImageAsBytes();
                                if(imgByte == null) {
                                  return;
                                }
                                imgByte = await imagecrop(context, imgByte);
                                if(imgByte != null){
                                  final changed = await FileApi.updateProfileImage(img: imgByte);
                                  image = changed;
                                  setState(() {});
                                }
                              },
                              child: CircleAvatar(
                                radius: 95.0,
                                backgroundColor: Theme.of(context).colorScheme.secondary,
                                child: CircleAvatar(
                                  radius: 90.0,
                                  backgroundImage: image!.image,
                                  backgroundColor: Colors.grey.shade300
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16,),
                          Wrap(
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            // mainAxisAlignment: MainAxisAlignment.end,
                            // mainAxisSize: MainAxisSize.min,
                            children: [
                              // Flexible(
                                // child: 
                                SectionInput(controller: fnameC, hint: "First Name", fontSize: 24,),
                              // ),
                              const SizedBox(width: 8,),
                              // Flexible(
                              //   child: 
                                SectionInput(controller: lnameC, hint: "Last Name", fontSize: 24,),
                              // ),
                            ]
                          ),
                          SectionInput(controller: emailC, hint: "Email", height: 34),
                          SectionInput(controller: locationC, hint: "Address", height: 34),
                          SectionInput(controller: phoneNoC, hint: "Phone number", height: 34,),
                          const SizedBox(height: 55,),
                          qualificationsC,
                          const SizedBox(height: 16,),
                          linkC
                        ],
                        )
                      ),
                    ],
                  ),
            ],),

          )
            ],
          )        
        )
      )
    );
  }
}

class TextInputField extends StatefulWidget {
  final TextEditingController editor;
  final TextAlign align;
  const TextInputField({super.key, required this.editor, required this.align});
  @override
  TextInputFieldState createState() => TextInputFieldState();
}

class TextInputFieldState extends State<TextInputField> {
  @override
  Widget build(BuildContext context) {
    TextEditingController editor = widget.editor;
    return TextFormField(
      textAlign: widget.align,
      controller: editor,
      autocorrect: true,
      onEditingComplete: () {
        editor.notifyListeners();
      },
    );
  }
}

class InputField extends StatefulWidget {
  final String label;
  final Widget widgetField;
  const InputField({super.key, required this.label, required this.widgetField});
  @override
  InputFieldState createState() => InputFieldState();
}

class InputFieldState extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column (
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.label),
          const SizedBox(height: 8,),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: widget.widgetField,
          )
        ],
      ),
    );
  }
}