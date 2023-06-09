import 'package:ai_cv_generator/dio/client/userApi.dart';
import 'package:ai_cv_generator/models/user/UserModel.dart';
import 'package:ai_cv_generator/pages/inputField.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  Profile({super.key,required this.id,required this.model});
  String id;
  UserModel model;


  @override
  ProfileState createState() => ProfileState(id:id,model: model);
}

bool isEditingEnabled = false;

class ProfileState extends State<Profile> {
  final _formKey = GlobalKey<FormState>();
  UserModel model;
  String id;

  ProfileState({
    required this.id,
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
    final details = model.details;
    if (details != null) {
      for (int n=0; n <details.employhistory.employHis.length; n++) {
        workExperience += "${details.employhistory.employHis[n].company} ";
        workExperience += "${details.employhistory.employHis[n].title} ";
        workExperience += "${details.employhistory.employHis[n].start_date}-";
        workExperience += "${details.employhistory.employHis[n].end_date}\n";
      }
      if (details.employhistory.employHis.isEmpty) workExperience = "No Work expierience listed...";
      for (int n=0; n<details.qualifications.qualifications.length; n++) {
        education += "${details.qualifications.qualifications[n].qualification} ";
        education += "${details.qualifications.qualifications[n].instatution} ";
        education += "${details.qualifications.qualifications[n].date.toString()}\n";
      }
      if (details.qualifications.qualifications.isEmpty) education = "No education listed...";
    } else {
      education = "No education listed...";
      workExperience = "No Work expierience listed...";
    }

    String links = "Not ready yet";
    TextEditingController fnameC = TextEditingController(text: model.fname);
    TextEditingController lnameC = TextEditingController(text: model.lname);
    TextEditingController emailC = TextEditingController(text: email);
    TextEditingController phoneNoC = TextEditingController(text: phoneNumber);
    TextEditingController locationC = TextEditingController(text: location);
    TextEditingController descripC = TextEditingController(text: aboutMe);
    TextEditingController workExperienceC = TextEditingController();
    TextEditingController qualificationC = TextEditingController();
    TextEditingController linksC = TextEditingController();
    DateTime time = DateTime.now();
    void ActualUpdate() {
      print("Actual Update");
      model.fname = fnameC.text;
      model.lname = lnameC.text;
      model.email = emailC.text;
      model.phoneNumber = phoneNoC.text;
      model.description = descripC.text;
      model.location = locationC.text;
      // Will do the rest when I figure out their inputs

      userApi.updateUser(user: model, id: id);
    }
    void update() {
        DateTime nTime = DateTime.now();
        if (nTime.second - time.second > 10) {
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
    linksC.addListener(update);

    
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
          padding: const EdgeInsets.symmetric(vertical: 42, horizontal: 42),
          child: Form(
            key: _formKey,
            child: Row(
              children: [

                Expanded(
                  flex: 2,
                  child: ListView(
                    children: [

                      Column(
                        children: [
                          SectionHeading(heading: "ABOUT ME", align: Alignment.topLeft,),
                          SectionInput(inputWidget: TextFormField(controller: descripC, maxLines: 9,),),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Column(
                        children: [
                          SectionHeading(heading: "WORK EXPERIENCE"),
                          SectionInput(inputWidget: TextFormField(controller: workExperienceC, maxLines: 9,),),
                        ],
                      ),

                    ],
                  ),
                ),
                
                SizedBox(width: 15,),
                
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                          SectionHeading(heading: "PERSONAL DETAILS", align: Alignment.topRight,),
                          SectionInput(inputWidget: TextInputField(editor: fnameC),),
                          SectionInput(inputWidget: TextFormField(controller: lnameC, textAlign: TextAlign.right,),),
                          SectionInput(inputWidget: TextFormField(controller: emailC, textAlign: TextAlign.right,),),
                          SectionInput(inputWidget: TextFormField(controller: phoneNoC, textAlign: TextAlign.right,),),
                          SectionInput(inputWidget: TextFormField(controller: locationC, textAlign: TextAlign.right,),),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                          SectionHeading(heading: "EDUCATION"),
                          SectionInput(inputWidget: TextFormField(controller: qualificationC,),),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                          SectionHeading(heading: "LINKS"),
                          SectionInput(inputWidget: TextFormField(controller: linksC,),),
                          ],
                        ),
                      ),
                    ],
                  )
                ),

              ],
            ),
          )
        // child: Form(
        //   key: _formKey,
        //   child: ListView(
        //     children: [
        //       const CircleAvatar(
        //         radius: 50,
        //         // backgroundImage: AssetImage(imagePath),
        //         backgroundColor: Colors.blue,
        //       ),
        //       const SizedBox(height: 16,),
        //       Container(
        //         padding: const EdgeInsets.symmetric(horizontal: 10.0),
        //         child: OutlinedButton(
        //           onPressed: () {
        //             _formKey.currentState!.save();
        //             setState(() {
        //               isEditingEnabled = false;
        //             });
        //             ActualUpdate();
        //           }, 
        //           child: const Text("SAVE")
        //         ) 
        //       ),
        //       const SizedBox(height: 8,),
        //       Container(
        //         padding: const EdgeInsets.symmetric(horizontal: 10.0),
        //         child: OutlinedButton(
        //           onPressed: () {
        //               setState(() {
        //               isEditingEnabled = true;
        //             });
        //           }, 
        //           child: const Text("EDIT")
        //         ) 
        //       ),
        //       const SizedBox(height: 16,),
        //       //InputField(label: "NAME", widgetField: TextFormField(enabled: isEditingEnabled, initialValue: model.fname, onSaved: (value)=>{model.fname=value!},)),
        //       inputField(editor: nameC , label: "Name"),
        //       const SizedBox(height: 16,),
        //       //InputField(label: "EMAIL", widgetField: TextFormField(enabled: isEditingEnabled, initialValue: email, onSaved: (value)=>{email=value!},)),
        //       inputField(editor: emailC, label: "EMAIL"),
        //       const SizedBox(height: 16,),
        //       //InputField(label: "PHONE NUMBER", widgetField: TextFormField(enabled: isEditingEnabled, initialValue: phoneNumber, onSaved: (value)=>{phoneNumber=value!},)),
        //       inputField(editor: phoneNoC, label: "PHONE No"),
        //       const SizedBox(height: 16,),
        //       //InputField(label: "LOCATION", widgetField: TextFormField(enabled: isEditingEnabled, initialValue: location, onSaved: (value)=>{location=value!},)),
        //       inputField(editor: locationC,label: "LOCATION",),
        //       const SizedBox(height: 16,),
        //       InputField(label: "ABOUT ME", widgetField: TextFormField(controller: descripC, maxLines: 10,)),
        //       const SizedBox(height: 16,),
        //       InputField(label: "EDUCATION", widgetField: TextFormField(controller: qualificationC, maxLines: 10,)),
        //       //inputArray(editor: qualificationC),
        //       const SizedBox(height: 16,),
        //       InputField(label: "WORK EXPERIENCE", widgetField: TextFormField(controller: workExperienceC, maxLines: 10,)),
        //       const SizedBox(height: 16,),
        //       InputField(label: "LINKS", widgetField: TextFormField(enabled: isEditingEnabled, initialValue: links, onSaved: (value)=>{links=value!}, maxLines: 10,)),
        //       const SizedBox(height: 16,),
        //     ],
        //   )
        // )
        )
      )
    );
  }
}

class SectionHeading extends StatelessWidget {
  final String heading;
  final Alignment? align;
  SectionHeading({required this.heading, this.align});

  @override
  Widget build(BuildContext context) {

    return Align(
      alignment: align != null? align!: Alignment.topLeft,
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              heading,
              style: TextStyle(
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
  const SectionInput({required this.inputWidget});
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
  const TextInputField({required this.editor});
  @override
  TextInputFieldState createState() => TextInputFieldState();
}

class TextInputFieldState extends State<TextInputField> {
  @override
  Widget build(BuildContext context) {
    TextEditingController editor = widget.editor;
    return TextFormField(
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
