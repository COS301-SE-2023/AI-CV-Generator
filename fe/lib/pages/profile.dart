import 'package:ai_cv_generator/dio/client/fileApi.dart';
import 'package:ai_cv_generator/dio/client/userApi.dart';
import 'package:ai_cv_generator/models/user/Employment.dart';
import 'package:ai_cv_generator/models/user/UserModel.dart';
import 'package:ai_cv_generator/pages/elements/elements.dart';
import 'package:ai_cv_generator/pages/employmentView.dart';
import 'package:flutter/material.dart';
import 'pdf_window.dart';
import 'linksView.dart';
import 'qualificationsView.dart';
import 'elements/elements.dart';

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
    
    TextEditingController fnameC = TextEditingController(text: model.fname);
    TextEditingController lnameC = TextEditingController(text: model.lname);
    TextEditingController emailC = TextEditingController(text: model.email);
    TextEditingController phoneNoC = TextEditingController(text: model.phoneNumber);
    TextEditingController locationC = TextEditingController(text: model.location);
    TextEditingController descripC = TextEditingController(text: model.description);
    GlobalKey<LinksSectionState> linksKey = GlobalKey<LinksSectionState>();
    GlobalKey<QualificationsSectionState> qualificationsKey = GlobalKey<QualificationsSectionState>();
    GlobalKey<EmploymentSectionState> employhistoryKey = GlobalKey<EmploymentSectionState>();
    LinksSection linkC = LinksSection(key: linksKey, links: model.links != null ? model.links! : []);
    QualificationsSection qualificationsC = QualificationsSection(key: qualificationsKey, qualifications: model.qualifications != null ? model.qualifications! : []);
    EmploymentSection employmentC = EmploymentSection(key: employhistoryKey, employment: model.employmenthistory != null ? model.employmenthistory! : [Employment(company: 'ERROR', title: 'ERORR', startdate: DateTime.now(), enddate: DateTime.now(), empid: 0)]);

    DateTime time = DateTime.now();
    void ActualUpdate() {
      print("Actual Update");
      model.fname = fnameC.text;
      model.lname = lnameC.text;
      model.email = emailC.text;
      model.phoneNumber = phoneNoC.text;
      model.description = descripC.text;
      model.location = locationC.text;
      linksKey.currentState?.update();
      qualificationsKey.currentState?.update();
      employhistoryKey.currentState?.update();
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
      actions: [
        IconButton(onPressed: () {}, 
        icon: const Icon(Icons.account_circle, size: profileButtonSize,)),
        SizedBox(width: 16,)
      ],
      ),
      body: SafeArea(
        child: Container( 
        color: Colors.white,
          child: Form(
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
                          SectionContainer(
                            child: Column(
                              children: [
                                SectionHeading(text: "ABOUT ME", alignment: Alignment.topLeft,),
                                SectionInput(inputWidget: TextFormField(controller: descripC, maxLines: 5, style: TextStyle(fontSize: 16), decoration: const InputDecoration(border: OutlineInputBorder(), hintText: "INSERT A DESCRIPTION ABOUT YOURSELF"),),),
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
                  
                    const SizedBox(width: 48,),
                  
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SectionHeading(text: "PROFILE", alignment: Alignment.topRight,),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                icon: Icon(Icons.account_circle, size: 128,),
                                onPressed: () {
                                  
                                },
                              ),

                              SizedBox(
                                width: 300,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SectionInput(inputWidget: TextFormField(controller: fnameC, textAlign: TextAlign.right, style: TextStyle(fontSize: 20), decoration: const InputDecoration(border: InputBorder.none, hintStyle: TextStyle(fontSize: 16), hintText: "INSERT FIRSTNAME"),),),
                                    SectionInput(inputWidget: TextFormField(controller: lnameC, textAlign: TextAlign.right, style: TextStyle(fontSize: 20), decoration: const InputDecoration(border: InputBorder.none, hintStyle: TextStyle(fontSize: 16), hintText: "INSERT LASTNAME"),),),
                                    SectionInput(inputWidget: TextFormField(controller: emailC, textAlign: TextAlign.right, style: TextStyle(fontSize: 20), decoration: const InputDecoration(border: InputBorder.none, hintStyle: TextStyle(fontSize: 16), hintText: "INSERT EMAIL"),),),
                                    SectionInput(inputWidget: TextFormField(controller: locationC, textAlign: TextAlign.right, style: TextStyle(fontSize: 20), decoration: const InputDecoration(border: InputBorder.none, hintStyle: TextStyle(fontSize: 16), hintText: "INSERT ADDRESS"),),),
                                    SectionInput(inputWidget: TextFormField(controller: phoneNoC, textAlign: TextAlign.right, style: TextStyle(fontSize: 20), decoration: const InputDecoration(border: InputBorder.none, hintStyle: TextStyle(fontSize: 16), hintText: "INSERT PHONENUMBER"),),),
                                  ],
                                ),
                              )
                            ]
                          ),
                          const SizedBox(height: 16,),
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
  final BuildContext context;
  const CVHistory({super.key, required this.context});

  @override
  CVHistoryState createState() => CVHistoryState();
}

class CVHistoryState extends State<CVHistory> {
  List<Widget> list = [];

  @override
  void initState() {
    FileApi.getFiles().then((value) {
      value!.forEach((element) {
        list.add(add(element.filename));
      });
        setState(() {
      });
    });
    super.initState();
  }

  Widget add(String filename,) {
    return OutlinedButton(
        onPressed: ()  {
          FileApi.requestFile(filename: filename).then((value) {
            showDialog(
              context: widget.context,
              builder: (context) {
                return Dialog(
                  child: PdfWindow(file: value,)
                );
            });
          });

        },
        child: Text(filename),
    );
  }

  // void add(Uint8List cover) {
  //   images.add(
  //     Image.memory(cover)
  //   );
  //   setState(() {
      
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ...list,
            ], 
        )
      )
    );
  }
}