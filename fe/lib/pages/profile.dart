import 'dart:typed_data';

import 'package:ai_cv_generator/dio/client/fileApi.dart';
import 'package:ai_cv_generator/dio/client/userApi.dart';
import 'package:ai_cv_generator/models/files/FileModel.dart';
import 'package:ai_cv_generator/models/user/Employment.dart';
import 'package:ai_cv_generator/models/user/Link.dart';
import 'package:ai_cv_generator/models/user/Qualification.dart';
import 'package:ai_cv_generator/models/user/UserModel.dart';
import 'package:flutter/material.dart';
import 'linksView.dart';
import 'qualificationsView.dart';

class Profile extends StatefulWidget {
  Profile({super.key,required this.model});
  UserModel model;


  @override
  ProfileState createState() => ProfileState(model: model);
}

bool isEditingEnabled = false;

class ProfileState extends State<Profile> {
  final _formKey = GlobalKey<FormState>();
  UserModel model;

  ProfileState({
    required this.model
  });

  @override
  Widget build(BuildContext context) {
    String email =  model.email != null ? model.email! : "No email...";
    String phoneNumber =  model.phoneNumber != null? model.phoneNumber!:"No phone number...";
    String location = model.location != null ? model.location!:"No location...";
    String aboutMe = model.description!= null? model.description!:"No description...";
    
    TextEditingController fnameC = TextEditingController(text: model.fname);
    TextEditingController lnameC = TextEditingController(text: model.lname);
    TextEditingController emailC = TextEditingController(text: email);
    TextEditingController phoneNoC = TextEditingController(text: phoneNumber);
    TextEditingController locationC = TextEditingController(text: location);
    TextEditingController descripC = TextEditingController(text: aboutMe);

    GlobalKey<LinksSectionState> linksKey = GlobalKey<LinksSectionState>();
    LinksSection linkC = LinksSection(key: linksKey, links: model.links != null ? model.links! : []);
    GlobalKey<QualificationsSectionState> qualificationsKey = GlobalKey<QualificationsSectionState>();
    QualificationsSection qualificationsC = QualificationsSection(key: qualificationsKey, qualifications: model.qualifications != null ? model.qualifications! : []);

    DateTime time = DateTime.now();
    void ActualUpdate() {
      print("Actual Update");
      model.fname = fnameC.text;
      model.lname = lnameC.text;
      model.email = emailC.text;
      model.phoneNumber = phoneNoC.text;
      model.description = descripC.text;
      model.location = locationC.text;
      model.links = linksKey.currentState?.update();
      model.qualifications = qualificationsKey.currentState?.update();
      // model.employhistory = employhistoryKey.currentState?.update();
      userApi.updateUser(user: model);
    }
    void update() {
        DateTime nTime = DateTime.now();
        if (nTime.second - time.second > 30) {
          ActualUpdate();
          time = nTime;
        }
    }
    
    fnameC.addListener(update);
    lnameC.addListener(update);
    emailC.addListener(update);
    phoneNoC.addListener(update);
    locationC.addListener(update);
    descripC.addListener(update);
    
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color.fromARGB(255, 0, 63, 114),
          ), 
          onPressed: () { 
            ActualUpdate();
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      body: Container( 
        color: Colors.white,
        child:Padding(
          padding: const EdgeInsets.symmetric(vertical: 42, horizontal: 60),
          child: Form(
            key: _formKey,
            child: Row(
              children: [
                
                Expanded(
                  flex: 2,
                  child: ListView(
                    padding: const EdgeInsets.only(right: 16),
                    children: [

                      Column(
                        children: [
                          const SectionHeading(heading: "ABOUT ME", align: Alignment.topLeft,),
                          SectionInput(inputWidget: TextFormField(controller: descripC, maxLines: 9, decoration: const InputDecoration(border: OutlineInputBorder(),),),),
                        ],
                      ),
                      const SizedBox(height: 10,),
                      Column(
                        children: [
                          const SectionHeading(heading: "EDUCATION"),
                          qualificationsC,                          
                        ],
                      ),
                      const SizedBox(height: 10,),
                      // Column(
                      //   children: [
                      //     const SectionHeading(heading: "WORK EXPERIENCE"),
                      //     SectionInput(inputWidget: TextFormField(controller: workExperienceC, maxLines: 9, decoration: const InputDecoration(border: OutlineInputBorder(),),),),
                      //   ],
                      // ),

                      const Column(
                        children: [
                          SectionHeading(heading: "CVs", align: Alignment.topLeft,),
                          CVHistory(),
                        ],
                      ),
                                          
                    ],
                  ),
                ),
                
                const SizedBox(width: 15,),
                
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const SectionHeading(heading: "PROFILE", align: Alignment.topRight,),
                      SizedBox(
                        width: 200,
                        child:
                         Column(
                          children: [
                            SectionInput(inputWidget: TextFormField(controller: fnameC, textAlign: TextAlign.right, decoration: const InputDecoration(border: InputBorder.none,),),),
                            SectionInput(inputWidget: TextFormField(controller: lnameC, textAlign: TextAlign.right, decoration: const InputDecoration(border: InputBorder.none,),),),
                            SectionInput(inputWidget: TextFormField(controller: emailC, textAlign: TextAlign.right, decoration: const InputDecoration(border: InputBorder.none,),),),
                            SectionInput(inputWidget: TextFormField(controller: locationC, textAlign: TextAlign.right, decoration: const InputDecoration(border: InputBorder.none,),),),
                            SectionInput(inputWidget: TextFormField(controller: phoneNoC, textAlign: TextAlign.right, decoration: const InputDecoration(border: InputBorder.none,),),),
                          ],
                        )
                      ),
                      const SectionHeading(heading: "LINKS"),
                      Expanded(
                          child: ListView(
                          padding: const EdgeInsets.only(right: 16),
                          children: [
                          linkC,
                          ],
                        ),
                      ),
                    ],
                  )
                ),
              ],
            ),
          )
        )
      )
    );
  }
}

class SectionHeading extends StatelessWidget {
  final String heading;
  final Alignment? align;
  const SectionHeading({super.key, required this.heading, this.align});

  @override
  Widget build(BuildContext context) {

    return Align(
      alignment: align != null? align!: Alignment.topLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Column(
          children: [
            Text(
              heading,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            // SizedBox(height: 16),
          ],
        )
      )
    );
  }
}

class SectionInput extends StatefulWidget {
  final Widget inputWidget;
  const SectionInput({super.key, required this.inputWidget});
  @override
  SectionInputState createState() => SectionInputState();
}

class SectionInputState extends State<SectionInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: widget.inputWidget,
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
                color: Colors.grey,
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

class CVHistory extends StatefulWidget {
  const CVHistory({super.key});

  @override
  CVHistoryState createState() => CVHistoryState();
}

class CVHistoryState extends State<CVHistory> {
  List<Widget> images = [];
  @override
  // void initState() {
  //   FileApi.getFiles().then((value) {
  //     if(value != null) {
  //       value.forEach((element) {
  //         add(element.cover);
  //       });
  //     }
  //   });
  //   super.initState();
  // }

  void add(Uint8List cover) {
    images.add(
      Image.memory(cover, fit: BoxFit.scaleDown,)
    );
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 200, child:
    SingleChildScrollView(child: 
    Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          ...images,
        ], 
    )));
  }
}