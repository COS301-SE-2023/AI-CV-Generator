import 'package:ai_cv_generator/dio/client/userApi.dart';
import 'package:ai_cv_generator/models/user/Employment.dart';
import 'package:ai_cv_generator/models/user/Link.dart';
import 'package:ai_cv_generator/models/user/Qualification.dart';
import 'package:ai_cv_generator/models/user/UserModel.dart';
// import 'package:ai_cv_generator/models/user/link.dart';
import 'package:flutter/material.dart';
import 'linksView.dart';

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
    Employment employmentData = Employment(company: "company", title: "title", start_date: DateTime.now(), end_date: DateTime.now(), empid: 0);

    String email =  model.email != null ? model.email! : "No email...";
    String phoneNumber =  model.phoneNumber != null? model.phoneNumber!:"No phone number...";
    String location = model.location != null ? model.location!:"No location...";
    String aboutMe = model.description!= null? model.description!:"No description...";
    String workExperience = "";
    String education = "";
    List<Employment>? employhistory = model.employhistory;
    if (employhistory != null)
    for (int n=0; n <employhistory.length; n++) {
      workExperience += "${employhistory[n].company} ";
      workExperience += "${employhistory[n].title} ";
      workExperience += "${employhistory[n].start_date}-";
      workExperience += "${employhistory[n].end_date}\n";
    }
    if (employhistory == null || employhistory.isEmpty) workExperience = "No Work expierience listed...";
    List<Qualification>? qualifications = model.qualifications;
    if (qualifications!= null)
    for (int n=0; n<qualifications.length; n++) {
      education += "${qualifications[n].qualification} ";
      education += "${qualifications[n].instatution} ";
      education += "${qualifications[n].date.toString()}\n";
    }
    if (qualifications== null || qualifications.isEmpty) education = "No education listed...";
    
    TextEditingController fnameC = TextEditingController(text: model.fname);
    TextEditingController lnameC = TextEditingController(text: model.lname);
    TextEditingController emailC = TextEditingController(text: email);
    TextEditingController phoneNoC = TextEditingController(text: phoneNumber);
    TextEditingController locationC = TextEditingController(text: location);
    TextEditingController descripC = TextEditingController(text: aboutMe);
    TextEditingController qualificationC = TextEditingController();
    TextEditingController workExperienceC = TextEditingController();

    GlobalKey<LinksSectionState> linksKey = GlobalKey<LinksSectionState>();
    LinksSection linkC = LinksSection(key: linksKey, links: model.links != null ? model.links! : []);

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
                          SectionDuplicate(target: SectionInput(inputWidget: TextFormField(controller: descripC, maxLines: 9, decoration: const InputDecoration(border: OutlineInputBorder(),),),),),
                          // SectionInput(inputWidget: TextFormField(controller: qualificationC, maxLines: 9,),),
                        ],
                      ),
                      const SizedBox(height: 10,),
                      Column(
                        children: [
                          const SectionHeading(heading: "WORK EXPERIENCE"),
                          SectionInput(inputWidget: TextFormField(controller: workExperienceC, maxLines: 9, decoration: const InputDecoration(border: OutlineInputBorder(),),),),
                        ],
                      ),

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

class Links extends StatefulWidget {
  List links;
  Links({super.key, required this.links});

  @override
  LinksState createState() => LinksState();
}

class LinksState extends State<Links> {
  Map data = {};
  TextEditingController linkName = TextEditingController();
  TextEditingController linkURL = TextEditingController();

  @override
  void initState() {
    // save();
    super.initState();
  }

  // void save() {
  //   data[widget.id] = {
  //     "linkName": linkName.text,
  //     "linkURL": linkURL.text
  //   };
  // }

  void remove(int id) {
    data.remove(id);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            child: SectionInput(
              inputWidget: TextFormField(
              controller: linkName, 
              textAlign: TextAlign.right,
              onEditingComplete:() {
                // save();
              },
              decoration: const InputDecoration(border: OutlineInputBorder(),),
              ),
              ),
            ),
        ),
          const SizedBox(width: 10,),
          Expanded(
            child: Container(
              child: SectionInput(
                inputWidget: TextFormField(
                controller: linkURL,
                textAlign: TextAlign.right,
                onEditingComplete:() {
                  // save();
                },
                decoration: const InputDecoration(border: OutlineInputBorder(),),),
              ),
            )
          )
      ],
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
  @override
  Widget build(BuildContext context) {
    return const SizedBox(height: 200, child:
    SingleChildScrollView(child: 
    Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          //testing containers
          // SizedBox(width: 150, height: 200, child: Container(color: Colors.green),),
          // SizedBox(width: 150, height: 200, child: Container(color: Colors.blue),),
          // SizedBox(width: 150, height: 200, child: Container(color: Colors.green),),
          // SizedBox(width: 150, height: 200, child: Container(color: Colors.blue),),
          // SizedBox(width: 150, height: 200, child: Container(color: Colors.purple),),
          // SizedBox(width: 150, height: 200, child: Container(color: Colors.green),),
          // SizedBox(width: 150, height: 200, child: Container(color: Colors.blue),),
          // SizedBox(width: 150, height: 200, child: Container(color: Colors.green),),
          // SizedBox(width: 150, height: 200, child: Container(color: Colors.yellow),),
          // SizedBox(width: 150, height: 200, child: Container(color: Colors.green),),
          // SizedBox(width: 150, height: 200, child: Container(color: Colors.blue),),
          // SizedBox(width: 150, height: 200, child: Container(color: Colors.green),),
        ], 
    )));
  }
}