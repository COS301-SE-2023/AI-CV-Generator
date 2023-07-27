

import 'package:ai_cv_generator/dio/client/fileApi.dart';
import 'package:ai_cv_generator/dio/client/userApi.dart';
import 'package:ai_cv_generator/models/user/Employment.dart';
import 'package:ai_cv_generator/models/user/UserModel.dart';
import 'package:ai_cv_generator/pages/elements/elements.dart';
import 'package:ai_cv_generator/pages/employmentView.dart';
import 'package:ai_cv_generator/pages/loadingScreen.dart';
import 'package:flutter/material.dart';
import 'pdf_window.dart';
import 'linksView.dart';
import 'qualificationsView.dart';
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
    void actualupdate() {
      model!.fname = fnameC.text;
      model!.lname = lnameC.text;
      model!.email = emailC.text;
      model!.phoneNumber = phoneNoC.text;
      model!.description = descripC.text;
      model!.location = locationC.text;
      linksKey.currentState?.update();
      qualificationsKey.currentState?.update();
      employhistoryKey.currentState?.update();
      userApi.updateUser(user: model!);
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
          onPressed: () { 
            actualupdate();
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
                          const SizedBox(height: 178,),
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
                                    hintText: "INSERT A DESCRIPTION ABOUT YOURSELF"
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
                                final imgByte =  await ImagePickerWeb.getImageAsBytes();
                                if(imgByte != null){
                                  final changed = await FileApi.updateProfileImage(img: imgByte);
                                  image = changed;
                                  setState(() {});
                                }
                              },
                              child: CircleAvatar(
                                radius: 65.0,
                                backgroundColor: Theme.of(context).colorScheme.secondary,
                                child: CircleAvatar(
                                  radius: 60.0,
                                  backgroundImage: image!.image,
                                ),
                              ),
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              Expanded(
                                flex: 2,
                                child: SizedBox(
                                  width: 300,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SectionInput(controller: fnameC, hint: "FIRST NAME", fontSize: 32,),
                                      const SizedBox(width: 4,),
                                      SectionInput(controller: lnameC, hint: "LAST NAME", fontSize: 32,),
                                      SectionInput(controller: emailC, hint: "EMAIL"),
                                      SectionInput(controller: locationC, hint: "ADDRESS"),
                                      SectionInput(controller: phoneNoC, hint: "PHONE NUMBER"),
                                    ],
                                  ),
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
      for (var element in value!) {
        //paint_.decodeImageFromPixels(element.cover,20,20,paint_.PixelFormat.rgba8888, (result) {list.add(RawImage(image: result,)); setState(() {
          
        list.add(add(element.filename));
      }
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