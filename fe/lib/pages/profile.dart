
import 'package:ai_cv_generator/dio/client/fileApi.dart';
import 'package:ai_cv_generator/dio/client/userApi.dart';
import 'package:ai_cv_generator/models/user/Employment.dart';
import 'package:ai_cv_generator/models/user/UserModel.dart';
import 'package:ai_cv_generator/pages/employmentView.dart';
// import 'package:ai_cv_generator/models/user/link.dart';
import 'package:flutter/material.dart';
import 'pdf_window.dart';
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
  Image? image;
  ProfileState({
    required this.model
  });

  @override
  Widget build(BuildContext context) {
    String email =  model.email != null ? model.email! : "No email...";
    String phoneNumber =  model.phoneNumber != null? model.phoneNumber!:"No phone number...";
    String location = model.location != null ? model.location!:"No location...";
    String aboutMe = model.description!= null? model.description!:"No description...";
    String workExperience = "";
    String education = "";
    Image img = image!;
    TextEditingController fnameC = TextEditingController(text: model.fname);
    TextEditingController lnameC = TextEditingController(text: model.lname);
    TextEditingController emailC = TextEditingController(text: email);
    TextEditingController phoneNoC = TextEditingController(text: phoneNumber);
    TextEditingController locationC = TextEditingController(text: location);
    TextEditingController descripC = TextEditingController(text: aboutMe);
    TextEditingController qualificationC = TextEditingController();
    TextEditingController workExperienceC = TextEditingController();
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
    workExperienceC.addListener(update);
    qualificationC.addListener(update);

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
                      Column(
                        children: [
                          const SectionHeading(heading: "WORK EXPERIENCE"),
                          employmentC,
                        ],
                      ),

                      Column(
                        children: [
                          const SectionHeading(heading: "CVs", align: Alignment.topLeft,),
                          CVHistory(context: context,),
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

class SectionDuplicate extends StatefulWidget {
  Widget target;
  SectionDuplicate({super.key, required this.target});

  @override
  SectionDuplicateState createState() => SectionDuplicateState();
}

class SectionDuplicateState extends State<SectionDuplicate> {
  List<Widget> widgets = [];
  
  void remove(int index) {
      print(widgets);
      widgets.removeAt(index);
      setState(() {
      });
    }

  void add() {
    int index = widgets.length;
    widgets.add(
      Column(
        children: [
          const SizedBox(height: 16,),
          widget.target,
          const SizedBox(height: 16,),
          Align(
            alignment: Alignment.topRight,
            child: OutlinedButton(
              onPressed: (){
                remove(index);
              }, 
              child: const Text("-"),),
          )
        ],
      )
    );
    setState(() {
    });
  }

  @override
  Widget build(BuildContext build) {
    return Column(
      children: [
        ...widgets,
        const SizedBox(height: 8,),
        OutlinedButton(onPressed: (){add();}, child: const Text("+")),
        const SizedBox(height: 16,),
      ]
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
      for (var element in value!) {
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
    return SizedBox(
      height: 200, 
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